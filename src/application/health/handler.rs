use crate::shared::response::{get_timestamp, JsonResponse};
use crate::shared::schema::health::HealthData;
use axum::extract::State;
use sqlx::PgPool;

/// Health check endpoint
///
/// Returns the health status of the application and its dependencies.
#[utoipa::path(
    get,
    path = "/health",
    responses(
        (status = 200, description = "Service is healthy", body = JsonResponse<HealthData>),
        (status = 503, description = "Service is unhealthy", body = JsonResponse<HealthData>)
    ),
    tag = "Health"
)]
pub async fn health_check(State(pool): State<PgPool>) -> JsonResponse<HealthData> {
    // Check PostgreSQL connection
    let postgres_healthy = sqlx::query("SELECT 1").fetch_one(&pool).await.is_ok();

    if postgres_healthy {
        JsonResponse::success(HealthData { postgres: true })
    } else {
        // Create a custom error response with data field for health status
        JsonResponse {
            data: Some(HealthData { postgres: false }),
            message: Some("Database connection failed".to_string()),
            success: false,
            meta: None,
            status_code: 503,
            timestamp: get_timestamp(),
            error_code: Some("DATABASE_UNHEALTHY".to_string()),
        }
    }
}
