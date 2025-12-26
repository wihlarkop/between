use chrono::{DateTime, Utc};
use sea_query::Iden;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use utoipa::ToSchema;
use uuid::Uuid;

use crate::shared::auth::password::{hash_password, verify_password};
use crate::shared::error::Result;
use crate::shared::schema::profile::UpdateProfileRequest;
use crate::BetweenError;

/// User entity from database
#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct User {
    pub id: Uuid,
    pub fullname: String,
    pub email: String,
    #[serde(skip_serializing)]
    pub password_hash: String,
    pub timezone: String,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
}

impl User {
    pub fn update_user(&mut self, req: UpdateProfileRequest) -> Result<()> {
        self.fullname = req.fullname;
        self.timezone = req.timezone;

        if !req.password.is_empty() {
            verify_password(&req.password, &self.password_hash)?
                .then_some(())
                .ok_or_else(|| BetweenError::Unauthorized("Invalid password".to_string()))?;

            self.password_hash = hash_password(&req.password)?;
        }

        self.updated_at = Utc::now();
        Ok(())
    }
}

/// Table identifier for users table (sea-query)
#[derive(Iden)]
pub enum Users {
    Table,
    Id,
    Fullname,
    Email,
    PasswordHash,
    Timezone,
    CreatedAt,
    UpdatedAt,
}
