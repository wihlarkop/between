use sea_orm_migration::prelude::*;

#[tokio::main]
async fn main() {
    // Try current directory
    dotenvy::dotenv().ok();

    // If DATABASE_URL is still missing, try parent directory
    if std::env::var("DATABASE_URL").is_err() {
        if let Ok(parent) = std::env::current_dir().map(|p| p.parent().map(|p| p.to_path_buf())) {
            if let Some(parent_path) = parent {
                dotenvy::from_path(parent_path.join(".env")).ok();
            }
        }
    }

    // If still missing, try to build it from components
    if std::env::var("DATABASE_URL").is_err() {
        let user = std::env::var("DB_USERNAME").unwrap_or_else(|_| "postgres".into());
        let pass = std::env::var("DB_PASSWORD").unwrap_or_else(|_| "postgres".into());
        let host = std::env::var("DB_HOST").unwrap_or_else(|_| "localhost".into());
        let port = std::env::var("DB_PORT").unwrap_or_else(|_| "5432".into());
        let name = std::env::var("DB_NAME").unwrap_or_else(|_| "between".into());

        let url = format!("postgres://{}:{}@{}:{}/{}", user, pass, host, port, name);
        std::env::set_var("DATABASE_URL", url);
    }

    cli::run_cli(migration::Migrator).await;
}
