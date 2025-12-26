use std::sync::Arc;

use crate::domain::context::entity::Context;
use crate::domain::context::repository::ContextRepositoryTrait;
use crate::shared::error::Result;

pub struct ContextService {
    context_repo: Arc<dyn ContextRepositoryTrait>,
}

impl ContextService {
    pub fn new(context_repo: Arc<dyn ContextRepositoryTrait>) -> Self {
        Self { context_repo }
    }

    /// Get all contexts, optionally filtered by module
    /// Module filter can be: "silence", "decision", "all", or None for all contexts
    pub async fn get_contexts(&self, module: Option<String>) -> Result<Vec<Context>> {
        self.context_repo.get_contexts(module).await
    }

    /// Get context by code
    pub async fn get_context_by_code(&self, code: i16) -> Result<Option<Context>> {
        self.context_repo.get_context_by_code(code).await
    }

    /// Verify context code exists for a specific module
    pub async fn verify_context_code(&self, code: i16, module: Option<String>) -> Result<bool> {
        self.context_repo.verify_context_code(code, module).await
    }
}
