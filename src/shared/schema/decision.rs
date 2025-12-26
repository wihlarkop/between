use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use utoipa::ToSchema;
use uuid::Uuid;
use validator::Validate;

// ============================================================================
// Create Decision Schema
// ============================================================================

/// Create decision request
#[derive(Debug, Clone, Serialize, Deserialize, Validate, ToSchema)]
pub struct CreateDecisionRequest {
    #[validate(length(min = 1, max = 200, message = "Title must be between 1 and 200 characters"))]
    pub title: String,

    pub decided_at: Option<DateTime<Utc>>,

    #[validate(length(max = 1000, message = "Reason must not exceed 1000 characters"))]
    pub reason: Option<String>,

    #[validate(length(max = 1000, message = "Expectation must not exceed 1000 characters"))]
    pub expectation: Option<String>,

    pub completed_at: Option<DateTime<Utc>>,

    #[validate(length(max = 1000, message = "Actual result must not exceed 1000 characters"))]
    pub actual_result: Option<String>,

    #[validate(length(max = 1000, message = "Learnings must not exceed 1000 characters"))]
    pub learnings: Option<String>,

    pub context_code: Option<i16>,

    pub tags: Option<Vec<String>>,
}

/// Create decision response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct CreateDecisionResponse {
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
    pub status: String, // "pending", "completed", or "quick"
}

// ============================================================================
// Update Decision Schema
// ============================================================================

/// Update decision request
#[derive(Debug, Clone, Serialize, Deserialize, Validate, ToSchema)]
pub struct UpdateDecisionRequest {
    #[validate(length(min = 1, max = 200, message = "Title must be between 1 and 200 characters"))]
    pub title: Option<String>,

    pub decided_at: Option<DateTime<Utc>>,

    #[validate(length(max = 1000, message = "Reason must not exceed 1000 characters"))]
    pub reason: Option<String>,

    #[validate(length(max = 1000, message = "Expectation must not exceed 1000 characters"))]
    pub expectation: Option<String>,

    pub completed_at: Option<DateTime<Utc>>,

    #[validate(length(max = 1000, message = "Actual result must not exceed 1000 characters"))]
    pub actual_result: Option<String>,

    #[validate(length(max = 1000, message = "Learnings must not exceed 1000 characters"))]
    pub learnings: Option<String>,

    pub context_code: Option<i16>,

    pub tags: Option<Vec<String>>,
}

/// Update decision response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct UpdateDecisionResponse {
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
    pub status: String,
}

// ============================================================================
// Get Decision Schema
// ============================================================================

/// Get decision response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct GetDecisionResponse {
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
    pub status: String,
}

// ============================================================================
// Decision List Schema
// ============================================================================

/// Query parameters for decision list
#[derive(Debug, Deserialize)]
pub struct DecisionQueryParams {
    pub page: Option<u32>,
    pub limit: Option<u32>,
    pub from_date: Option<DateTime<Utc>>,
    pub to_date: Option<DateTime<Utc>>,
    pub context_code: Option<i16>,
    pub tags: Option<String>, // Comma-separated tags
    pub status: Option<String>, // "pending", "completed", "all"
}

/// Decision item in list
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct DecisionItem {
    pub id: Uuid,
    pub title: String,
    pub decided_at: Option<DateTime<Utc>>,
    pub completed_at: Option<DateTime<Utc>>,
    pub context_code: Option<i16>,
    pub tags: Option<Vec<String>>,
    pub created_at: DateTime<Utc>,
    pub status: String,
}

/// Decision list response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct DecisionListResponse {
    pub decisions: Vec<DecisionItem>,
}

// ============================================================================
// Decision Stats Schema
// ============================================================================

/// Decision statistics response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct DecisionStatsResponse {
    pub total_decisions: u64,
    pub pending_decisions: u64,
    pub completed_decisions: u64,
    pub decisions_this_week: u64,
    pub decisions_this_month: u64,
    pub avg_time_to_completion_days: Option<f64>,
    pub most_common_context: Option<ContextCount>,
    pub by_month: Vec<MonthCount>,
    pub by_context: Vec<ContextCount>,
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ContextCount {
    pub context_code: i16,
    pub context_label: String,
    pub count: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct MonthCount {
    pub month: String,
    pub count: u64,
}

// Note: Context types moved to shared/schema/context.rs

// Helper function to determine status
pub fn get_decision_status(
    decided_at: Option<DateTime<Utc>>,
    completed_at: Option<DateTime<Utc>>,
) -> String {
    match (decided_at, completed_at) {
        (Some(_), None) => "pending".to_string(),
        (Some(_), Some(_)) => "completed".to_string(), // Was pending, now completed
        (None, Some(_)) => "quick".to_string(), // Quick decision with immediate completion
        (None, None) => "quick".to_string(), // Fallback (shouldn't happen due to validation)
    }
}
