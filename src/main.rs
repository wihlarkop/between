use between::{create_router, AppConfig, AppState};
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    // Load environment variables
    dotenvy::dotenv().ok();

    // Initialize tracing
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| "info,between=debug".into()),
        )
        .with(tracing_subscriber::fmt::layer())
        .init();

    // Load configuration
    let config =
        AppConfig::from_env().map_err(|e| anyhow::anyhow!("Failed to load config: {}", e))?;

    tracing::info!("Starting Between API server...");
    tracing::info!("Database: {}", config.database_url());
    tracing::info!("Server: {}:{}", config.api_host, config.api_port);

    // Create database connection pool
    let pool = between::db::create_pool(&config)
        .await
        .map_err(|e| anyhow::anyhow!("Failed to create database pool: {}", e))?;

    tracing::info!("Database connection pool created");

    // Create application state
    let state = AppState::new(
        pool.clone(),
        config.jwt_secret.clone(),
        config.jwt_access_token_expiry,
        config.jwt_refresh_token_expiry,
    );

    // Build application router
    let app = create_router(state);

    // Setup graceful shutdown signal handlers
    let shutdown_signal = between::infrastructure::shutdown::setup_signal_handlers();

    // Start server
    let bind_addr = format!("{}:{}", config.api_host, config.api_port);

    let listener = tokio::net::TcpListener::bind(&bind_addr)
        .await
        .map_err(|e| anyhow::anyhow!("Failed to bind to {}: {}", bind_addr, e))?;

    let addr = listener
        .local_addr()
        .map_err(|e| anyhow::anyhow!("Failed to get local address: {}", e))?;

    tracing::info!("Server listening on {}", addr);
    tracing::info!("Health check: http://{}/health", addr);

    // Run server with graceful shutdown
    axum::serve(listener, app)
        .with_graceful_shutdown(async move {
            shutdown_signal.await.ok();
            tracing::info!("Shutdown signal received, stopping server...");
        })
        .await
        .map_err(|e| anyhow::anyhow!("Server error: {}", e))?;

    // Cleanup after server stops
    between::infrastructure::shutdown::graceful_shutdown(pool).await;

    tracing::info!("Between API server stopped");

    Ok(())
}
