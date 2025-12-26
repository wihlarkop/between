use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use utoipa::ToSchema;
use uuid::Uuid;
use validator::Validate;

// ============================================================================
// Start Session Schema
// ============================================================================

/// Start session response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct StartSessionResponse {
    pub id: Uuid,
    pub user_id: Uuid,
    pub started_at: DateTime<Utc>,
    pub started_at_local: String,
    pub status: String,
}

// ============================================================================
// End Session Schema
// ============================================================================

/// End session request
#[derive(Debug, Clone, Serialize, Deserialize, Validate, ToSchema)]
pub struct EndSessionRequest {
    #[validate(length(max = 50, message = "Termination reason must not exceed 50 characters"))]
    pub termination_reason: Option<String>,
}

/// End session response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct EndSessionResponse {
    pub id: Uuid,
    pub user_id: Uuid,
    pub started_at: DateTime<Utc>,
    pub started_at_local: String,
    pub ended_at: DateTime<Utc>,
    pub ended_at_local: String,
    pub duration_seconds: i32,
    pub termination_reason: Option<String>,
    pub status: String,
}

// ============================================================================
// Session List Schema
// ============================================================================

#[derive(Debug, Deserialize)]
pub struct SessionQueryParams {
    pub page: Option<u32>,
    pub limit: Option<u32>,
    pub from_date: Option<DateTime<Utc>>,
    pub to_date: Option<DateTime<Utc>>,
}

/// Session item in list
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct SessionItem {
    pub id: Uuid,
    pub started_at: DateTime<Utc>,
    pub started_at_local: String,
    pub ended_at: DateTime<Utc>,
    pub ended_at_local: String,
    pub duration_seconds: i32,
    pub termination_reason: Option<String>,
    pub context_code: Option<i16>,
    pub context_label: Option<String>,
    pub context_note: Option<String>,
}

/// Session list response (data only)
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct SessionListResponse {
    pub sessions: Vec<SessionItem>,
}

// ============================================================================
// Attach Context Schema
// ============================================================================

/// Attach context request
#[derive(Debug, Clone, Serialize, Deserialize, Validate, ToSchema)]
pub struct AttachContextRequest {
    pub context_code: i16,

    #[validate(length(max = 500, message = "Context note must not exceed 500 characters"))]
    pub context_note: Option<String>,
}

/// Attach context response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct AttachContextResponse {
    pub context_code: i16,
    pub context_label: String,
    pub context_note: Option<String>,
}

// ============================================================================
// Session Stats Schema
// ============================================================================

/// Session statistics response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct SessionStatsResponse {
    pub total_sessions: u64,
    pub total_duration_seconds: i64,
    pub average_duration_seconds: i32,
    pub longest_session_seconds: i32,
    pub shortest_session_seconds: i32,
    pub most_common_context: Option<ContextCount>,
    pub sessions_by_hour: Vec<HourCount>,
    pub sessions_by_day: Vec<DayCount>,
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ContextCount {
    pub code: i16,
    pub label: String,
    pub count: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct HourCount {
    pub hour: i32,
    pub count: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct DayCount {
    pub day: String,
    pub count: i64,
}

// Note: Context types moved to shared/schema/context.rs
