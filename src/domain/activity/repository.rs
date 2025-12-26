use crate::domain::activity::entity::{UserActivity, UserActivityWithContext};
use crate::shared::error::Result;
use async_trait::async_trait;
use chrono::{DateTime, Utc};
use uuid::Uuid;

/// Activity repository trait with all operations
#[async_trait]
pub trait ActivityRepositoryTrait: Send + Sync {
    /// Create a new activity
    async fn create(&self, activity: UserActivity) -> Result<UserActivity>;

    /// Find activity by ID
    async fn find_by_id(&self, id: Uuid) -> Result<Option<UserActivity>>;

    /// Find activity by ID with context label (LEFT JOIN)
    async fn find_by_id_with_context(&self, id: Uuid) -> Result<Option<UserActivityWithContext>>;

    /// Find active session for a user and module
    async fn find_active(
        &self,
        user_id: Uuid,
        module: &str,
    ) -> Result<Option<UserActivity>>;

    /// Update activity
    async fn update(&self, activity: UserActivity) -> Result<UserActivity>;

    /// Find activity by module session ID
    async fn find_by_module_session_id(
        &self,
        module: &str,
        module_session_id: Uuid,
    ) -> Result<Option<UserActivity>>;

    /// Find activities with pagination and filtering
    /// Returns (activities, total_count)
    async fn find_activities_paginated(
        &self,
        user_id: Uuid,
        module: Option<String>,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
    ) -> Result<(Vec<UserActivityWithContext>, u64)>;

    /// Get user statistics
    async fn get_user_stats(
        &self,
        user_id: Uuid,
        module: Option<String>,
    ) -> Result<ActivityStats>;
}

/// Aggregate statistics data class
#[derive(Debug, Clone)]
pub struct ActivityStats {
    pub total_activities: i64,
    pub total_duration_seconds: i64,
    pub average_duration_seconds: i32,
    pub longest_activity_seconds: i32,
    pub shortest_activity_seconds: i32,
    pub activities_by_module: Vec<ModuleCount>,
    pub most_common_context: Option<ContextCount>,
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ModuleCount {
    pub module: String,
    pub count: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct ContextCount {
    pub code: i16,
    pub label: String,
    pub count: i64,
}

use serde::{Deserialize, Serialize};
use utoipa::ToSchema;
