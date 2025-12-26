use chrono::{DateTime, Utc};
use serde::Deserialize;
use std::sync::Arc;
use uuid::Uuid;

use crate::domain::activity::entity::UserActivity;
use crate::domain::activity::repository::ActivityRepositoryTrait;
use crate::domain::context::repository::ContextRepositoryTrait;
use crate::domain::decision::entity::{Decision, MAX_TEXT_FIELD_LENGTH, MAX_TITLE_LENGTH, MIN_TITLE_LENGTH};
use crate::domain::decision::repository::{DecisionRepositoryTrait, DecisionStats};
use crate::shared::error::{BetweenError, Result};

pub struct DecisionService {
    decision_repo: Arc<dyn DecisionRepositoryTrait>,
    context_repo: Arc<dyn ContextRepositoryTrait>,
    activity_repo: Arc<dyn ActivityRepositoryTrait>,
}

impl DecisionService {
    pub fn new(
        decision_repo: Arc<dyn DecisionRepositoryTrait>,
        context_repo: Arc<dyn ContextRepositoryTrait>,
        activity_repo: Arc<dyn ActivityRepositoryTrait>,
    ) -> Self {
        Self {
            decision_repo,
            context_repo,
            activity_repo,
        }
    }

    /// Create a new decision
    pub async fn create_decision(&self, user_id: Uuid, request: CreateDecisionRequest) -> Result<Decision> {
        // Validate title
        if request.title.len() < MIN_TITLE_LENGTH || request.title.len() > MAX_TITLE_LENGTH {
            return Err(BetweenError::BadRequest(format!(
                "Title must be between {} and {} characters",
                MIN_TITLE_LENGTH, MAX_TITLE_LENGTH
            )));
        }

        // Validate text fields
        self.validate_text_field(&request.reason, "Reason")?;
        self.validate_text_field(&request.expectation, "Expectation")?;
        self.validate_text_field(&request.actual_result, "Actual result")?;
        self.validate_text_field(&request.learnings, "Learnings")?;

        // Validate context code if provided
        if let Some(code) = request.context_code {
            let valid = self
                .context_repo
                .verify_context_code(code, Some("decision".to_string()))
                .await?;
            if !valid {
                return Err(BetweenError::BadRequest(format!(
                    "Invalid context code: {}",
                    code
                )));
            }
        }

        // Validate at least one date is provided
        if request.decided_at.is_none() && request.completed_at.is_none() {
            return Err(BetweenError::BadRequest(
                "Either decided_at or completed_at must be provided".to_string(),
            ));
        }

        // Validate completed_at is after decided_at if both provided
        if let (Some(decided), Some(completed)) = (request.decided_at, request.completed_at) {
            if completed < decided {
                return Err(BetweenError::BadRequest(
                    "completed_at must be after decided_at".to_string(),
                ));
            }
        }

        let decision = Decision {
            id: Uuid::new_v4(),
            user_id,
            title: request.title.clone(),
            decided_at: request.decided_at,
            reason: request.reason,
            expectation: request.expectation,
            completed_at: request.completed_at,
            actual_result: request.actual_result,
            learnings: request.learnings,
            context_code: request.context_code,
            tags: request.tags.clone(),
            created_at: Utc::now(),
        };

        // Create the decision
        let created_decision = self.decision_repo.create(decision).await?;

        // Calculate duration based on decision type
        let (started_at, ended_at, duration_seconds) = match (created_decision.decided_at, created_decision.completed_at) {
            (Some(decided), Some(completed)) => {
                // Completed: duration from decided to completed
                let duration = completed.signed_duration_since(decided).num_seconds() as i32;
                (decided, Some(completed), Some(duration))
            }
            (None, Some(completed)) => {
                // Quick: instant decision
                // Ensure ended_at > started_at to satisfy check constraint
                let start = if completed <= created_decision.created_at {
                    completed
                } else {
                    created_decision.created_at
                };
                let end = if completed <= created_decision.created_at {
                    created_decision.created_at
                } else {
                    completed
                };
                let duration = end.signed_duration_since(start).num_seconds() as i32;
                // Ensure duration > 0 to satisfy check constraint
                let valid_duration = if duration <= 0 { 1 } else { duration };
                (start, Some(end), Some(valid_duration))
            }
            (Some(decided), None) => {
                // Pending: no duration yet
                (decided, None, None)
            }
            (None, None) => {
                // Shouldn't happen due to validation, but handle it
                (created_decision.created_at, None, None)
            }
        };

        // Create activity record for the decision
        let activity = UserActivity::new_from_decision(
            user_id,
            created_decision.id,
            started_at,
            ended_at,
            duration_seconds,
            created_decision.context_code,
            Some(request.title),
            request.tags,
        );

        // Insert activity into user_activities table
        self.activity_repo.create(activity).await?;

        Ok(created_decision)
    }

    /// Update existing decision (e.g., add outcome to pending decision)
    pub async fn update_decision(
        &self,
        decision_id: Uuid,
        user_id: Uuid,
        request: UpdateDecisionRequest,
    ) -> Result<Decision> {
        // Find decision and verify ownership
        let mut decision = self
            .decision_repo
            .find_by_id(decision_id)
            .await?
            .ok_or_else(|| BetweenError::NotFound("Decision not found".to_string()))?;

        if decision.user_id != user_id {
            return Err(BetweenError::Forbidden(
                "You don't have permission to modify this decision".to_string(),
            ));
        }

        // Update fields if provided
        if let Some(title) = request.title {
            if title.len() < MIN_TITLE_LENGTH || title.len() > MAX_TITLE_LENGTH {
                return Err(BetweenError::BadRequest(format!(
                    "Title must be between {} and {} characters",
                    MIN_TITLE_LENGTH, MAX_TITLE_LENGTH
                )));
            }
            decision.title = title;
        }

        if let Some(decided_at) = request.decided_at {
            decision.decided_at = Some(decided_at);
        }

        if request.reason.is_some() {
            self.validate_text_field(&request.reason, "Reason")?;
            decision.reason = request.reason;
        }

        if request.expectation.is_some() {
            self.validate_text_field(&request.expectation, "Expectation")?;
            decision.expectation = request.expectation;
        }

        if let Some(completed_at) = request.completed_at {
            // Validate completed_at is after decided_at
            if let Some(decided) = decision.decided_at {
                if completed_at < decided {
                    return Err(BetweenError::BadRequest(
                        "completed_at must be after decided_at".to_string(),
                    ));
                }
            }
            decision.completed_at = Some(completed_at);
        }

        if request.actual_result.is_some() {
            self.validate_text_field(&request.actual_result, "Actual result")?;
            decision.actual_result = request.actual_result;
        }

        if request.learnings.is_some() {
            self.validate_text_field(&request.learnings, "Learnings")?;
            decision.learnings = request.learnings;
        }

        if let Some(context_code) = request.context_code {
            let valid = self
                .context_repo
                .verify_context_code(context_code, Some("decision".to_string()))
                .await?;
            if !valid {
                return Err(BetweenError::BadRequest(format!(
                    "Invalid context code: {}",
                    context_code
                )));
            }
            decision.context_code = Some(context_code);
        }

        if request.tags.is_some() {
            decision.tags = request.tags;
        }

        // Update the decision
        let updated_decision = self.decision_repo.update(decision).await?;

        // Update the corresponding activity record
        if let Some(activity) = self
            .activity_repo
            .find_by_module_session_id("decision", decision_id)
            .await?
        {
            // Calculate duration based on decision type
            let (started_at, ended_at, duration_seconds) = match (updated_decision.decided_at, updated_decision.completed_at) {
                (Some(decided), Some(completed)) => {
                    // Completed: duration from decided to completed
                    let duration = completed.signed_duration_since(decided).num_seconds() as i32;
                    (decided, Some(completed), Some(duration))
                }
                (None, Some(completed)) => {
                    // Quick: instant decision
                    // Ensure ended_at > started_at to satisfy check constraint
                    let start = if completed <= activity.started_at {
                        completed
                    } else {
                        activity.started_at
                    };
                    let end = if completed <= activity.started_at {
                        activity.started_at
                    } else {
                        completed
                    };
                    let duration = end.signed_duration_since(start).num_seconds() as i32;
                    // Ensure duration > 0 to satisfy check constraint
                    let valid_duration = if duration <= 0 { 1 } else { duration };
                    (start, Some(end), Some(valid_duration))
                }
                (Some(decided), None) => {
                    // Pending: no duration yet
                    (decided, None, None)
                }
                (None, None) => {
                    // Keep original
                    (activity.started_at, activity.ended_at, None)
                }
            };

            let updated_activity = UserActivity {
                id: activity.id,
                user_id: activity.user_id,
                module: activity.module,
                module_session_id: activity.module_session_id,
                started_at,
                ended_at,
                duration_seconds,
                context_code: updated_decision.context_code,
                metadata: activity.metadata,
                created_at: activity.created_at,
            };

            self.activity_repo.update(updated_activity).await?;
        }

        Ok(updated_decision)
    }

    /// Get decision by ID
    pub async fn get_decision(&self, decision_id: Uuid, user_id: Uuid) -> Result<Decision> {
        let decision = self
            .decision_repo
            .find_by_id(decision_id)
            .await?
            .ok_or_else(|| BetweenError::NotFound("Decision not found".to_string()))?;

        if decision.user_id != user_id {
            return Err(BetweenError::Forbidden(
                "You don't have permission to view this decision".to_string(),
            ));
        }

        Ok(decision)
    }

    /// Delete decision
    pub async fn delete_decision(&self, decision_id: Uuid, user_id: Uuid) -> Result<()> {
        // Verify ownership before deletion
        let decision = self
            .decision_repo
            .find_by_id(decision_id)
            .await?
            .ok_or_else(|| BetweenError::NotFound("Decision not found".to_string()))?;

        if decision.user_id != user_id {
            return Err(BetweenError::Forbidden(
                "You don't have permission to delete this decision".to_string(),
            ));
        }

        self.decision_repo.delete(decision_id, user_id).await
    }

    /// Get user statistics
    pub async fn get_stats(&self, user_id: Uuid) -> Result<DecisionStats> {
        self.decision_repo.get_user_stats(user_id).await
    }

    /// Get paginated decisions with filters
    pub async fn get_decisions(
        &self,
        user_id: Uuid,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
        context_code: Option<i16>,
        tags: Option<Vec<String>>,
        status: Option<String>,
    ) -> Result<(Vec<Decision>, u64)> {
        self.decision_repo
            .find_decisions_paginated(
                user_id,
                page,
                limit,
                from_date,
                to_date,
                context_code,
                tags,
                status,
            )
            .await
    }

    /// Get all available contexts for decision module
    pub async fn get_contexts(&self) -> Result<Vec<crate::domain::context::entity::Context>> {
        self.context_repo
            .get_contexts(Some("decision".to_string()))
            .await
    }

    // Helper: Validate text field length
    fn validate_text_field(&self, field: &Option<String>, field_name: &str) -> Result<()> {
        if let Some(text) = field {
            if text.len() > MAX_TEXT_FIELD_LENGTH {
                return Err(BetweenError::BadRequest(format!(
                    "{} must not exceed {} characters",
                    field_name, MAX_TEXT_FIELD_LENGTH
                )));
            }
        }
        Ok(())
    }
}

// Request DTOs
#[derive(Debug, Clone, Deserialize)]
pub struct CreateDecisionRequest {
    pub title: String,
    pub decided_at: Option<DateTime<Utc>>,
    pub reason: Option<String>,
    pub expectation: Option<String>,
    pub completed_at: Option<DateTime<Utc>>,
    pub actual_result: Option<String>,
    pub learnings: Option<String>,
    pub context_code: Option<i16>,
    pub tags: Option<Vec<String>>,
}

#[derive(Debug, Clone, Deserialize)]
pub struct UpdateDecisionRequest {
    pub title: Option<String>,
    pub decided_at: Option<DateTime<Utc>>,
    pub reason: Option<String>,
    pub expectation: Option<String>,
    pub completed_at: Option<DateTime<Utc>>,
    pub actual_result: Option<String>,
    pub learnings: Option<String>,
    pub context_code: Option<i16>,
    pub tags: Option<Vec<String>>,
}
