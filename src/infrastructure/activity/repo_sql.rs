use crate::domain::activity::entity::{UserActivities, UserActivity, UserActivityWithContext};
use crate::domain::activity::repository::{
    ActivityRepositoryTrait, ActivityStats, ContextCount, ModuleCount,
};
use crate::domain::context::entity::Contexts;
use crate::shared::error::Result;
use async_trait::async_trait;
use chrono::{DateTime, Utc};
use sea_query::{Alias, Expr, Func, Order, PostgresQueryBuilder, Query};
use sea_query_binder::SqlxBinder;
use sqlx::PgPool;
use uuid::Uuid;

#[derive(Clone)]
pub struct ActivityRepository {
    pool: PgPool,
}

impl ActivityRepository {
    pub fn new(pool: PgPool) -> Self {
        Self { pool }
    }
}

#[async_trait]
impl ActivityRepositoryTrait for ActivityRepository {
    async fn create(&self, activity: UserActivity) -> Result<UserActivity> {
        let (sql, values) = Query::insert()
            .into_table(UserActivities::Table)
            .columns([
                UserActivities::Id,
                UserActivities::UserId,
                UserActivities::Module,
                UserActivities::ModuleSessionId,
                UserActivities::StartedAt,
                UserActivities::EndedAt,
                UserActivities::DurationSeconds,
                UserActivities::ContextCode,
                UserActivities::Metadata,
                UserActivities::CreatedAt,
            ])
            .values_panic([
                activity.id.into(),
                activity.user_id.into(),
                activity.module.into(),
                activity.module_session_id.into(),
                activity.started_at.into(),
                activity.ended_at.into(),
                activity.duration_seconds.into(),
                activity.context_code.into(),
                activity.metadata.clone().into(),
                activity.created_at.into(),
            ])
            .returning_all()
            .build_sqlx(PostgresQueryBuilder);

        let created = sqlx::query_as_with::<_, UserActivity, _>(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        Ok(created)
    }

    async fn find_by_id(&self, id: Uuid) -> Result<Option<UserActivity>> {
        let (sql, values) = Query::select()
            .columns([
                UserActivities::Id,
                UserActivities::UserId,
                UserActivities::Module,
                UserActivities::ModuleSessionId,
                UserActivities::StartedAt,
                UserActivities::EndedAt,
                UserActivities::DurationSeconds,
                UserActivities::ContextCode,
                UserActivities::Metadata,
                UserActivities::CreatedAt,
            ])
            .from(UserActivities::Table)
            .and_where(Expr::col(UserActivities::Id).eq(id))
            .build_sqlx(PostgresQueryBuilder);

        let activity = sqlx::query_as_with::<_, UserActivity, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(activity)
    }

    async fn find_by_id_with_context(&self, id: Uuid) -> Result<Option<UserActivityWithContext>> {
        let (sql, values) = Query::select()
            .columns([
                (UserActivities::Table, UserActivities::Id),
                (UserActivities::Table, UserActivities::UserId),
                (UserActivities::Table, UserActivities::Module),
                (UserActivities::Table, UserActivities::ModuleSessionId),
                (UserActivities::Table, UserActivities::StartedAt),
                (UserActivities::Table, UserActivities::EndedAt),
                (UserActivities::Table, UserActivities::DurationSeconds),
                (UserActivities::Table, UserActivities::ContextCode),
                (UserActivities::Table, UserActivities::Metadata),
                (UserActivities::Table, UserActivities::CreatedAt),
            ])
            .expr_as(
                Expr::col((Contexts::Table, Contexts::Label)),
                Alias::new("context_label"),
            )
            .expr_as(Expr::cust("NULL::BIGINT"), Alias::new("total"))
            .from(UserActivities::Table)
            .left_join(
                Contexts::Table,
                Expr::col((UserActivities::Table, UserActivities::ContextCode))
                    .equals((Contexts::Table, Contexts::Code)),
            )
            .and_where(Expr::col((UserActivities::Table, UserActivities::Id)).eq(id))
            .build_sqlx(PostgresQueryBuilder);

        let activity = sqlx::query_as_with::<_, UserActivityWithContext, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(activity)
    }

    async fn find_active(
        &self,
        user_id: Uuid,
        module: &str,
    ) -> Result<Option<UserActivity>> {
        let (sql, values) = Query::select()
            .columns([
                UserActivities::Id,
                UserActivities::UserId,
                UserActivities::Module,
                UserActivities::ModuleSessionId,
                UserActivities::StartedAt,
                UserActivities::EndedAt,
                UserActivities::DurationSeconds,
                UserActivities::ContextCode,
                UserActivities::Metadata,
                UserActivities::CreatedAt,
            ])
            .from(UserActivities::Table)
            .and_where(Expr::col(UserActivities::UserId).eq(user_id))
            .and_where(Expr::col(UserActivities::Module).eq(module))
            .and_where(Expr::col(UserActivities::EndedAt).is_null())
            .build_sqlx(PostgresQueryBuilder);

        let activity = sqlx::query_as_with::<_, UserActivity, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(activity)
    }

    async fn update(&self, activity: UserActivity) -> Result<UserActivity> {
        let (sql, values) = Query::update()
            .table(UserActivities::Table)
            .values([
                (UserActivities::EndedAt, activity.ended_at.into()),
                (
                    UserActivities::DurationSeconds,
                    activity.duration_seconds.into(),
                ),
                (UserActivities::ContextCode, activity.context_code.into()),
                (UserActivities::Metadata, activity.metadata.clone().into()),
            ])
            .and_where(Expr::col(UserActivities::Id).eq(activity.id))
            .returning_all()
            .build_sqlx(PostgresQueryBuilder);

        let updated = sqlx::query_as_with::<_, UserActivity, _>(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        Ok(updated)
    }

    async fn find_by_module_session_id(
        &self,
        module: &str,
        module_session_id: Uuid,
    ) -> Result<Option<UserActivity>> {
        let (sql, values) = Query::select()
            .columns([
                UserActivities::Id,
                UserActivities::UserId,
                UserActivities::Module,
                UserActivities::ModuleSessionId,
                UserActivities::StartedAt,
                UserActivities::EndedAt,
                UserActivities::DurationSeconds,
                UserActivities::ContextCode,
                UserActivities::Metadata,
                UserActivities::CreatedAt,
            ])
            .from(UserActivities::Table)
            .and_where(Expr::col(UserActivities::Module).eq(module))
            .and_where(Expr::col(UserActivities::ModuleSessionId).eq(module_session_id))
            .build_sqlx(PostgresQueryBuilder);

        let activity = sqlx::query_as_with::<_, UserActivity, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(activity)
    }

    async fn find_activities_paginated(
        &self,
        user_id: Uuid,
        module: Option<String>,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
    ) -> Result<(Vec<UserActivityWithContext>, u64)> {
        let offset = (page.saturating_sub(1)) * limit;

        let mut query = Query::select();
        query
            .columns([
                (UserActivities::Table, UserActivities::Id),
                (UserActivities::Table, UserActivities::UserId),
                (UserActivities::Table, UserActivities::Module),
                (UserActivities::Table, UserActivities::ModuleSessionId),
                (UserActivities::Table, UserActivities::StartedAt),
                (UserActivities::Table, UserActivities::EndedAt),
                (UserActivities::Table, UserActivities::DurationSeconds),
                (UserActivities::Table, UserActivities::ContextCode),
                (UserActivities::Table, UserActivities::Metadata),
                (UserActivities::Table, UserActivities::CreatedAt),
            ])
            .expr_as(
                Expr::col((Contexts::Table, Contexts::Label)),
                Alias::new("context_label"),
            )
            .expr_as(Expr::cust("COUNT(*) OVER()"), Alias::new("total"))
            .from(UserActivities::Table)
            .left_join(
                Contexts::Table,
                Expr::col((UserActivities::Table, UserActivities::ContextCode))
                    .equals((Contexts::Table, Contexts::Code)),
            )
            .and_where(Expr::col((UserActivities::Table, UserActivities::UserId)).eq(user_id))
            .order_by(
                (UserActivities::Table, UserActivities::StartedAt),
                Order::Desc,
            )
            .limit(limit as u64)
            .offset(offset as u64);

        // Filter by module if provided
        if let Some(m) = module {
            query.and_where(Expr::col((UserActivities::Table, UserActivities::Module)).eq(m));
        }

        // Filter by date range if provided
        if let Some(from) = from_date {
            query.and_where(
                Expr::col((UserActivities::Table, UserActivities::StartedAt)).gte(from),
            );
        }

        if let Some(to) = to_date {
            query.and_where(
                Expr::col((UserActivities::Table, UserActivities::StartedAt)).lte(to),
            );
        }

        let (sql, values) = query.build_sqlx(PostgresQueryBuilder);

        let activities = sqlx::query_as_with::<_, UserActivityWithContext, _>(&sql, values)
            .fetch_all(&self.pool)
            .await?;

        let total = activities.first().and_then(|a| a.total).unwrap_or(0) as u64;

        Ok((activities, total))
    }

    async fn get_user_stats(
        &self,
        user_id: Uuid,
        module: Option<String>,
    ) -> Result<ActivityStats> {
        #[derive(sqlx::FromRow)]
        struct BasicStats {
            total_activities: Option<i64>,
            total_duration_seconds: Option<i64>,
            average_duration_seconds: Option<f64>,
            longest_activity_seconds: Option<i32>,
            shortest_activity_seconds: Option<i32>,
        }

        // Build the basic stats query
        let mut basic_query = Query::select();
        basic_query
            .expr_as(Func::count(Expr::col(UserActivities::Id)), Alias::new("total_activities"))
            .expr_as(Func::sum(Expr::col(UserActivities::DurationSeconds)), Alias::new("total_duration_seconds"))
            .expr_as(
                Func::cast_as(
                    Func::avg(Expr::col(UserActivities::DurationSeconds)),
                    Alias::new("DOUBLE PRECISION")
                ),
                Alias::new("average_duration_seconds")
            )
            .expr_as(Func::max(Expr::col(UserActivities::DurationSeconds)), Alias::new("longest_activity_seconds"))
            .expr_as(Func::min(Expr::col(UserActivities::DurationSeconds)), Alias::new("shortest_activity_seconds"))
            .from(UserActivities::Table)
            .and_where(Expr::col(UserActivities::UserId).eq(user_id))
            .and_where(Expr::col(UserActivities::EndedAt).is_not_null());

        if let Some(ref m) = module {
            basic_query.and_where(Expr::col(UserActivities::Module).eq(m.clone()));
        }

        let (sql, values) = basic_query.build_sqlx(PostgresQueryBuilder);

        let basic_stats = sqlx::query_as_with::<_, BasicStats, _>(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        // If no activities, return empty stats
        if basic_stats.total_activities.unwrap_or(0) == 0 {
            return Ok(ActivityStats {
                total_activities: 0,
                total_duration_seconds: 0,
                average_duration_seconds: 0,
                longest_activity_seconds: 0,
                shortest_activity_seconds: 0,
                activities_by_module: vec![],
                most_common_context: None,
            });
        }

        // Get activities by module (only if no module filter)
        let activities_by_module = if module.is_none() {
            #[derive(sqlx::FromRow)]
            struct ModuleRow {
                module: String,
                count: i64,
            }

            let (sql, values) = Query::select()
                .expr_as(Expr::col(UserActivities::Module), Alias::new("module"))
                .expr_as(Func::count(Expr::col(UserActivities::Id)), Alias::new("count"))
                .from(UserActivities::Table)
                .and_where(Expr::col(UserActivities::UserId).eq(user_id))
                .group_by_col(UserActivities::Module)
                .order_by(Alias::new("count"), Order::Desc)
                .build_sqlx(PostgresQueryBuilder);

            let rows = sqlx::query_as_with::<_, ModuleRow, _>(&sql, values)
                .fetch_all(&self.pool)
                .await?;

            rows.into_iter()
                .map(|r| ModuleCount {
                    module: r.module,
                    count: r.count,
                })
                .collect()
        } else {
            vec![]
        };

        // Get most common context
        #[derive(sqlx::FromRow)]
        struct ContextRow {
            code: i16,
            label: String,
            count: i64,
        }

        let mut context_query = Query::select();
        context_query
            .expr_as(Expr::col((UserActivities::Table, UserActivities::ContextCode)), Alias::new("code"))
            .expr_as(Expr::col((Contexts::Table, Contexts::Label)), Alias::new("label"))
            .expr_as(Func::count(Expr::col((UserActivities::Table, UserActivities::Id))), Alias::new("count"))
            .from(UserActivities::Table)
            .inner_join(
                Contexts::Table,
                Expr::col((UserActivities::Table, UserActivities::ContextCode))
                    .equals((Contexts::Table, Contexts::Code)),
            )
            .and_where(Expr::col((UserActivities::Table, UserActivities::UserId)).eq(user_id))
            .and_where(Expr::col((UserActivities::Table, UserActivities::ContextCode)).is_not_null())
            .group_by_col((UserActivities::Table, UserActivities::ContextCode))
            .group_by_col((Contexts::Table, Contexts::Label))
            .order_by(Alias::new("count"), Order::Desc)
            .limit(1);

        if let Some(ref m) = module {
            context_query.and_where(Expr::col((UserActivities::Table, UserActivities::Module)).eq(m.clone()));
        }

        let (sql, values) = context_query.build_sqlx(PostgresQueryBuilder);

        let most_common_context = sqlx::query_as_with::<_, ContextRow, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?
            .map(|r| ContextCount {
                code: r.code,
                label: r.label,
                count: r.count,
            });

        Ok(ActivityStats {
            total_activities: basic_stats.total_activities.unwrap_or(0),
            total_duration_seconds: basic_stats.total_duration_seconds.unwrap_or(0),
            average_duration_seconds: basic_stats.average_duration_seconds.unwrap_or(0.0).round() as i32,
            longest_activity_seconds: basic_stats.longest_activity_seconds.unwrap_or(0),
            shortest_activity_seconds: basic_stats.shortest_activity_seconds.unwrap_or(0),
            activities_by_module,
            most_common_context,
        })
    }
}
