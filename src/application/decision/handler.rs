use crate::domain::decision::service::DecisionService;
use crate::domain::user::repository::UserRepositoryTrait;
use crate::shared::error::BetweenError;
use crate::shared::response::{ApiError, JsonResponse, MetaResponse};
use crate::shared::schema::context::{ContextItem, ContextListResponse};
use crate::shared::schema::decision::{
    get_decision_status, CreateDecisionRequest,
    CreateDecisionResponse, DecisionItem, DecisionListResponse, DecisionQueryParams,
    DecisionStatsResponse, GetDecisionResponse, UpdateDecisionRequest, UpdateDecisionResponse,
};
use crate::shared::{AuthenticatedUser, JsonExtractor};
use axum::extract::{Path, Query, State};
use std::sync::Arc;
use uuid::Uuid;
use validator::Validate;

/// Create a new decision
#[utoipa::path(
    post,
    path = "/api/decisions",
    request_body = CreateDecisionRequest,
    responses(
        (status = 201, description = "Decision created successfully", body = JsonResponse<CreateDecisionResponse>),
        (status = 400, description = "Validation error"),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Decision",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn create_decision<R>(
    State(service): State<Arc<DecisionService>>,
    auth_user: AuthenticatedUser<R>,
    JsonExtractor(request): JsonExtractor<CreateDecisionRequest>,
) -> Result<JsonResponse<CreateDecisionResponse>, ApiError>
where
    R: UserRepositoryTrait + Send + Sync,
{
    // Validate request
    request
        .validate()
        .map_err(|e| BetweenError::Validation(e.to_string()))?;

    // Convert schema to service request
    let service_request = crate::domain::decision::service::CreateDecisionRequest {
        title: request.title,
        decided_at: request.decided_at,
        reason: request.reason,
        expectation: request.expectation,
        completed_at: request.completed_at,
        actual_result: request.actual_result,
        learnings: request.learnings,
        context_code: request.context_code,
        tags: request.tags,
    };

    let decision = service
        .create_decision(auth_user.user_id(), service_request)
        .await?;

    let response = CreateDecisionResponse {
        id: decision.id,
        user_id: decision.user_id,
        title: decision.title,
        decided_at: decision.decided_at,
        reason: decision.reason,
        expectation: decision.expectation,
        completed_at: decision.completed_at,
        actual_result: decision.actual_result,
        learnings: decision.learnings,
        context_code: decision.context_code,
        tags: decision.tags,
        created_at: decision.created_at,
        status: get_decision_status(decision.decided_at, decision.completed_at),
    };

    Ok(JsonResponse::created(response, "Decision created"))
}

/// Update an existing decision
#[utoipa::path(
    put,
    path = "/api/decisions/{decision_id}",
    params(
        ("decision_id" = Uuid, Path, description = "Decision ID")
    ),
    request_body = UpdateDecisionRequest,
    responses(
        (status = 200, description = "Decision updated successfully", body = JsonResponse<UpdateDecisionResponse>),
        (status = 400, description = "Validation error"),
        (status = 401, description = "Unauthorized"),
        (status = 403, description = "Forbidden"),
        (status = 404, description = "Decision not found")
    ),
    tag = "Decision",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn update_decision<R>(
    Path(decision_id): Path<Uuid>,
    State(service): State<Arc<DecisionService>>,
    auth_user: AuthenticatedUser<R>,
    JsonExtractor(request): JsonExtractor<UpdateDecisionRequest>,
) -> Result<JsonResponse<UpdateDecisionResponse>, ApiError>
where
    R: UserRepositoryTrait + Send + Sync,
{
    // Validate request
    request
        .validate()
        .map_err(|e| BetweenError::Validation(e.to_string()))?;

    // Convert schema to service request
    let service_request = crate::domain::decision::service::UpdateDecisionRequest {
        title: request.title,
        decided_at: request.decided_at,
        reason: request.reason,
        expectation: request.expectation,
        completed_at: request.completed_at,
        actual_result: request.actual_result,
        learnings: request.learnings,
        context_code: request.context_code,
        tags: request.tags,
    };

    let decision = service
        .update_decision(decision_id, auth_user.user_id(), service_request)
        .await?;

    let response = UpdateDecisionResponse {
        id: decision.id,
        user_id: decision.user_id,
        title: decision.title,
        decided_at: decision.decided_at,
        reason: decision.reason,
        expectation: decision.expectation,
        completed_at: decision.completed_at,
        actual_result: decision.actual_result,
        learnings: decision.learnings,
        context_code: decision.context_code,
        tags: decision.tags,
        created_at: decision.created_at,
        status: get_decision_status(decision.decided_at, decision.completed_at),
    };

    Ok(JsonResponse::success_with_message(
        response,
        "Decision updated",
    ))
}

/// Get a specific decision
#[utoipa::path(
    get,
    path = "/api/decisions/{decision_id}",
    params(
        ("decision_id" = Uuid, Path, description = "Decision ID")
    ),
    responses(
        (status = 200, description = "Decision retrieved successfully", body = JsonResponse<GetDecisionResponse>),
        (status = 401, description = "Unauthorized"),
        (status = 403, description = "Forbidden"),
        (status = 404, description = "Decision not found")
    ),
    tag = "Decision",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_decision<R>(
    Path(decision_id): Path<Uuid>,
    State(service): State<Arc<DecisionService>>,
    auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<GetDecisionResponse>, ApiError>
where
    R: UserRepositoryTrait + Send + Sync,
{
    let decision = service
        .get_decision(decision_id, auth_user.user_id())
        .await?;

    let response = GetDecisionResponse {
        id: decision.id,
        user_id: decision.user_id,
        title: decision.title,
        decided_at: decision.decided_at,
        reason: decision.reason,
        expectation: decision.expectation,
        completed_at: decision.completed_at,
        actual_result: decision.actual_result,
        learnings: decision.learnings,
        context_code: decision.context_code,
        tags: decision.tags,
        created_at: decision.created_at,
        status: get_decision_status(decision.decided_at, decision.completed_at),
    };

    Ok(JsonResponse::success(response))
}

/// Delete a decision
#[utoipa::path(
    delete,
    path = "/api/decisions/{decision_id}",
    params(
        ("decision_id" = Uuid, Path, description = "Decision ID")
    ),
    responses(
        (status = 200, description = "Decision deleted successfully"),
        (status = 401, description = "Unauthorized"),
        (status = 403, description = "Forbidden"),
        (status = 404, description = "Decision not found")
    ),
    tag = "Decision",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn delete_decision<R>(
    Path(decision_id): Path<Uuid>,
    State(service): State<Arc<DecisionService>>,
    auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<()>, ApiError>
where
    R: UserRepositoryTrait + Send + Sync,
{
    service
        .delete_decision(decision_id, auth_user.user_id())
        .await?;

    Ok(JsonResponse::success_with_message(
        (),
        "Decision deleted",
    ))
}

/// Get user's decisions with pagination and filters
#[utoipa::path(
    get,
    path = "/api/decisions",
    params(
        ("page" = Option<u32>, Query, description = "Page number (default: 1)"),
        ("limit" = Option<u32>, Query, description = "Items per page (default: 20)"),
        ("from_date" = Option<String>, Query, description = "Filter from date (ISO 8601)"),
        ("to_date" = Option<String>, Query, description = "Filter to date (ISO 8601)"),
        ("context_code" = Option<i16>, Query, description = "Filter by context code"),
        ("tags" = Option<String>, Query, description = "Filter by tags (comma-separated)"),
        ("status" = Option<String>, Query, description = "Filter by status (pending, completed, all)")
    ),
    responses(
        (status = 200, description = "Decision list retrieved successfully", body = JsonResponse<DecisionListResponse>),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Decision",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_decisions<R>(
    State(service): State<Arc<DecisionService>>,
    Query(params): Query<DecisionQueryParams>,
    auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<DecisionListResponse>, ApiError>
where
    R: UserRepositoryTrait + Send + Sync,
{
    let page = params.page.unwrap_or(1);
    let limit = params.limit.unwrap_or(20);

    // Parse tags if provided
    let tags = params.tags.as_ref().map(|t| {
        t.split(',')
            .map(|s| s.trim().to_string())
            .filter(|s| !s.is_empty())
            .collect()
    });

    let (decisions, total) = service
        .get_decisions(
            auth_user.user_id(),
            page,
            limit,
            params.from_date,
            params.to_date,
            params.context_code,
            tags,
            params.status,
        )
        .await?;

    let decision_items: Vec<DecisionItem> = decisions
        .into_iter()
        .map(|d| DecisionItem {
            id: d.id,
            title: d.title,
            decided_at: d.decided_at,
            completed_at: d.completed_at,
            context_code: d.context_code,
            tags: d.tags,
            created_at: d.created_at,
            status: get_decision_status(d.decided_at, d.completed_at),
        })
        .collect();

    let response = DecisionListResponse {
        decisions: decision_items,
    };

    let meta = MetaResponse::new(page, limit, total);
    Ok(JsonResponse::success_paginated(response, meta))
}

/// Get decision statistics
#[utoipa::path(
    get,
    path = "/api/decisions/stats",
    responses(
        (status = 200, description = "Statistics retrieved successfully", body = JsonResponse<DecisionStatsResponse>),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Decision",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_stats<R>(
    State(service): State<Arc<DecisionService>>,
    auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<DecisionStatsResponse>, ApiError>
where
    R: UserRepositoryTrait + Send + Sync,
{
    let stats = service.get_stats(auth_user.user_id()).await?;

    let response = DecisionStatsResponse {
        total_decisions: stats.total_decisions,
        pending_decisions: stats.pending_decisions,
        completed_decisions: stats.completed_decisions,
        decisions_this_week: stats.decisions_this_week,
        decisions_this_month: stats.decisions_this_month,
        avg_time_to_completion_days: stats.avg_time_to_completion_days,
        most_common_context: stats.most_common_context.map(|c| {
            crate::shared::schema::decision::ContextCount {
                context_code: c.context_code,
                context_label: c.context_label,
                count: c.count,
            }
        }),
        by_month: stats
            .by_month
            .into_iter()
            .map(|m| crate::shared::schema::decision::MonthCount {
                month: m.month,
                count: m.count,
            })
            .collect(),
        by_context: stats
            .by_context
            .into_iter()
            .map(|c| crate::shared::schema::decision::ContextCount {
                context_code: c.context_code,
                context_label: c.context_label,
                count: c.count,
            })
            .collect(),
    };

    Ok(JsonResponse::success(response))
}

/// Get available decision contexts
#[utoipa::path(
    get,
    path = "/api/decisions/contexts",
    responses(
        (status = 200, description = "Context list retrieved successfully", body = JsonResponse<ContextListResponse>),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Decision",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_contexts<R>(
    State(service): State<Arc<DecisionService>>,
    _auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<ContextListResponse>, ApiError>
where
    R: UserRepositoryTrait + Send + Sync,
{
    let contexts = service.get_contexts().await?;

    let response = ContextListResponse {
        contexts: contexts
            .into_iter()
            .map(|c| ContextItem {
                code: c.code,
                label: c.label,
                module: c.module,
            })
            .collect(),
    };

    Ok(JsonResponse::success(response))
}
