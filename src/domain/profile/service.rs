use async_trait::async_trait;
use uuid::Uuid;

use crate::domain::user::UserRepositoryTrait;
use crate::shared::error::Result;
use crate::shared::schema::profile::{MyProfileResponse, UpdateProfileRequest};
use crate::BetweenError;

#[async_trait]
pub trait ProfileServiceTrait: Send + Sync {
    async fn my_profile(&self, user_id: Uuid) -> Result<MyProfileResponse>;
    async fn update_profile(&self, user_id: Uuid, request: UpdateProfileRequest) -> Result<()>;
}

pub struct ProfileService<R: UserRepositoryTrait> {
    user_repo: R,
}

impl<R: UserRepositoryTrait> ProfileService<R> {
    pub fn new(user_repo: R) -> Self {
        Self { user_repo }
    }
}

#[async_trait]
impl<R: UserRepositoryTrait + Send + Sync> ProfileServiceTrait for ProfileService<R> {
    async fn my_profile(&self, user_id: Uuid) -> Result<MyProfileResponse> {
        let user = self
            .user_repo
            .find_by_id(user_id)
            .await?
            .ok_or_else(|| BetweenError::Unauthorized("User not found".to_string()))?;

        let my_profile = MyProfileResponse::from(user);

        Ok(my_profile)
    }

    async fn update_profile(&self, user_id: Uuid, request: UpdateProfileRequest) -> Result<()> {
        let mut user = self
            .user_repo
            .find_by_id(user_id)
            .await?
            .ok_or_else(|| BetweenError::Unauthorized("User not found".to_string()))?;

        user.update_user(request)?;

        self.user_repo.update(user).await?;

        Ok(())
    }
}
