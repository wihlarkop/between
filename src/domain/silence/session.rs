use chrono::{DateTime, Utc};
use sea_query::Iden;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use utoipa::ToSchema;
use uuid::Uuid;

// Silence session constants
/// Minimum duration for a silence session in seconds (5 seconds)
pub const MIN_DURATION_SECONDS: i32 = 5;

/// Maximum duration for a silence session in seconds (6 hours)
pub const MAX_DURATION_SECONDS: i32 = 21600;

/// Silence session entity from database
#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct SilenceSession {
    pub id: Uuid,
    pub user_id: Uuid,
    pub started_at: DateTime<Utc>,
    pub ended_at: Option<DateTime<Utc>>,
    pub duration_seconds: Option<i32>,
    pub context_code: Option<i16>,
    pub context_note: Option<String>,
    pub termination_reason: Option<String>,
    pub created_at: DateTime<Utc>,
}

impl SilenceSession {
    pub fn is_active(&self) -> bool {
        self.ended_at.is_none()
    }
}

/// Silence session with context label (from JOIN query)
#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct SilenceSessionWithContext {
    pub id: Uuid,
    pub user_id: Uuid,
    pub started_at: DateTime<Utc>,
    pub ended_at: Option<DateTime<Utc>>,
    pub duration_seconds: Option<i32>,
    pub context_code: Option<i16>,
    pub context_label: Option<String>,
    pub context_note: Option<String>,
    pub termination_reason: Option<String>,
    pub created_at: DateTime<Utc>,
    pub total: Option<i64>,
}

/// Table identifier for silence_sessions table (sea-query)
#[derive(Iden)]
pub enum SilenceSessions {
    Table,
    Id,
    UserId,
    StartedAt,
    EndedAt,
    DurationSeconds,
    ContextCode,
    ContextNote,
    TerminationReason,
    CreatedAt,
}
