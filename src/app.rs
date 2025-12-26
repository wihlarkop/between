use crate::application::{activity, context, decision, profile, silence, user};
use crate::domain::activity::service::ActivityService;
use crate::domain::context::service::ContextService;
use crate::domain::decision::service::DecisionService;
use crate::domain::profile::service::ProfileService;
use crate::domain::silence::service::SilenceSessionService;
use crate::domain::user::repository::UserRepositoryTrait;
use crate::domain::user::service::AuthService;
use crate::infrastructure::activity::ActivityRepository;
use crate::infrastructure::context::ContextRepository;
use crate::infrastructure::decision::DecisionRepository;
use crate::infrastructure::silence::SilenceSessionRepository;
use crate::infrastructure::user::UserRepository;
use crate::openapi::ApiDoc;
use crate::shared::JwtSecret;
use axum::{
    extract::FromRef,
    routing::{delete, get, post, put},
    Router,
};
use sqlx::PgPool;
use std::sync::Arc;
use tower_http::cors::{Any, CorsLayer};
use utoipa::OpenApi;
use utoipa_swagger_ui::SwaggerUi;

/// Application shared state
#[derive(Clone)]
pub struct AppState {
    pub pool: PgPool,
    pub jwt_secret: JwtSecret,
    pub user_repo: Arc<UserRepository>,
    pub auth_service: Arc<AuthService<UserRepository>>,
    pub profile_service: Arc<ProfileService<UserRepository>>,
    pub silence_service: Arc<SilenceSessionService<SilenceSessionRepository>>,
    pub decision_service: Arc<DecisionService>,
    pub context_service: Arc<ContextService>,
    pub activity_service: Arc<ActivityService<ActivityRepository>>,
}

impl AppState {
    pub fn new(
        pool: PgPool,
        jwt_secret: String,
        jwt_access_token_expiry: i64,
        jwt_refresh_token_expiry: i64,
    ) -> Self {
        // Create repositories
        let user_repo = Arc::new(UserRepository::new(pool.clone()));
        let session_repo = SilenceSessionRepository::new(pool.clone());
        let decision_repo = Arc::new(DecisionRepository::new(pool.clone()));
        let context_repo = Arc::new(ContextRepository::new(pool.clone()));
        let activity_repo = Arc::new(ActivityRepository::new(pool.clone()));

        // Create services
        let auth_service = Arc::new(AuthService::new(
            (*user_repo).clone(),
            jwt_secret.clone(),
            jwt_access_token_expiry,
            jwt_refresh_token_expiry,
        ));

        let profile_service = Arc::new(ProfileService::new((*user_repo).clone()));

        let silence_service = Arc::new(SilenceSessionService::new(
            session_repo,
            context_repo.clone(),
            activity_repo.clone(),
        ));

        let decision_service = Arc::new(DecisionService::new(
            decision_repo,
            context_repo.clone(),
            activity_repo.clone(),
        ));

        let context_service = Arc::new(ContextService::new(context_repo.clone()));

        let activity_service = Arc::new(ActivityService::new(
            (*activity_repo).clone(),
        ));

        Self {
            pool,
            jwt_secret: JwtSecret(jwt_secret),
            user_repo,
            auth_service,
            profile_service,
            silence_service,
            decision_service,
            context_service,
            activity_service,
        }
    }
}

// Implement FromRef for extracting services from AppState
impl FromRef<AppState> for JwtSecret {
    fn from_ref(state: &AppState) -> Self {
        state.jwt_secret.clone()
    }
}

impl FromRef<AppState> for Arc<UserRepository> {
    fn from_ref(state: &AppState) -> Self {
        state.user_repo.clone()
    }
}

impl FromRef<AppState> for Arc<dyn UserRepositoryTrait> {
    fn from_ref(state: &AppState) -> Self {
        state.user_repo.clone()
    }
}

impl FromRef<AppState> for Arc<AuthService<UserRepository>> {
    fn from_ref(state: &AppState) -> Self {
        state.auth_service.clone()
    }
}

impl FromRef<AppState> for Arc<ProfileService<UserRepository>> {
    fn from_ref(state: &AppState) -> Self {
        state.profile_service.clone()
    }
}

impl FromRef<AppState> for Arc<SilenceSessionService<SilenceSessionRepository>> {
    fn from_ref(state: &AppState) -> Self {
        state.silence_service.clone()
    }
}

impl FromRef<AppState> for Arc<DecisionService> {
    fn from_ref(state: &AppState) -> Self {
        state.decision_service.clone()
    }
}

impl FromRef<AppState> for Arc<ContextService> {
    fn from_ref(state: &AppState) -> Self {
        state.context_service.clone()
    }
}

impl FromRef<AppState> for Arc<ActivityService<ActivityRepository>> {
    fn from_ref(state: &AppState) -> Self {
        state.activity_service.clone()
    }
}

impl FromRef<AppState> for PgPool {
    fn from_ref(state: &AppState) -> Self {
        state.pool.clone()
    }
}

/// Build the application router with all routes
pub fn create_router(state: AppState) -> Router {
    // CORS configuration
    let cors = CorsLayer::new()
        .allow_origin(Any)
        .allow_methods(Any)
        .allow_headers(Any);

    // Health check route (uses PgPool directly)
    let health_route = Router::new()
        .route(
            "/health",
            get(crate::application::health::handler::health_check),
        )
        .with_state(state.pool.clone());

    // User/Auth routes (use AppState)
    let auth_routes = Router::new()
        .route(
            "/register",
            post(user::handler::register::<AuthService<UserRepository>>),
        )
        .route(
            "/login",
            post(user::handler::login::<AuthService<UserRepository>>),
        )
        .route(
            "/refresh-token",
            post(user::handler::refresh_token::<AuthService<UserRepository>>),
        );

    // Profile routes (use AppState)
    let profile_routes = Router::new()
        .route(
            "/",
            put(profile::handler::update_profile::<ProfileService<UserRepository>, UserRepository>),
        )
        .route(
            "/me",
            get(profile::handler::my_profile::<ProfileService<UserRepository>, UserRepository>),
        );

    // Silence session routes (use AppState)
    let silence_routes = Router::new()
        .route(
            "/start",
            post(
                silence::handler::start_session::<
                    SilenceSessionService<SilenceSessionRepository>,
                    UserRepository,
                >,
            ),
        )
        .route(
            "/end",
            post(
                silence::handler::end_session::<
                    SilenceSessionService<SilenceSessionRepository>,
                    UserRepository,
                >,
            ),
        )
        .route(
            "/sessions",
            get(silence::handler::get_sessions::<
                SilenceSessionService<SilenceSessionRepository>,
                UserRepository,
            >),
        )
        .route(
            "/sessions/{session_id}/context",
            put(silence::handler::attach_context::<
                SilenceSessionService<SilenceSessionRepository>,
                UserRepository,
            >),
        )
        .route(
            "/stats",
            get(silence::handler::get_stats::<
                SilenceSessionService<SilenceSessionRepository>,
                UserRepository,
            >),
        );

    // Decision routes (use AppState)
    let decision_routes = Router::new()
        .route(
            "/",
            post(decision::handler::create_decision::<UserRepository>),
        )
        .route(
            "/",
            get(decision::handler::get_decisions::<UserRepository>),
        )
        .route(
            "/stats",
            get(decision::handler::get_stats::<UserRepository>),
        )
        .route(
            "/{decision_id}",
            get(decision::handler::get_decision::<UserRepository>),
        )
        .route(
            "/{decision_id}",
            put(decision::handler::update_decision::<UserRepository>),
        )
        .route(
            "/{decision_id}",
            delete(decision::handler::delete_decision::<UserRepository>),
        );

    // General context routes (uses PgPool directly)
    let context_routes = Router::new()
        .route(
            "/",
            get(context::handler::get_contexts::<UserRepository>),
        );

    // Activity routes (unified sessions endpoint)
    let activity_routes = Router::new()
        .route(
            "/",
            get(activity::handler::get_activities::<
                ActivityService<ActivityRepository>,
                UserRepository,
            >),
        )
        .route(
            "/stats",
            get(activity::handler::get_stats::<
                ActivityService<ActivityRepository>,
                UserRepository,
            >),
        )
        .route(
            "/{id}",
            get(activity::handler::get_activity::<
                ActivityService<ActivityRepository>,
                UserRepository,
            >),
        );

    // Main application router
    Router::new()
        .merge(health_route)
        .merge(SwaggerUi::new("/docs").url("/api-docs/openapi.json", ApiDoc::openapi()))
        .nest("/api/auth", auth_routes)
        .nest("/api/profile", profile_routes)
        .nest("/api/silence", silence_routes)
        .nest("/api/decisions", decision_routes)
        .nest("/api/contexts", context_routes)
        .nest("/api/sessions", activity_routes)
        .layer(cors)
        .with_state(state)
}
