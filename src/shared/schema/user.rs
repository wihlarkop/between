use crate::domain::user::entity::User;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use utoipa::ToSchema;
use uuid::Uuid;
use validator::Validate;

// ============================================================================
// Register Schema
// ============================================================================

/// Register request
#[derive(Debug, Clone, Serialize, Deserialize, Validate, ToSchema)]
pub struct RegisterRequest {
    #[validate(length(
        min = 1,
        max = 255,
        message = "Fullname must be between 1 and 255 characters"
    ))]
    pub fullname: String,

    #[validate(email(message = "Invalid email format"))]
    pub email: String,

    #[validate(length(min = 8, message = "Password must be at least 8 characters"))]
    pub password: String,

    #[validate(
        length(
            min = 1,
            max = 100,
            message = "Timezone must be between 1 and 100 characters"
        ),
        custom(
            function = "validate_timezone_format",
            message = "Invalid timezone format. Use IANA timezone names (e.g., 'America/New_York', 'Asia/Jakarta', 'UTC')"
        )
    )]
    pub timezone: String,
}

/// Validate that a string is a valid IANA timezone
fn validate_timezone_format(timezone: &str) -> Result<(), validator::ValidationError> {
    use chrono_tz::Tz;

    timezone.parse::<Tz>().map(|_| ()).map_err(|_| {
        let mut err = validator::ValidationError::new("invalid_timezone");
        err.message = Some(std::borrow::Cow::from(
            "Invalid timezone format. Use IANA timezone names (e.g., 'America/New_York', 'Asia/Jakarta', 'UTC')",
        ));
        err
    })
}

/// User response (without sensitive data)
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct UserResponse {
    pub id: Uuid,
    pub fullname: String,
    pub email: String,
    pub timezone: String,
    pub created_at: DateTime<Utc>,
}

impl From<User> for UserResponse {
    fn from(user: User) -> Self {
        Self {
            id: user.id,
            fullname: user.fullname,
            email: user.email,
            timezone: user.timezone,
            created_at: user.created_at,
        }
    }
}

/// Token response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct TokenResponse {
    pub access_token: String,
    pub refresh_token: String,
    pub expires_in: i64,
}

/// Register response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct RegisterResponse {
    pub access_token: String,
    pub refresh_token: String,
    pub expires_in: i64,
}

// ============================================================================
// Login Schema
// ============================================================================

/// Login request
#[derive(Debug, Clone, Serialize, Deserialize, Validate, ToSchema)]
pub struct LoginRequest {
    #[validate(email(message = "Invalid email format"))]
    pub email: String,

    #[validate(length(min = 1, message = "Password is required"))]
    pub password: String,
}

/// Login response
#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct LoginResponse {
    pub access_token: String,
    pub refresh_token: String,
    pub expires_in: i64,
}

// ============================================================================
// Refresh Token Schema
// ============================================================================

/// Refresh token request
#[derive(Debug, Clone, Serialize, Deserialize, Validate, ToSchema)]
pub struct RefreshTokenRequest {
    #[validate(length(min = 1, message = "Refresh token is required"))]
    pub refresh_token: String,
}

/// Refresh token response (same as TokenResponse, but explicit)
pub type RefreshTokenResponse = TokenResponse;
