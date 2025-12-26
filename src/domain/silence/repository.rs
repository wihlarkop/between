use crate::domain::silence::session::{SilenceSession, SilenceSessionWithContext};
use crate::shared::error::Result;
use async_trait::async_trait;
use chrono::{DateTime, Utc};
use uuid::Uuid;

/// Silence session repository trait with all operations
#[async_trait]
pub trait SilenceSessionRepositoryTrait: Send + Sync {
    /// Create a new silence session
    async fn create(&self, session: SilenceSession) -> Result<SilenceSession>;

    /// Find session by ID
    async fn find_by_id(&self, id: Uuid) -> Result<Option<SilenceSession>>;

    /// Find active session for a user
    async fn find_active_session(&self, user_id: Uuid) -> Result<Option<SilenceSession>>;

    /// Update session
    async fn update(&self, session: SilenceSession) -> Result<SilenceSession>;

    /// Find sessions with pagination
    /// Returns (sessions, total_count)
    async fn find_sessions_paginated(
        &self,
        user_id: Uuid,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
    ) -> Result<(Vec<SilenceSessionWithContext>, u64)>;

    /// Get user statistics
    async fn get_user_stats(&self, user_id: Uuid) -> Result<UserSessionStats>;
}

/// User session statistics from aggregated queries
#[derive(Debug, Clone)]
pub struct UserSessionStats {
    pub total_sessions: i64,
    pub total_duration_seconds: i64,
    pub average_duration_seconds: i32,
    pub longest_session_seconds: i32,
    pub shortest_session_seconds: i32,
    pub most_common_context: Option<(i16, String, i64)>,
    pub sessions_by_hour: Vec<(i32, i64)>,
    pub sessions_by_day: Vec<(String, i64)>,
}
