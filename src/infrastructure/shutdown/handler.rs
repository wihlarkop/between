use sqlx::PgPool;
use std::time::Duration;

/// Perform graceful shutdown cleanup
///
/// This function handles cleanup tasks when the server is shutting down:
/// - Closes database connection pool
/// - Logs shutdown progress
pub async fn graceful_shutdown(pool: PgPool) {
    tracing::info!("Starting graceful shutdown...");

    // Close database connection pool with timeout
    let shutdown_timeout = Duration::from_secs(30);

    match tokio::time::timeout(shutdown_timeout, pool.close()).await {
        Ok(_) => {
            tracing::info!("Database connection pool closed successfully");
        }
        Err(_) => {
            tracing::warn!(
                "Database pool close timeout after {} seconds, forcing shutdown",
                shutdown_timeout.as_secs()
            );
        }
    }

    tracing::info!("Graceful shutdown completed");
}
