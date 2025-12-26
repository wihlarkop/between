use async_trait::async_trait;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use crate::domain::decision::entity::Decision;
use crate::shared::error::Result;

#[async_trait]
pub trait DecisionRepositoryTrait: Send + Sync {
    /// Create a new decision
    async fn create(&self, decision: Decision) -> Result<Decision>;

    /// Find decision by ID
    async fn find_by_id(&self, decision_id: Uuid) -> Result<Option<Decision>>;

    /// Update existing decision
    async fn update(&self, decision: Decision) -> Result<Decision>;

    /// Delete decision
    async fn delete(&self, decision_id: Uuid, user_id: Uuid) -> Result<()>;

    /// Get paginated decisions for user
    async fn find_decisions_paginated(
        &self,
        user_id: Uuid,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
        context_code: Option<i16>,
        tags: Option<Vec<String>>,
        status: Option<String>, // "pending", "completed", "all"
    ) -> Result<(Vec<Decision>, u64)>;

    /// Get user statistics
    async fn get_user_stats(&self, user_id: Uuid) -> Result<DecisionStats>;
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DecisionStats {
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

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ContextCount {
    pub context_code: i16,
    pub context_label: String,
    pub count: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MonthCount {
    pub month: String, // "2024-03"
    pub count: u64,
}
