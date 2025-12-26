use envconfig::Envconfig;

#[derive(Envconfig, Clone, Debug)]
pub struct AppConfig {
    // Database Configuration
    #[envconfig(from = "DB_USERNAME", default = "between")]
    pub db_username: String,

    #[envconfig(from = "DB_PASSWORD")]
    pub db_password: String,

    #[envconfig(from = "DB_HOST", default = "localhost")]
    pub db_host: String,

    #[envconfig(from = "DB_PORT", default = "5432")]
    pub db_port: u16,

    #[envconfig(from = "DB_NAME", default = "between_dev")]
    pub db_name: String,

    #[envconfig(from = "DB_MAX_CONNECTIONS", default = "20")]
    pub db_max_connections: u32,

    #[envconfig(from = "DB_MIN_CONNECTIONS", default = "5")]
    pub db_min_connections: u32,

    #[envconfig(from = "DB_CONNECT_TIMEOUT_SECONDS", default = "10")]
    pub db_connect_timeout_seconds: u64,

    #[envconfig(from = "DB_IDLE_TIMEOUT_SECONDS", default = "600")]
    pub db_idle_timeout_seconds: u64,

    // JWT Configuration
    #[envconfig(from = "JWT_SECRET")]
    pub jwt_secret: String,

    #[envconfig(from = "JWT_ACCESS_TOKEN_EXPIRY", default = "86400")]
    pub jwt_access_token_expiry: i64, // 1 day in seconds

    #[envconfig(from = "JWT_REFRESH_TOKEN_EXPIRY", default = "432000")]
    pub jwt_refresh_token_expiry: i64, // 5 days in seconds

    // Server Configuration
    #[envconfig(from = "API_HOST", default = "0.0.0.0")]
    pub api_host: String,

    #[envconfig(from = "API_PORT", default = "8000")]
    pub api_port: u16,

    // Log Level
    #[envconfig(from = "RUST_LOG", default = "info")]
    pub rust_log: String,
}

impl AppConfig {
    /// Load configuration from environment variables
    pub fn from_env() -> Result<Self, envconfig::Error> {
        Self::init_from_env()
    }

    /// Build PostgreSQL connection URL
    pub fn database_url(&self) -> String {
        format!(
            "postgresql://{}:{}@{}:{}/{}",
            self.db_username, self.db_password, self.db_host, self.db_port, self.db_name
        )
    }
}
