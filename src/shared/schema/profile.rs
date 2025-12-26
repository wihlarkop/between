use serde::{Deserialize, Serialize};
use utoipa::ToSchema;
use uuid::Uuid;

use crate::domain::user::User;

/// My profile response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct MyProfileResponse {
    pub id: Uuid,
    pub fullname: String,
    pub email: String,
    pub timezone: String,
}

impl From<User> for MyProfileResponse {
    fn from(user: User) -> Self {
        Self {
            id: user.id,
            fullname: user.fullname,
            email: user.email,
            timezone: user.timezone,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct UpdateProfileRequest {
    pub fullname: String,
    pub timezone: String,
    pub password: String,
}
