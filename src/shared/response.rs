use crate::shared::error::BetweenError;
use axum::{
    http::StatusCode,
    response::{IntoResponse, Response},
    Json,
};
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::sync::Mutex;
use utoipa::ToSchema;

/// Cached timestamp with millisecond precision to reduce Utc::now() calls
static CACHED_TIMESTAMP: Mutex<Option<(DateTime<Utc>, u64)>> = Mutex::new(None);

/// Get cached timestamp (refreshes every 1ms)
pub fn get_timestamp() -> DateTime<Utc> {
    let now = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap()
        .as_millis() as u64;

    let mut cache = CACHED_TIMESTAMP.lock().unwrap();

    match *cache {
        Some((timestamp, cached_ms)) if cached_ms == now => timestamp,
        _ => {
            let timestamp = Utc::now();
            *cache = Some((timestamp, now));
            timestamp
        }
    }
}

/// Helper function to create error responses from any error type
/// This consolidates the duplicated error-to-response logic
pub fn create_error_response(status_code: u16, message: String, error_code: String) -> Response {
    let json_response = JsonResponse::<()>::error(status_code, message, Some(error_code));
    let status = StatusCode::from_u16(status_code).unwrap_or(StatusCode::INTERNAL_SERVER_ERROR);
    (status, Json(json_response)).into_response()
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct JsonResponse<T> {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub data: Option<T>,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub message: Option<String>,

    pub success: bool,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub meta: Option<MetaResponse>,

    pub status_code: u16,

    pub timestamp: DateTime<Utc>,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub error_code: Option<String>,
}

impl<T> JsonResponse<T> {
    /// Create a successful response with data
    pub fn success(data: T) -> Self {
        Self {
            data: Some(data),
            message: None,
            success: true,
            meta: None,
            status_code: 200,
            timestamp: get_timestamp(),
            error_code: None,
        }
    }

    /// Create a successful response with data and custom message
    pub fn success_with_message(data: T, message: impl Into<String>) -> Self {
        Self {
            data: Some(data),
            message: Some(message.into()),
            success: true,
            meta: None,
            status_code: 200,
            timestamp: get_timestamp(),
            error_code: None,
        }
    }

    /// Create a successful paginated response
    pub fn success_paginated(data: T, meta: MetaResponse) -> Self {
        Self {
            data: Some(data),
            message: None,
            success: true,
            meta: Some(meta),
            status_code: 200,
            timestamp: get_timestamp(),
            error_code: None,
        }
    }

    /// Create a created response (201)
    pub fn created(data: T, message: impl Into<String>) -> Self {
        Self {
            data: Some(data),
            message: Some(message.into()),
            success: true,
            meta: None,
            status_code: 201,
            timestamp: get_timestamp(),
            error_code: None,
        }
    }
}

impl<T: serde::Serialize> IntoResponse for JsonResponse<T> {
    fn into_response(self) -> Response {
        let status =
            StatusCode::from_u16(self.status_code).unwrap_or(StatusCode::INTERNAL_SERVER_ERROR);
        (status, Json(self)).into_response()
    }
}

impl JsonResponse<()> {
    /// Create a no-content success response (204)
    pub fn no_content(message: impl Into<String>) -> Self {
        Self {
            data: None,
            message: Some(message.into()),
            success: true,
            meta: None,
            status_code: 204,
            timestamp: get_timestamp(),
            error_code: None,
        }
    }

    /// Create an error response
    /// If status_code is less than 400, it will default to 400
    pub fn error(status_code: u16, message: impl Into<String>, error_code: Option<String>) -> Self {
        Self {
            data: None,
            message: Some(message.into()),
            success: false,
            meta: None,
            status_code: if status_code >= 400 { status_code } else { 400 },
            timestamp: get_timestamp(),
            error_code,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, ToSchema)]
pub struct MetaResponse {
    pub page: u32,
    pub limit: u32,
    pub total_data: u64,
    pub total_pages: u32,
}

impl MetaResponse {
    pub fn new(page: u32, limit: u32, total_data: u64) -> Self {
        let total_pages = if limit > 0 {
            ((total_data as f64) / (limit as f64)).ceil() as u32
        } else {
            0
        };

        Self {
            page,
            limit,
            total_data,
            total_pages,
        }
    }
}

/// API error wrapper for Axum handlers
pub struct ApiError(pub BetweenError);

impl From<BetweenError> for ApiError {
    fn from(err: BetweenError) -> Self {
        ApiError(err)
    }
}

impl IntoResponse for ApiError {
    fn into_response(self) -> Response {
        create_error_response(
            self.0.status_code(),
            self.0.to_string(),
            self.0.error_code(),
        )
    }
}

pub type ApiResult<T> = Result<T, ApiError>;
