use crate::domain::user::entity::User;
use crate::domain::user::repository::UserRepositoryTrait;
use crate::shared::auth::{jwt, password};
use crate::shared::error::{BetweenError, Result};
use crate::shared::schema::user::{
    LoginRequest, LoginResponse, RefreshTokenRequest, RefreshTokenResponse, RegisterRequest,
    RegisterResponse, TokenResponse,
};
use async_trait::async_trait;
use chrono::Utc;
use uuid::Uuid;

#[async_trait]
pub trait AuthServiceTrait: Send + Sync {
    async fn register(&self, request: RegisterRequest) -> Result<RegisterResponse>;
    async fn login(&self, request: LoginRequest) -> Result<LoginResponse>;
    async fn refresh_token(&self, request: RefreshTokenRequest) -> Result<RefreshTokenResponse>;
}

pub struct AuthService<R: UserRepositoryTrait> {
    user_repo: R,
    jwt_secret: String,
    jwt_access_token_expiry: i64,
    jwt_refresh_token_expiry: i64,
}

impl<R: UserRepositoryTrait> AuthService<R> {
    pub fn new(
        user_repo: R,
        jwt_secret: String,
        jwt_access_token_expiry: i64,
        jwt_refresh_token_expiry: i64,
    ) -> Self {
        Self {
            user_repo,
            jwt_secret,
            jwt_access_token_expiry,
            jwt_refresh_token_expiry,
        }
    }
}

#[async_trait]
impl<R: UserRepositoryTrait + Send + Sync> AuthServiceTrait for AuthService<R> {
    async fn register(&self, request: RegisterRequest) -> Result<RegisterResponse> {
        // Check if email already exists
        if self.user_repo.email_exists(&request.email).await? {
            return Err(BetweenError::Conflict(format!(
                "User with email '{}' already exists",
                request.email
            )));
        }

        // Hash password
        let password_hash = password::hash_password(&request.password)?;

        // Create user
        let user = User {
            id: Uuid::new_v4(),
            fullname: request.fullname,
            email: request.email.clone(),
            password_hash,
            timezone: request.timezone,
            created_at: Utc::now(),
            updated_at: Utc::now(),
        };

        let created_user = self.user_repo.create(user).await?;

        // Generate tokens
        let access_token = jwt::generate_access_token(
            created_user.id,
            &created_user.email,
            &self.jwt_secret,
            self.jwt_access_token_expiry,
        )?;

        let refresh_token = jwt::generate_refresh_token(
            created_user.id,
            &self.jwt_secret,
            self.jwt_refresh_token_expiry,
        )?;

        Ok(RegisterResponse {
            access_token,
            refresh_token,
            expires_in: self.jwt_access_token_expiry,
        })
    }

    async fn login(&self, request: LoginRequest) -> Result<LoginResponse> {
        // Find user by email
        let user = self
            .user_repo
            .find_by_email(&request.email)
            .await?
            .ok_or_else(|| BetweenError::Unauthorized("Invalid credentials".to_string()))?;

        // Verify password
        if !password::verify_password(&request.password, &user.password_hash)? {
            return Err(BetweenError::Unauthorized(
                "Invalid credentials".to_string(),
            ));
        }

        // Generate tokens
        let access_token = jwt::generate_access_token(
            user.id,
            &user.email,
            &self.jwt_secret,
            self.jwt_access_token_expiry,
        )?;

        let refresh_token =
            jwt::generate_refresh_token(user.id, &self.jwt_secret, self.jwt_refresh_token_expiry)?;

        Ok(LoginResponse {
            access_token,
            refresh_token,
            expires_in: self.jwt_access_token_expiry,
        })
    }

    async fn refresh_token(&self, request: RefreshTokenRequest) -> Result<RefreshTokenResponse> {
        // Verify refresh token
        let claims = jwt::verify_token(&request.refresh_token, &self.jwt_secret)?;

        // Check token type
        if claims.token_type != "refresh" {
            return Err(BetweenError::Unauthorized("Invalid token type".to_string()));
        }

        // Find user to ensure they still exist
        let user = self
            .user_repo
            .find_by_id(claims.sub)
            .await?
            .ok_or_else(|| BetweenError::Unauthorized("User not found".to_string()))?;

        // Generate new access token
        let access_token = jwt::generate_access_token(
            user.id,
            &user.email,
            &self.jwt_secret,
            self.jwt_access_token_expiry,
        )?;

        Ok(TokenResponse {
            access_token,
            refresh_token: request.refresh_token, // Return the same refresh token
            expires_in: self.jwt_access_token_expiry,
        })
    }
}
