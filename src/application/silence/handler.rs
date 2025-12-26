use crate::domain::silence::service::SilenceSessionServiceTrait;
use crate::domain::user::repository::UserRepositoryTrait;
use crate::shared::error::BetweenError;
use crate::shared::response::{ApiError, JsonResponse, MetaResponse};
use crate::shared::schema::context::ContextListResponse;
use crate::shared::schema::silence::{
    AttachContextRequest, AttachContextResponse, EndSessionRequest,
    EndSessionResponse, SessionListResponse, SessionQueryParams, SessionStatsResponse,
    StartSessionResponse,
};
use crate::shared::{AuthenticatedUser, JsonExtractor};
use axum::extract::{Path, Query, State};
use std::sync::Arc;
use uuid::Uuid;
use validator::Validate;

/// Start a new silence session
#[utoipa::path(
    post,
    path = "/api/silence/start",
    responses(
        (status = 201, description = "Silence session started successfully", body = JsonResponse<StartSessionResponse>),
        (status = 401, description = "Unauthorized"),
        (status = 409, description = "Active session already exists")
    ),
    tag = "Silence",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn start_session<T, R>(
    State(service): State<Arc<T>>,
    auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<StartSessionResponse>, ApiError>
where
    T: SilenceSessionServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    let response = service
        .start_session(auth_user.user_id(), auth_user.timezone())
        .await?;

    Ok(JsonResponse::created(response, "Silence session started"))
}

/// End the active silence session
#[utoipa::path(
    post,
    path = "/api/silence/end",
    responses(
        (status = 200, description = "Silence session ended successfully", body = JsonResponse<EndSessionResponse>),
        (status = 401, description = "Unauthorized"),
        (status = 404, description = "No active session found")
    ),
    request_body = EndSessionRequest,
    tag = "Silence",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn end_session<T, R>(
    State(service): State<Arc<T>>,
    auth_user: AuthenticatedUser<R>,
    JsonExtractor(request): JsonExtractor<EndSessionRequest>,
) -> Result<JsonResponse<EndSessionResponse>, ApiError>
where
    T: SilenceSessionServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    let response = service
        .end_session(auth_user.user_id(), auth_user.timezone(), request)
        .await?;

    Ok(JsonResponse::success_with_message(
        response,
        "Silence session ended",
    ))
}

/// Get user's session history with pagination
#[utoipa::path(
    get,
    path = "/api/silence/sessions",
    params(
        ("page" = Option<u32>, Query, description = "Page number (default: 1)"),
        ("limit" = Option<u32>, Query, description = "Items per page (default: 20)"),
        ("from_date" = Option<String>, Query, description = "Filter sessions from date (ISO 8601)"),
        ("to_date" = Option<String>, Query, description = "Filter sessions to date (ISO 8601)")
    ),
    responses(
        (status = 200, description = "Session list retrieved successfully", body = JsonResponse<SessionListResponse>),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Silence",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_sessions<T, R>(
    State(service): State<Arc<T>>,
    Query(params): Query<SessionQueryParams>,
    auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<SessionListResponse>, ApiError>
where
    T: SilenceSessionServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    let page = params.page.unwrap_or(1);
    let limit = params.limit.unwrap_or(20);

    let (response, total) = service
        .get_sessions(
            auth_user.user_id(),
            auth_user.timezone(),
            page,
            limit,
            params.from_date,
            params.to_date,
        )
        .await?;

    let meta = MetaResponse::new(page, limit, total);
    Ok(JsonResponse::success_paginated(response, meta))
}

/// Attach context to a completed session
#[utoipa::path(
    put,
    path = "/api/silence/sessions/{session_id}/context",
    params(
        ("session_id" = Uuid, Path, description = "Session ID")
    ),
    request_body = AttachContextRequest,
    responses(
        (status = 200, description = "Context attached successfully", body = JsonResponse<AttachContextResponse>),
        (status = 400, description = "Validation error"),
        (status = 401, description = "Unauthorized"),
        (status = 404, description = "Session not found")
    ),
    tag = "Silence",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn attach_context<T, R>(
    Path(session_id): Path<Uuid>,
    State(service): State<Arc<T>>,
    auth_user: AuthenticatedUser<R>,
    JsonExtractor(request): JsonExtractor<AttachContextRequest>,
) -> Result<JsonResponse<AttachContextResponse>, ApiError>
where
    T: SilenceSessionServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    // Validate request
    request
        .validate()
        .map_err(|e| BetweenError::Validation(e.to_string()))?;

    let response = service
        .attach_context(session_id, auth_user.user_id(), request)
        .await?;

    Ok(JsonResponse::success_with_message(
        response,
        "Context attached successfully",
    ))
}

/// Get session statistics
#[utoipa::path(
    get,
    path = "/api/silence/stats",
    responses(
        (status = 200, description = "Statistics retrieved successfully", body = JsonResponse<SessionStatsResponse>),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Silence",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_stats<T, R>(
    State(service): State<Arc<T>>,
    auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<SessionStatsResponse>, ApiError>
where
    T: SilenceSessionServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    let response = service.get_stats(auth_user.user_id()).await?;

    Ok(JsonResponse::success(response))
}

/// Get available silence contexts
#[utoipa::path(
    get,
    path = "/api/silence/contexts",
    responses(
        (status = 200, description = "Context list retrieved successfully", body = JsonResponse<ContextListResponse>),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Silence",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_contexts<T, R>(
    State(service): State<Arc<T>>,
    _auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<ContextListResponse>, ApiError>
where
    T: SilenceSessionServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    let response = service.get_contexts().await?;

    Ok(JsonResponse::success(response))
}
