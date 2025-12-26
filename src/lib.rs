pub mod app;
pub mod application;
pub mod config;
pub mod db;
pub mod domain;
pub mod infrastructure;
pub mod openapi;
pub mod shared;

// Re-export commonly used items
pub use app::{create_router, AppState};
pub use config::AppConfig;
pub use shared::{BetweenError, Result};
