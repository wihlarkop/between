use chrono::{DateTime, Utc};
use sea_query::Iden;
use serde::{Deserialize, Serialize};
use serde_json::Value as JsonValue;
use sqlx::FromRow;
use utoipa::ToSchema;
use uuid::Uuid;

/// User activity entity from database
///
/// This is a centralized table that aggregates sessions from all modules
/// (silence, decision, etc.) for efficient cross-module querying.
#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct UserActivity {
    pub id: Uuid,
    pub user_id: Uuid,
    pub module: String,
    pub module_session_id: Uuid,
    pub started_at: DateTime<Utc>,
    pub ended_at: Option<DateTime<Utc>>,
    pub duration_seconds: Option<i32>,
    pub context_code: Option<i16>,
    pub metadata: Option<JsonValue>,
    pub created_at: DateTime<Utc>,
}

impl UserActivity {
    /// Create a new activity from a silence session
    pub fn new_from_silence(
        user_id: Uuid,
        session_id: Uuid,
        started_at: DateTime<Utc>,
        ended_at: Option<DateTime<Utc>>,
        duration_seconds: Option<i32>,
        context_code: Option<i16>,
        context_note: Option<String>,
        termination_reason: Option<String>,
    ) -> Self {
        let mut metadata_obj = serde_json::Map::new();

        if let Some(note) = context_note {
            metadata_obj.insert("context_note".to_string(), JsonValue::String(note));
        }

        if let Some(reason) = termination_reason {
            metadata_obj.insert("termination_reason".to_string(), JsonValue::String(reason));
        }

        let metadata = if metadata_obj.is_empty() {
            None
        } else {
            Some(JsonValue::Object(metadata_obj))
        };

        Self {
            id: Uuid::new_v4(),
            user_id,
            module: "silence".to_string(),
            module_session_id: session_id,
            started_at,
            ended_at,
            duration_seconds,
            context_code,
            metadata,
            created_at: Utc::now(),
        }
    }

    /// Create a new activity from a decision session
    pub fn new_from_decision(
        user_id: Uuid,
        session_id: Uuid,
        started_at: DateTime<Utc>,
        ended_at: Option<DateTime<Utc>>,
        duration_seconds: Option<i32>,
        context_code: Option<i16>,
        title: Option<String>,
        tags: Option<Vec<String>>,
    ) -> Self {
        let mut metadata_obj = serde_json::Map::new();

        if let Some(t) = title {
            metadata_obj.insert("title".to_string(), JsonValue::String(t));
        }

        if let Some(tag_list) = tags {
            let tag_values: Vec<JsonValue> = tag_list
                .into_iter()
                .map(JsonValue::String)
                .collect();
            metadata_obj.insert("tags".to_string(), JsonValue::Array(tag_values));
        }

        let metadata = if metadata_obj.is_empty() {
            None
        } else {
            Some(JsonValue::Object(metadata_obj))
        };

        Self {
            id: Uuid::new_v4(),
            user_id,
            module: "decision".to_string(),
            module_session_id: session_id,
            started_at,
            ended_at,
            duration_seconds,
            context_code,
            metadata,
            created_at: Utc::now(),
        }
    }

    pub fn is_active(&self) -> bool {
        self.ended_at.is_none()
    }
}

/// User activity with context label (from JOIN query)
#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct UserActivityWithContext {
    pub id: Uuid,
    pub user_id: Uuid,
    pub module: String,
    pub module_session_id: Uuid,
    pub started_at: DateTime<Utc>,
    pub ended_at: Option<DateTime<Utc>>,
    pub duration_seconds: Option<i32>,
    pub context_code: Option<i16>,
    pub context_label: Option<String>,
    pub metadata: Option<JsonValue>,
    pub created_at: DateTime<Utc>,
    pub total: Option<i64>,
}

/// Table identifier for user_activities table (sea-query)
#[derive(Iden)]
pub enum UserActivities {
    Table,
    Id,
    UserId,
    Module,
    ModuleSessionId,
    StartedAt,
    EndedAt,
    DurationSeconds,
    ContextCode,
    Metadata,
    CreatedAt,
}
