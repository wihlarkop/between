use crate::shared::error::{BetweenError, Result};
use jsonwebtoken::{decode, encode, DecodingKey, EncodingKey, Header, Validation};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Serialize, Deserialize)]
pub struct Claims {
    pub sub: Uuid,          // User ID
    pub email: String,      // User email
    pub token_type: String, // "access" or "refresh"
    pub exp: i64,           // Expiration timestamp
    pub iat: i64,           // Issued at timestamp
}

/// Generate an access token
pub fn generate_access_token(
    user_id: Uuid,
    email: &str,
    secret: &str,
    expiry_seconds: i64,
) -> Result<String> {
    let now = chrono::Utc::now().timestamp();
    let claims = Claims {
        sub: user_id,
        email: email.to_string(),
        token_type: "access".to_string(),
        exp: now + expiry_seconds,
        iat: now,
    };

    encode(
        &Header::default(),
        &claims,
        &EncodingKey::from_secret(secret.as_bytes()),
    )
    .map_err(|e| BetweenError::Internal(format!("Failed to generate access token: {}", e)))
}

/// Generate a refresh token
pub fn generate_refresh_token(user_id: Uuid, secret: &str, expiry_seconds: i64) -> Result<String> {
    let now = chrono::Utc::now().timestamp();
    let claims = Claims {
        sub: user_id,
        email: String::new(), // Refresh token doesn't need email
        token_type: "refresh".to_string(),
        exp: now + expiry_seconds,
        iat: now,
    };

    encode(
        &Header::default(),
        &claims,
        &EncodingKey::from_secret(secret.as_bytes()),
    )
    .map_err(|e| BetweenError::Internal(format!("Failed to generate refresh token: {}", e)))
}

/// Verify and decode a JWT token
pub fn verify_token(token: &str, secret: &str) -> Result<Claims> {
    let validation = Validation::default();

    decode::<Claims>(
        token,
        &DecodingKey::from_secret(secret.as_bytes()),
        &validation,
    )
    .map(|data| data.claims)
    .map_err(|e| match e.kind() {
        jsonwebtoken::errors::ErrorKind::ExpiredSignature => {
            BetweenError::Unauthorized("Token has expired".to_string())
        }
        _ => BetweenError::Unauthorized(format!("Invalid token: {}", e)),
    })
}
