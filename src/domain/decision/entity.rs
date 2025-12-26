use chrono::{DateTime, Utc};
use sea_query::Iden;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use utoipa::ToSchema;
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct Decision {
    pub id: Uuid,
    pub user_id: Uuid,

    pub title: String,

    pub decided_at: Option<DateTime<Utc>>,
    pub reason: Option<String>,
    pub expectation: Option<String>,

    pub completed_at: Option<DateTime<Utc>>,
    pub actual_result: Option<String>,
    pub learnings: Option<String>,

    pub context_code: Option<i16>,
    pub tags: Option<Vec<String>>,
    pub created_at: DateTime<Utc>,
}

impl Decision {
    pub fn is_pending(&self) -> bool {
        self.decided_at.is_some() && self.completed_at.is_none()
    }

    pub fn is_completed(&self) -> bool {
        self.completed_at.is_some()
    }

    pub fn has_full_context(&self) -> bool {
        self.decided_at.is_some() && self.completed_at.is_some()
    }
}

/// Decision with context label (from JOIN query)
#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct DecisionWithContext {
    pub id: Uuid,
    pub user_id: Uuid,
    pub title: String,
    pub decided_at: Option<DateTime<Utc>>,
    pub reason: Option<String>,
    pub expectation: Option<String>,
    pub completed_at: Option<DateTime<Utc>>,
    pub actual_result: Option<String>,
    pub learnings: Option<String>,
    pub context_code: Option<i16>,
    pub context_label: Option<String>,
    pub tags: Option<Vec<String>>,
    pub created_at: DateTime<Utc>,
    pub total: Option<i64>,
}

// Constants for validation
pub const MIN_TITLE_LENGTH: usize = 1;
pub const MAX_TITLE_LENGTH: usize = 200;
pub const MAX_TEXT_FIELD_LENGTH: usize = 1000;

/// Table identifier for decisions table (sea-query)
#[derive(Iden)]
pub enum Decisions {
    Table,
    Id,
    UserId,
    Title,
    DecidedAt,
    Reason,
    Expectation,
    CompletedAt,
    ActualResult,
    Learnings,
    ContextCode,
    Tags,
    CreatedAt,
}
