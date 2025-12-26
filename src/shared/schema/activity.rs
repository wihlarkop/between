use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use serde_json::Value as JsonValue;
use utoipa::ToSchema;
use uuid::Uuid;

// ============================================================================
// Activity List Schema
// ============================================================================

#[derive(Debug, Deserialize)]
pub struct ActivityQueryParams {
    pub module: Option<String>,
    pub page: Option<u32>,
    pub limit: Option<u32>,
    pub from_date: Option<DateTime<Utc>>,
    pub to_date: Option<DateTime<Utc>>,
}

/// Activity item in list
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ActivityItem {
    pub id: Uuid,
    pub module: String,
    pub module_session_id: Uuid,
    pub started_at: DateTime<Utc>,
    pub started_at_local: String,
    pub ended_at: Option<DateTime<Utc>>,
    pub ended_at_local: Option<String>,
    pub duration_seconds: Option<i32>,
    pub context_code: Option<i16>,
    pub context_label: Option<String>,
    pub metadata: Option<JsonValue>,
}

/// Activity list response (data only)
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ActivityListResponse {
    pub activities: Vec<ActivityItem>,
}

// ============================================================================
// Activity Statistics Schema
// ============================================================================

/// Module count in statistics
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ModuleCount {
    pub module: String,
    pub count: i64,
}

/// Context count in statistics
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ContextCount {
    pub code: i16,
    pub label: String,
    pub count: i64,
}

/// Activity statistics response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ActivityStatsResponse {
    pub total_activities: i64,
    pub total_duration_seconds: i64,
    pub average_duration_seconds: i32,
    pub longest_activity_seconds: i32,
    pub shortest_activity_seconds: i32,
    pub activities_by_module: Vec<ModuleCount>,
    pub most_common_context: Option<ContextCount>,
}
