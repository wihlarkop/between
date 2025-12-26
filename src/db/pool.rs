use crate::config::AppConfig;
use sqlx::postgres::{PgPool, PgPoolOptions};
use sqlx::Error as SqlxError;
use std::time::Duration;

pub async fn create_pool(config: &AppConfig) -> Result<PgPool, SqlxError> {
    PgPoolOptions::new()
        .max_connections(config.db_max_connections)
        .min_connections(config.db_min_connections)
        .acquire_timeout(Duration::from_secs(config.db_connect_timeout_seconds))
        .idle_timeout(Duration::from_secs(config.db_idle_timeout_seconds))
        .connect(&config.database_url())
        .await
}
