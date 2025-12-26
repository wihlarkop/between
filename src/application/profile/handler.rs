use std::sync::Arc;

use axum::extract::State;

use crate::domain::profile::service::ProfileServiceTrait;
use crate::domain::user::UserRepositoryTrait;
use crate::shared::schema::profile::{MyProfileResponse, UpdateProfileRequest};
use crate::shared::{ApiError, AuthenticatedUser, JsonExtractor, JsonResponse};

/// My profile
#[utoipa::path(
    get,
    path = "/api/profile/me",
    responses(
        (status = 200, description = "Success Get Profile", body = JsonResponse<MyProfileResponse>),
    ),
    tag = "Profile",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn my_profile<T, R>(
    State(profile_service): State<Arc<T>>,
    auth_user: AuthenticatedUser<R>,
) -> Result<JsonResponse<MyProfileResponse>, ApiError>
where
    T: ProfileServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    // Call service
    let response = profile_service.my_profile(auth_user.user_id()).await?;

    Ok(JsonResponse::success(response))
}

/// Update profile
#[utoipa::path(
    put,
    path = "/api/profile",
    request_body = UpdateProfileRequest,
    responses(
        (status = 200, description = "Success Update Profile"),
        (status = 400, description = "Validation error"),
        (status = 401, description = "Unauthorized")
    ),
    tag = "Profile",
    security(
        ("bearer_auth" = [])
    )
)]
pub async fn update_profile<T, R>(
    State(profile_service): State<Arc<T>>,
    auth_user: AuthenticatedUser<R>,
    JsonExtractor(request): JsonExtractor<UpdateProfileRequest>,
) -> Result<JsonResponse<()>, ApiError>
where
    T: ProfileServiceTrait + Send + Sync,
    R: UserRepositoryTrait + Send + Sync,
{
    // Call service
    profile_service
        .update_profile(auth_user.user_id(), request)
        .await?;

    Ok(JsonResponse::no_content(String::from(
        "Profile updated successfully",
    )))
}
