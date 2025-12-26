use crate::domain::user::entity::User;
use crate::domain::user::repository::UserRepositoryTrait;
use crate::shared::auth::jwt::verify_token;
use crate::shared::error::{error_messages, BetweenError};
use axum::{
    extract::{FromRef, FromRequestParts},
    http::{header, request::Parts},
    response::{IntoResponse, Response},
};
use std::sync::Arc;

/// Authenticated user context extracted from JWT
#[derive(Debug, Clone)]
pub struct AuthUser {
    pub user_id: uuid::Uuid,
    pub email: String,
    pub timezone: String,
}

/// Auth middleware error response
pub struct AuthError(BetweenError);

impl IntoResponse for AuthError {
    fn into_response(self) -> Response {
        use crate::shared::response::create_error_response;

        create_error_response(
            self.0.status_code(),
            self.0.to_string(),
            self.0.error_code(),
        )
    }
}

impl From<BetweenError> for AuthError {
    fn from(err: BetweenError) -> Self {
        AuthError(err)
    }
}

/// Extractor for authenticated user
/// This will be used in route handlers to get the current user
pub struct AuthenticatedUser<R: UserRepositoryTrait> {
    pub user: User,
    _phantom: std::marker::PhantomData<R>,
}

impl<R: UserRepositoryTrait> AuthenticatedUser<R> {
    pub fn new(user: User) -> Self {
        Self {
            user,
            _phantom: std::marker::PhantomData,
        }
    }

    pub fn user_id(&self) -> uuid::Uuid {
        self.user.id
    }

    pub fn timezone(&self) -> &str {
        &self.user.timezone
    }

    pub fn email(&self) -> &str {
        &self.user.email
    }
}

// Define a wrapper for the JWT secret
#[derive(Clone, Debug)]
pub struct JwtSecret(pub String);

impl<S, R> FromRequestParts<S> for AuthenticatedUser<R>
where
    S: Send + Sync,
    R: UserRepositoryTrait + Send + Sync + 'static,
    JwtSecret: FromRef<S>,
    Arc<dyn UserRepositoryTrait>: FromRef<S>,
{
    type Rejection = AuthError;

    async fn from_request_parts(
        parts: &mut Parts,
        state: &S,
    ) -> std::result::Result<Self, Self::Rejection> {
        // Extract the authorization header
        let auth_header = parts
            .headers
            .get(header::AUTHORIZATION)
            .and_then(|v| v.to_str().ok())
            .ok_or_else(|| {
                BetweenError::Unauthorized(error_messages::MISSING_AUTH_HEADER.to_string())
            })?;

        // Extract the token from "Bearer <token>"
        let token = auth_header.strip_prefix("Bearer ").ok_or_else(|| {
            BetweenError::Unauthorized(error_messages::INVALID_AUTH_FORMAT.to_string())
        })?;

        // Get JWT secret from state
        let JwtSecret(secret) = JwtSecret::from_ref(state);

        // Verify the token
        let claims = verify_token(token, &secret)
            .map_err(|_| BetweenError::Unauthorized(error_messages::INVALID_TOKEN.to_string()))?;

        // Get the user repository from state
        let user_repo: Arc<dyn UserRepositoryTrait> = FromRef::from_ref(state);

        // Fetch the user from database
        let user = user_repo
            .find_by_id(claims.sub)
            .await
            .map_err(|e| BetweenError::Internal(format!("Database error: {}", e)))?
            .ok_or_else(|| {
                BetweenError::Unauthorized(error_messages::USER_NOT_FOUND.to_string())
            })?;

        Ok(AuthenticatedUser::new(user))
    }
}
