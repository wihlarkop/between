use crate::domain::activity::entity::UserActivity;
use crate::domain::activity::repository::ActivityRepositoryTrait;
use crate::domain::context::repository::ContextRepositoryTrait;
use crate::domain::silence::repository::SilenceSessionRepositoryTrait;
use crate::domain::silence::session::{SilenceSession, MAX_DURATION_SECONDS, MIN_DURATION_SECONDS};
use crate::shared::error::{error_messages, BetweenError, Result};
use crate::shared::schema::context::{ContextItem, ContextListResponse};
use crate::shared::schema::silence::{
    AttachContextRequest, AttachContextResponse, EndSessionRequest, EndSessionResponse,
    SessionItem, SessionListResponse, SessionStatsResponse, StartSessionResponse,
};
use async_trait::async_trait;
use chrono::{DateTime, Utc};
use chrono_tz::Tz;
use std::sync::Arc;
use uuid::Uuid;

#[async_trait]
pub trait SilenceSessionServiceTrait: Send + Sync {
    async fn start_session(
        &self,
        user_id: Uuid,
        user_timezone: &str,
    ) -> Result<StartSessionResponse>;

    async fn end_session(
        &self,
        user_id: Uuid,
        user_timezone: &str,
        request: EndSessionRequest,
    ) -> Result<EndSessionResponse>;

    async fn get_sessions(
        &self,
        user_id: Uuid,
        user_timezone: &str,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
    ) -> Result<(SessionListResponse, u64)>;

    async fn attach_context(
        &self,
        session_id: Uuid,
        user_id: Uuid,
        request: AttachContextRequest,
    ) -> Result<AttachContextResponse>;

    async fn get_stats(&self, user_id: Uuid) -> Result<SessionStatsResponse>;

    async fn get_contexts(&self) -> Result<ContextListResponse>;
}

pub struct SilenceSessionService<R: SilenceSessionRepositoryTrait> {
    session_repo: R,
    context_repo: Arc<dyn ContextRepositoryTrait>,
    activity_repo: Arc<dyn ActivityRepositoryTrait>,
}

impl<R: SilenceSessionRepositoryTrait> SilenceSessionService<R> {
    pub fn new(
        session_repo: R,
        context_repo: Arc<dyn ContextRepositoryTrait>,
        activity_repo: Arc<dyn ActivityRepositoryTrait>,
    ) -> Self {
        Self {
            session_repo,
            context_repo,
            activity_repo,
        }
    }

    fn to_local_time(&self, utc_time: DateTime<Utc>, timezone: &str) -> Result<String> {
        let tz: Tz = timezone
            .parse()
            .map_err(|_| BetweenError::BadRequest(format!("Invalid timezone: {}", timezone)))?;
        let local_time = utc_time.with_timezone(&tz);
        Ok(local_time.to_rfc3339())
    }
}

#[async_trait]
impl<R: SilenceSessionRepositoryTrait + Send + Sync> SilenceSessionServiceTrait
    for SilenceSessionService<R>
{
    async fn start_session(
        &self,
        user_id: Uuid,
        user_timezone: &str,
    ) -> Result<StartSessionResponse> {
        // Check if user already has an active session
        if let Some(_active) = self.session_repo.find_active_session(user_id).await? {
            return Err(BetweenError::Conflict(
                error_messages::ACTIVE_SESSION_EXISTS.to_string(),
            ));
        }

        // Create new session
        let session = SilenceSession {
            id: Uuid::new_v4(),
            user_id,
            started_at: Utc::now(),
            ended_at: None,
            duration_seconds: None,
            context_code: None,
            context_note: None,
            termination_reason: None,
            created_at: Utc::now(),
        };

        let created = self.session_repo.create(session).await?;

        // DUAL WRITE: Create activity record
        let activity = UserActivity::new_from_silence(
            created.user_id,
            created.id,
            created.started_at,
            None,
            None,
            None,
            None,
            None,
        );
        self.activity_repo.create(activity).await?;

        Ok(StartSessionResponse {
            id: created.id,
            user_id: created.user_id,
            started_at: created.started_at,
            started_at_local: self.to_local_time(created.started_at, user_timezone)?,
            status: "active".to_string(),
        })
    }

    async fn end_session(
        &self,
        user_id: Uuid,
        user_timezone: &str,
        request: EndSessionRequest,
    ) -> Result<EndSessionResponse> {
        // Find active session
        let mut session = self
            .session_repo
            .find_active_session(user_id)
            .await?
            .ok_or_else(|| BetweenError::NotFound(error_messages::NO_ACTIVE_SESSION.to_string()))?;

        let ended_at = Utc::now();
        let duration_seconds = (ended_at - session.started_at).num_seconds() as i32;

        // Validate duration
        if duration_seconds < MIN_DURATION_SECONDS {
            return Err(BetweenError::BadRequest(format!(
                "Session duration must be at least {} seconds",
                MIN_DURATION_SECONDS
            )));
        }

        if duration_seconds > MAX_DURATION_SECONDS {
            return Err(BetweenError::BadRequest(format!(
                "Session duration cannot exceed {} seconds (6 hours)",
                MAX_DURATION_SECONDS
            )));
        }

        // Update session
        session.ended_at = Some(ended_at);
        session.duration_seconds = Some(duration_seconds);
        session.termination_reason = request.termination_reason;

        let updated = self.session_repo.update(session).await?;

        // DUAL WRITE: Update activity record
        if let Some(mut activity) = self
            .activity_repo
            .find_by_module_session_id("silence", updated.id)
            .await?
        {
            activity.ended_at = updated.ended_at;
            activity.duration_seconds = updated.duration_seconds;

            // Update metadata with termination_reason
            if let Some(reason) = &updated.termination_reason {
                let mut metadata = activity
                    .metadata
                    .and_then(|m| m.as_object().cloned())
                    .unwrap_or_default();
                metadata.insert(
                    "termination_reason".to_string(),
                    serde_json::Value::String(reason.clone()),
                );
                activity.metadata = Some(serde_json::Value::Object(metadata));
            }

            self.activity_repo.update(activity).await?;
        }

        Ok(EndSessionResponse {
            id: updated.id,
            user_id: updated.user_id,
            started_at: updated.started_at,
            started_at_local: self.to_local_time(updated.started_at, user_timezone)?,
            ended_at: updated.ended_at.unwrap(),
            ended_at_local: self.to_local_time(updated.ended_at.unwrap(), user_timezone)?,
            duration_seconds: updated.duration_seconds.unwrap(),
            termination_reason: updated.termination_reason,
            status: "completed".to_string(),
        })
    }

    async fn get_sessions(
        &self,
        user_id: Uuid,
        user_timezone: &str,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
    ) -> Result<(SessionListResponse, u64)> {
        let (sessions, total) = self
            .session_repo
            .find_sessions_paginated(user_id, page, limit, from_date, to_date)
            .await?;

        let session_items: Vec<SessionItem> = sessions
            .into_iter()
            .map(|s| {
                Ok(SessionItem {
                    id: s.id,
                    started_at: s.started_at,
                    started_at_local: self.to_local_time(s.started_at, user_timezone)?,
                    ended_at: s.ended_at.unwrap(),
                    ended_at_local: self.to_local_time(s.ended_at.unwrap(), user_timezone)?,
                    duration_seconds: s.duration_seconds.unwrap(),
                    termination_reason: s.termination_reason,
                    context_code: s.context_code,
                    context_label: s.context_label,
                    context_note: s.context_note,
                })
            })
            .collect::<Result<Vec<_>>>()?;

        Ok((
            SessionListResponse {
                sessions: session_items,
            },
            total,
        ))
    }

    async fn attach_context(
        &self,
        session_id: Uuid,
        user_id: Uuid,
        request: AttachContextRequest,
    ) -> Result<AttachContextResponse> {
        // Verify context code exists
        if !self
            .context_repo
            .verify_context_code(request.context_code, Some("silence".to_string()))
            .await?
        {
            return Err(BetweenError::BadRequest(format!(
                "{}: {}",
                error_messages::INVALID_CONTEXT_CODE,
                request.context_code
            )));
        }

        // Find session and verify ownership
        let mut session = self
            .session_repo
            .find_by_id(session_id)
            .await?
            .ok_or_else(|| BetweenError::NotFound(error_messages::SESSION_NOT_FOUND.to_string()))?;

        if session.user_id != user_id {
            return Err(BetweenError::Forbidden(
                "You don't have permission to modify this session".to_string(),
            ));
        }

        // Cannot modify active sessions
        if session.is_active() {
            return Err(BetweenError::BadRequest(
                "Cannot attach context to active session".to_string(),
            ));
        }

        // Update session
        session.context_code = Some(request.context_code);
        session.context_note = request.context_note.clone();

        self.session_repo.update(session).await?;

        // DUAL WRITE: Update activity context
        if let Some(mut activity) = self
            .activity_repo
            .find_by_module_session_id("silence", session_id)
            .await?
        {
            activity.context_code = Some(request.context_code);

            // Update metadata with context_note
            if let Some(note) = &request.context_note {
                let mut metadata = activity
                    .metadata
                    .and_then(|m| m.as_object().cloned())
                    .unwrap_or_default();
                metadata.insert(
                    "context_note".to_string(),
                    serde_json::Value::String(note.clone()),
                );
                activity.metadata = Some(serde_json::Value::Object(metadata));
            }

            self.activity_repo.update(activity).await?;
        }

        // Get context label (hardcoded for now based on code)
        let context_label = match request.context_code {
            1 => "alone",
            2 => "waiting",
            3 => "walking",
            4 => "thinking",
            5 => "empty",
            _ => "unknown",
        }
        .to_string();

        Ok(AttachContextResponse {
            context_code: request.context_code,
            context_label,
            context_note: request.context_note,
        })
    }

    async fn get_stats(&self, user_id: Uuid) -> Result<SessionStatsResponse> {
        use crate::shared::schema::silence::{ContextCount, DayCount, HourCount};

        let stats = self.session_repo.get_user_stats(user_id).await?;

        let most_common_context = stats
            .most_common_context
            .map(|(code, label, count)| ContextCount { code, label, count });

        let sessions_by_hour = stats
            .sessions_by_hour
            .into_iter()
            .map(|(hour, count)| HourCount { hour, count })
            .collect();

        let sessions_by_day = stats
            .sessions_by_day
            .into_iter()
            .map(|(day, count)| DayCount { day, count })
            .collect();

        Ok(SessionStatsResponse {
            total_sessions: stats.total_sessions as u64,
            total_duration_seconds: stats.total_duration_seconds,
            average_duration_seconds: stats.average_duration_seconds,
            longest_session_seconds: stats.longest_session_seconds,
            shortest_session_seconds: stats.shortest_session_seconds,
            most_common_context,
            sessions_by_hour,
            sessions_by_day,
        })
    }

    async fn get_contexts(&self) -> Result<ContextListResponse> {
        let contexts = self
            .context_repo
            .get_contexts(Some("silence".to_string()))
            .await?;
        let context_items: Vec<ContextItem> = contexts
            .into_iter()
            .map(|c| ContextItem {
                code: c.code,
                label: c.label,
                module: c.module,
            })
            .collect();

        Ok(ContextListResponse {
            contexts: context_items,
        })
    }
}
