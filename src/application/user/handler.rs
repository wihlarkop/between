use crate::domain::user::service::AuthServiceTrait;
use crate::shared::error::BetweenError;
use crate::shared::response::{ApiError, JsonResponse};
use crate::shared::schema::user::{
    LoginRequest, LoginResponse, RefreshTokenRequest, RefreshTokenResponse, RegisterRequest,
    RegisterResponse,
};
use crate::shared::JsonExtractor;
use axum::extract::State;
use std::sync::Arc;
use validator::Validate;

/// Register a new user
#[utoipa::path(
    post,
    path = "/api/auth/register",
    request_body = RegisterRequest,
    responses(
        (status = 201, description = "User registered successfully", body = JsonResponse<RegisterResponse>),
        (status = 400, description = "Validation error"),
        (status = 409, description = "User already exists")
    ),
    tag = "Authentication"
)]
pub async fn register<T: AuthServiceTrait + Send + Sync>(
    State(auth_service): State<Arc<T>>,
    JsonExtractor(request): JsonExtractor<RegisterRequest>,
) -> Result<JsonResponse<RegisterResponse>, ApiError> {
    // Validate request
    request
        .validate()
        .map_err(|e| BetweenError::Validation(e.to_string()))?;

    // Call service
    let response = auth_service.register(request).await?;

    Ok(JsonResponse::created(
        response,
        "User registered successfully",
    ))
}

/// Login user
#[utoipa::path(
    post,
    path = "/api/auth/login",
    request_body = LoginRequest,
    responses(
        (status = 200, description = "Login successful", body = JsonResponse<LoginResponse>),
        (status = 400, description = "Validation error"),
        (status = 401, description = "Invalid credentials")
    ),
    tag = "Authentication"
)]
pub async fn login<T: AuthServiceTrait + Send + Sync>(
    State(auth_service): State<Arc<T>>,
    JsonExtractor(request): JsonExtractor<LoginRequest>,
) -> Result<JsonResponse<LoginResponse>, ApiError> {
    // Validate request
    request
        .validate()
        .map_err(|e| BetweenError::Validation(e.to_string()))?;

    // Call service
    let response = auth_service.login(request).await?;

    Ok(JsonResponse::success(response))
}

/// Refresh access token
#[utoipa::path(
    post,
    path = "/api/auth/refresh-token",
    request_body = RefreshTokenRequest,
    responses(
        (status = 200, description = "Token refreshed successfully", body = JsonResponse<RefreshTokenResponse>),
        (status = 400, description = "Validation error"),
        (status = 401, description = "Invalid refresh token")
    ),
    tag = "Authentication"
)]
pub async fn refresh_token<T: AuthServiceTrait + Send + Sync>(
    State(auth_service): State<Arc<T>>,
    JsonExtractor(request): JsonExtractor<RefreshTokenRequest>,
) -> Result<JsonResponse<RefreshTokenResponse>, ApiError> {
    // Validate request
    request
        .validate()
        .map_err(|e| BetweenError::Validation(e.to_string()))?;

    // Call service
    let response = auth_service.refresh_token(request).await?;

    Ok(JsonResponse::success(response))
}
