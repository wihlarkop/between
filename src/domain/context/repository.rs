use async_trait::async_trait;

use crate::domain::context::entity::Context;
use crate::shared::error::Result;

#[async_trait]
pub trait ContextRepositoryTrait: Send + Sync {
    /// Get all contexts, optionally filtered by module
    async fn get_contexts(&self, module: Option<String>) -> Result<Vec<Context>>;

    /// Get context by code
    async fn get_context_by_code(&self, code: i16) -> Result<Option<Context>>;

    /// Verify context code exists (optionally for a specific module)
    async fn verify_context_code(&self, code: i16, module: Option<String>) -> Result<bool>;
}
