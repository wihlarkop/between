use axum::{
    extract::{rejection::JsonRejection, FromRequest, Request},
    response::{IntoResponse, Response},
    Json,
};
use serde::de::DeserializeOwned;

use crate::shared::response::create_error_response;

/// Custom JSON extractor that returns JsonResponse for all errors
pub struct JsonExtractor<T>(pub T);

impl<T, S> FromRequest<S> for JsonExtractor<T>
where
    T: DeserializeOwned,
    S: Send + Sync,
{
    type Rejection = JsonError;

    async fn from_request(req: Request, state: &S) -> Result<Self, Self::Rejection> {
        match Json::<T>::from_request(req, state).await {
            Ok(Json(value)) => Ok(JsonExtractor(value)),
            Err(rejection) => Err(JsonError(rejection)),
        }
    }
}

/// Custom rejection type for JSON errors
pub struct JsonError(JsonRejection);

impl IntoResponse for JsonError {
    fn into_response(self) -> Response {
        let (status_code, message) = match self.0 {
            JsonRejection::JsonDataError(err) => (400, format!("Invalid JSON format: {}", err)),
            JsonRejection::JsonSyntaxError(err) => (400, format!("JSON syntax error: {}", err)),
            JsonRejection::MissingJsonContentType(err) => {
                (415, format!("Missing JSON content-type: {}", err))
            }
            JsonRejection::BytesRejection(err) => {
                (400, format!("Failed to read request body: {}", err))
            }
            _ => (400, "Invalid JSON request".to_string()),
        };

        create_error_response(status_code, message, "BAD_REQUEST".to_string())
    }
}
