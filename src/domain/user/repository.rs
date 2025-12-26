use crate::domain::user::entity::User;
use crate::shared::error::Result;
use async_trait::async_trait;
use uuid::Uuid;

/// User repository trait with all operations
#[async_trait]
pub trait UserRepositoryTrait: Send + Sync {
    /// Create a new user
    async fn create(&self, user: User) -> Result<User>;

    /// Find user by ID
    async fn find_by_id(&self, id: Uuid) -> Result<Option<User>>;

    /// Find user by email
    async fn find_by_email(&self, email: &str) -> Result<Option<User>>;

    /// Update user
    async fn update(&self, user: User) -> Result<User>;

    /// Delete user by ID
    async fn delete(&self, id: Uuid) -> Result<()>;

    /// Check if email exists
    async fn email_exists(&self, email: &str) -> Result<bool>;
}
