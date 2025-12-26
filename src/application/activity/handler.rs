use crate::domain::activity::service::ActivityServiceTrait;
use crate::domain::user::repository::UserRepositoryTrait;
use crate::shared::response::{ApiError, JsonResponse, MetaResponse};
use crate::shared::schema::activity::{
    ActivityItem, ActivityListResponse, ActivityQueryParams, ActivityStatsResponse,
};
use crate::shared::AuthenticatedUser;
use axum::extract::{Path, Query, State};
use std::sync::Arc;
use uuid::Uuid;

/// Get user's activities with optional module filtering and pagination
#[utoipa::path(
    get,
    path = "/api/sessions",
    params(
        ("module" = Option<String>, Query, description = "Filter by module (e.g., 'silence', 'decision')"),
        ("page" = Option<u32>, Query, description = "Page number (default: 1)"),
        ("limit" = Option<u32>, Query, description = "Items per page (default: 20, max: 100)"),
        ("from_date" = Option<String>, Query, description = "Filter activities from date (ISO 8601)"),
        ("to_date" = Option<String>, Query, description = "Filter activities to date (ISO 8601)")
    ),
    responses(
        (status = 200, description = "Activity list retrieved successfully", body = JsonResponse<ActivityListResponse>),
        (status = 401, description = "Unauthorized"),
        (status = 400, description = "Invalid query parameters")
    ),
    tag = "Activity",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_activities<T, R>(
    State(service): State<Arc<T>>,
    auth_user: AuthenticatedUser<R>,
    Query(params): Query<ActivityQueryParams>,
) -> Result<JsonResponse<ActivityListResponse>, ApiError>
where
    T: ActivityServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    // Validate and set defaults
    let page = params.page.unwrap_or(1).max(1);
    let limit = params.limit.unwrap_or(20).min(100).max(1);

    let (response, total) = service
        .get_activities(
            auth_user.user_id(),
            auth_user.timezone(),
            params.module,
            page,
            limit,
            params.from_date,
            params.to_date,
        )
        .await?;

    let total_pages = (total as f64 / limit as f64).ceil() as u32;

    Ok(JsonResponse::success_paginated(
        response,
        MetaResponse {
            page,
            limit,
            total_data: total,
            total_pages,
        },
    ))
}

/// Get user's activity statistics
#[utoipa::path(
    get,
    path = "/api/sessions/stats",
    params(
        ("module" = Option<String>, Query, description = "Filter stats by module (e.g., 'silence', 'decision')")
    ),
    responses(
        (status = 200, description = "Activity statistics retrieved successfully", body = JsonResponse<ActivityStatsResponse>),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Activity",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_stats<T, R>(
    State(service): State<Arc<T>>,
    auth_user: AuthenticatedUser<R>,
    Query(params): Query<ActivityQueryParams>,
) -> Result<JsonResponse<ActivityStatsResponse>, ApiError>
where
    T: ActivityServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    let response = service
        .get_stats(auth_user.user_id(), params.module)
        .await?;

    Ok(JsonResponse::success(response))
}

/// Get a single activity by ID
#[utoipa::path(
    get,
    path = "/api/sessions/{id}",
    params(
        ("id" = Uuid, Path, description = "Activity ID")
    ),
    responses(
        (status = 200, description = "Activity retrieved successfully", body = JsonResponse<ActivityItem>),
        (status = 401, description = "Unauthorized"),
        (status = 404, description = "Activity not found")
    ),
    tag = "Activity",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_activity<T, R>(
    Path(id): Path<Uuid>,
    State(service): State<Arc<T>>,
    auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<ActivityItem>, ApiError>
where
    T: ActivityServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    let activity = service
        .get_activity_by_id(id, auth_user.user_id(), auth_user.timezone())
        .await?;

    Ok(JsonResponse::success(activity))
}
