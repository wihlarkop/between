use thiserror::Error;

#[derive(Error, Debug)]
pub enum BetweenError {
    #[error("Database error: {0}")]
    Database(#[from] sqlx::Error),

    #[error("Validation error: {0}")]
    Validation(String),

    #[error("Not found: {0}")]
    NotFound(String),

    #[error("Conflict: {0}")]
    Conflict(String),

    #[error("Unauthorized: {0}")]
    Unauthorized(String),

    #[error("Forbidden: {0}")]
    Forbidden(String),

    #[error("Internal error: {0}")]
    Internal(String),

    #[error("Bad request: {0}")]
    BadRequest(String),

    #[error("Too many requests: {0}")]
    TooManyRequests(String),

    #[error("Request timeout: {0}")]
    Timeout(String),
}

pub type Result<T> = std::result::Result<T, BetweenError>;

impl From<validator::ValidationErrors> for BetweenError {
    fn from(err: validator::ValidationErrors) -> Self {
        BetweenError::Validation(err.to_string())
    }
}

impl BetweenError {
    /// Get HTTP status code for this error
    pub fn status_code(&self) -> u16 {
        match self {
            BetweenError::Database(_) => 500,
            BetweenError::NotFound(_) => 404,
            BetweenError::Conflict(_) => 409,
            BetweenError::Validation(_) => 400,
            BetweenError::Unauthorized(_) => 401,
            BetweenError::Forbidden(_) => 403,
            BetweenError::Internal(_) => 500,
            BetweenError::BadRequest(_) => 400,
            BetweenError::TooManyRequests(_) => 429,
            BetweenError::Timeout(_) => 408,
        }
    }

    /// Get error code string
    pub fn error_code(&self) -> String {
        match self {
            BetweenError::Database(_) => "DATABASE_ERROR",
            BetweenError::NotFound(_) => "NOT_FOUND",
            BetweenError::Conflict(_) => "CONFLICT",
            BetweenError::Validation(_) => "VALIDATION_ERROR",
            BetweenError::Unauthorized(_) => "UNAUTHORIZED",
            BetweenError::Forbidden(_) => "FORBIDDEN",
            BetweenError::Internal(_) => "INTERNAL_ERROR",
            BetweenError::BadRequest(_) => "BAD_REQUEST",
            BetweenError::TooManyRequests(_) => "TOO_MANY_REQUESTS",
            BetweenError::Timeout(_) => "TIMEOUT",
        }
        .to_string()
    }
}

/// Common error messages as constants to reduce string allocations
pub mod error_messages {
    // Session errors
    pub const SESSION_NOT_FOUND: &str = "Session not found";
    pub const NO_ACTIVE_SESSION: &str = "No active session found";
    pub const ACTIVE_SESSION_EXISTS: &str = "An active session already exists";
    pub const SESSION_MIN_DURATION: &str = "Session duration must be at least";

    // User errors
    pub const USER_NOT_FOUND: &str = "User not found";
    pub const INVALID_CREDENTIALS: &str = "Invalid credentials";
    pub const MISSING_AUTH_HEADER: &str = "Missing authorization header";
    pub const INVALID_AUTH_FORMAT: &str = "Invalid authorization format";
    pub const INVALID_TOKEN: &str = "Invalid or expired token";

    // Context errors
    pub const INVALID_CONTEXT_CODE: &str = "Invalid context code";
}
