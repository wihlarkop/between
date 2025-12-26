use serde::{Deserialize, Serialize};
use utoipa::ToSchema;

/// Query parameters for context list
#[derive(Debug, Deserialize)]
pub struct ContextQueryParams {
    /// Optional module filter: "silence", "decision", "all", or empty for all contexts
    pub module: Option<String>,
}

/// Context item
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ContextItem {
    pub code: i16,
    pub label: String,
    pub module: String,
}

/// Context list response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ContextListResponse {
    pub contexts: Vec<ContextItem>,
}
