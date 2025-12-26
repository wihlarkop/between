use crate::domain::context::service::ContextService;
use crate::domain::user::repository::UserRepositoryTrait;
use crate::shared::response::{ApiError, JsonResponse};
use crate::shared::schema::context::{ContextItem, ContextListResponse, ContextQueryParams};
use crate::shared::AuthenticatedUser;
use axum::extract::{Query, State};
use std::sync::Arc;

/// Get all available contexts, optionally filtered by module
#[utoipa::path(
    get,
    path = "/api/contexts",
    params(
        ("module" = Option<String>, Query, description = "Filter by module (silence, decision, all, or empty for all)")
    ),
    responses(
        (status = 200, description = "Context list retrieved successfully", body = JsonResponse<ContextListResponse>),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Context",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn get_contexts<R>(
    State(service): State<Arc<ContextService>>,
    Query(params): Query<ContextQueryParams>,
    _auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<ContextListResponse>, ApiError>
where
    R: UserRepositoryTrait + Send + Sync,
{
    // Get contexts from service
    let contexts = service.get_contexts(params.module).await?;

    // Convert to response DTOs
    let context_items: Vec<ContextItem> = contexts
        .into_iter()
        .map(|c| ContextItem {
            code: c.code,
            label: c.label,
            module: c.module,
        })
        .collect();

    let response = ContextListResponse {
        contexts: context_items,
    };

    Ok(JsonResponse::success(response))
}
