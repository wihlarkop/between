use crate::application::{activity, context, decision, health, profile, silence, user};
use crate::shared::response::{JsonResponse, MetaResponse};
use crate::shared::schema::{activity::*, context::*, decision::*, health::*, profile::*, silence::*, user::*};
use utoipa::openapi::security::{HttpAuthScheme, HttpBuilder, SecurityScheme};
use utoipa::{Modify, OpenApi};

#[derive(OpenApi)]
#[openapi(
    paths(
        // Health
        health::handler::health_check,

        // Authentication
        user::handler::register,
        user::handler::login,
        user::handler::refresh_token,

        // Activity (unified sessions across all modules)
        activity::handler::get_activities,
        activity::handler::get_stats,

        // Decision
        decision::handler::create_decision,
        decision::handler::update_decision,
        decision::handler::get_decision,
        decision::handler::delete_decision,
        decision::handler::get_decisions,
        decision::handler::get_stats,

        // Context (shared across modules)
        context::handler::get_contexts,

        // Profile
        profile::handler::my_profile,
        profile::handler::update_profile,

        // Silence Sessions
        silence::handler::start_session,
        silence::handler::end_session,
        silence::handler::get_sessions,
        silence::handler::attach_context,
        silence::handler::get_stats,
    ),
    components(
        schemas(
            // Generic responses
            JsonResponse<RegisterResponse>,
            JsonResponse<LoginResponse>,
            JsonResponse<RefreshTokenResponse>,
            JsonResponse<MyProfileResponse>,

            MetaResponse,

            // Health
            HealthData,
            JsonResponse<HealthData>,

            // User schemas
            RegisterRequest,
            JsonResponse<RegisterResponse>,
            JsonResponse<UserResponse>,
            JsonResponse<TokenResponse>,
            LoginRequest,
            LoginResponse,
            RefreshTokenRequest,

            // Activity schemas (unified sessions)
           ActivityItem,
           JsonResponse<ActivityListResponse>,
           JsonResponse<ActivityStatsResponse>,
           crate::shared::schema::activity::ModuleCount,
           crate::shared::schema::activity::ContextCount,

            // Silence schemas
           SessionItem,
           AttachContextRequest,
           HourCount,
           DayCount,
           JsonResponse<StartSessionResponse>,
           JsonResponse<EndSessionResponse>,
           JsonResponse<SessionListResponse>,
           JsonResponse<AttachContextResponse>,
           JsonResponse<SessionStatsResponse>,

            // Decision schemas
           CreateDecisionRequest,
           JsonResponse<CreateDecisionResponse>,
           UpdateDecisionRequest,
           JsonResponse<UpdateDecisionResponse>,
           JsonResponse<GetDecisionResponse>,
           DecisionItem,
           JsonResponse<DecisionListResponse>,
           JsonResponse<DecisionStatsResponse>,
           MonthCount,

            // Context schemas (shared)
            ContextItem,
            JsonResponse<ContextListResponse>,
        )
    ),
    modifiers(&SecurityAddon),
    tags(
        (name = "Health", description = "Health check endpoints"),
        (name = "Authentication", description = "User authentication and authorization endpoints"),
        (name = "Activity", description = "Unified activity tracking across all modules (silence, decision, etc.)"),
        (name = "Decision", description = "Decision tracking and analysis endpoints"),
        (name = "Context", description = "Shared context management across all modules"),
        (name = "Silence", description = "Silence session management endpoints")
    ),
    info(
        title = "Between API - Silence Module",
        version = "1.0.0",
        description = "REST API for the Between platform's Silence module. Allows users to consciously log periods of silence in their daily lives.",
        contact(
            name = "Between Team",
            email = "support@between.app"
        ),
        license(
            name = "MIT"
        )
    )
)]
pub struct ApiDoc;

struct SecurityAddon;

impl Modify for SecurityAddon {
    fn modify(&self, openapi: &mut utoipa::openapi::OpenApi) {
        if let Some(components) = openapi.components.as_mut() {
            components.add_security_scheme(
                "bearer_auth",
                SecurityScheme::Http(
                    HttpBuilder::new()
                        .scheme(HttpAuthScheme::Bearer)
                        .bearer_format("JWT")
                        .description(Some("Enter your JWT token"))
                        .build(),
                ),
            )
        }
    }
}
