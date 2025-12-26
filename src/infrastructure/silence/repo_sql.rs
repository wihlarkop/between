use crate::domain::context::entity::Contexts;
use crate::domain::silence::repository::SilenceSessionRepositoryTrait;
use crate::domain::silence::session::{SilenceSession, SilenceSessionWithContext, SilenceSessions};
use crate::shared::error::Result;
use async_trait::async_trait;
use chrono::{DateTime, Utc};
use sea_query::{Alias, Expr, Order, PostgresQueryBuilder, Query};
use sea_query_binder::SqlxBinder;
use sqlx::PgPool;
use uuid::Uuid;

#[derive(Clone)]
pub struct SilenceSessionRepository {
    pool: PgPool,
}

impl SilenceSessionRepository {
    pub fn new(pool: PgPool) -> Self {
        Self { pool }
    }
}

#[async_trait]
impl SilenceSessionRepositoryTrait for SilenceSessionRepository {
    async fn create(&self, session: SilenceSession) -> Result<SilenceSession> {
        let (sql, values) = Query::insert()
            .into_table(SilenceSessions::Table)
            .columns([
                SilenceSessions::Id,
                SilenceSessions::UserId,
                SilenceSessions::StartedAt,
                SilenceSessions::CreatedAt,
            ])
            .values_panic([
                session.id.into(),
                session.user_id.into(),
                session.started_at.into(),
                session.created_at.into(),
            ])
            .returning_all()
            .build_sqlx(PostgresQueryBuilder);

        let created = sqlx::query_as_with::<_, SilenceSession, _>(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        Ok(created)
    }

    async fn find_by_id(&self, id: Uuid) -> Result<Option<SilenceSession>> {
        let (sql, values) = Query::select()
            .columns([
                SilenceSessions::Id,
                SilenceSessions::UserId,
                SilenceSessions::StartedAt,
                SilenceSessions::EndedAt,
                SilenceSessions::DurationSeconds,
                SilenceSessions::ContextCode,
                SilenceSessions::ContextNote,
                SilenceSessions::TerminationReason,
                SilenceSessions::CreatedAt,
            ])
            .from(SilenceSessions::Table)
            .and_where(Expr::col(SilenceSessions::Id).eq(id))
            .build_sqlx(PostgresQueryBuilder);

        let session = sqlx::query_as_with::<_, SilenceSession, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(session)
    }

    async fn find_active_session(&self, user_id: Uuid) -> Result<Option<SilenceSession>> {
        let (sql, values) = Query::select()
            .columns([
                SilenceSessions::Id,
                SilenceSessions::UserId,
                SilenceSessions::StartedAt,
                SilenceSessions::EndedAt,
                SilenceSessions::DurationSeconds,
                SilenceSessions::ContextCode,
                SilenceSessions::ContextNote,
                SilenceSessions::TerminationReason,
                SilenceSessions::CreatedAt,
            ])
            .from(SilenceSessions::Table)
            .and_where(Expr::col(SilenceSessions::UserId).eq(user_id))
            .and_where(Expr::col(SilenceSessions::EndedAt).is_null())
            .build_sqlx(PostgresQueryBuilder);

        let session = sqlx::query_as_with::<_, SilenceSession, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(session)
    }

    async fn update(&self, session: SilenceSession) -> Result<SilenceSession> {
        let (sql, values) = Query::update()
            .table(SilenceSessions::Table)
            .values([
                (SilenceSessions::EndedAt, session.ended_at.into()),
                (
                    SilenceSessions::DurationSeconds,
                    session.duration_seconds.into(),
                ),
                (SilenceSessions::ContextCode, session.context_code.into()),
                (
                    SilenceSessions::ContextNote,
                    session.context_note.clone().into(),
                ),
                (
                    SilenceSessions::TerminationReason,
                    session.termination_reason.into(),
                ),
            ])
            .and_where(Expr::col(SilenceSessions::Id).eq(session.id))
            .returning_all()
            .build_sqlx(PostgresQueryBuilder);

        let updated = sqlx::query_as_with::<_, SilenceSession, _>(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        Ok(updated)
    }

    async fn find_sessions_paginated(
        &self,
        user_id: Uuid,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
    ) -> Result<(Vec<SilenceSessionWithContext>, u64)> {
        let offset = (page.saturating_sub(1)) * limit;

        let mut query = Query::select();
        query
            .columns([
                (SilenceSessions::Table, SilenceSessions::Id),
                (SilenceSessions::Table, SilenceSessions::UserId),
                (SilenceSessions::Table, SilenceSessions::StartedAt),
                (SilenceSessions::Table, SilenceSessions::EndedAt),
                (SilenceSessions::Table, SilenceSessions::DurationSeconds),
                (SilenceSessions::Table, SilenceSessions::ContextCode),
                (SilenceSessions::Table, SilenceSessions::ContextNote),
                (SilenceSessions::Table, SilenceSessions::TerminationReason),
                (SilenceSessions::Table, SilenceSessions::CreatedAt),
            ])
            .expr_as(
                Expr::col((Contexts::Table, Contexts::Label)),
                Alias::new("context_label"),
            )
            .expr_as(Expr::cust("COUNT(*) OVER()"), Alias::new("total"))
            .from(SilenceSessions::Table)
            .left_join(
                Contexts::Table,
                Expr::col((SilenceSessions::Table, SilenceSessions::ContextCode))
                    .equals((Contexts::Table, Contexts::Code)),
            )
            .and_where(Expr::col((SilenceSessions::Table, SilenceSessions::UserId)).eq(user_id))
            .and_where(Expr::col((SilenceSessions::Table, SilenceSessions::EndedAt)).is_not_null())
            .order_by(
                (SilenceSessions::Table, SilenceSessions::StartedAt),
                Order::Desc,
            )
            .limit(limit as u64)
            .offset(offset as u64);

        if let Some(from) = from_date {
            query.and_where(
                Expr::col((SilenceSessions::Table, SilenceSessions::StartedAt)).gte(from),
            );
        }

        if let Some(to) = to_date {
            query
                .and_where(Expr::col((SilenceSessions::Table, SilenceSessions::StartedAt)).lte(to));
        }

        let (sql, values) = query.build_sqlx(PostgresQueryBuilder);

        let sessions = sqlx::query_as_with::<_, SilenceSessionWithContext, _>(&sql, values)
            .fetch_all(&self.pool)
            .await?;

        // Get total from the first row, or default to 0 if no results
        let total = sessions.first().and_then(|s| s.total).unwrap_or(0) as u64;

        Ok((sessions, total))
    }

    async fn get_user_stats(
        &self,
        user_id: Uuid,
    ) -> Result<crate::domain::silence::repository::UserSessionStats> {
        use crate::domain::silence::repository::UserSessionStats;

        // Single optimized query using CTEs to get all stats in one database round trip
        let stats_sql = r#"
            WITH basic_stats AS (
                SELECT
                    COUNT(*) as total_sessions,
                    COALESCE(SUM(duration_seconds), 0) as total_duration_seconds,
                    COALESCE(ROUND(AVG(duration_seconds))::int, 0) as average_duration_seconds,
                    COALESCE(MAX(duration_seconds), 0) as longest_session_seconds,
                    COALESCE(MIN(duration_seconds), 0) as shortest_session_seconds
                FROM silence_sessions
                WHERE user_id = $1 AND ended_at IS NOT NULL
            ),
            context_stats AS (
                SELECT
                    sc.code,
                    sc.label,
                    COUNT(*) as count,
                    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) as rn
                FROM silence_sessions ss
                JOIN contexts sc ON ss.context_code = sc.code AND sc.module = 'silence'
                WHERE ss.user_id = $1 AND ss.ended_at IS NOT NULL AND ss.context_code IS NOT NULL
                GROUP BY sc.code, sc.label
            ),
            hour_stats AS (
                SELECT
                    EXTRACT(HOUR FROM started_at)::int as hour,
                    COUNT(*) as count
                FROM silence_sessions
                WHERE user_id = $1 AND ended_at IS NOT NULL
                GROUP BY hour
            ),
            day_stats AS (
                SELECT
                    EXTRACT(DOW FROM started_at)::int as dow,
                    COUNT(*) as count
                FROM silence_sessions
                WHERE user_id = $1 AND ended_at IS NOT NULL
                GROUP BY dow
            )
            SELECT
                bs.total_sessions,
                bs.total_duration_seconds,
                bs.average_duration_seconds,
                bs.longest_session_seconds,
                bs.shortest_session_seconds,
                cs.code as context_code,
                cs.label as context_label,
                cs.count as context_count,
                (SELECT json_agg(json_build_object('hour', hour, 'count', count) ORDER BY hour)
                 FROM hour_stats) as hours_json,
                (SELECT json_agg(json_build_object('dow', dow, 'count', count) ORDER BY dow)
                 FROM day_stats) as days_json
            FROM basic_stats bs
            LEFT JOIN context_stats cs ON cs.rn = 1
        "#;

        #[derive(sqlx::FromRow)]
        struct StatsRow {
            total_sessions: i64,
            total_duration_seconds: i64,
            average_duration_seconds: i32,
            longest_session_seconds: i32,
            shortest_session_seconds: i32,
            context_code: Option<i16>,
            context_label: Option<String>,
            context_count: Option<i64>,
            hours_json: Option<sqlx::types::JsonValue>,
            days_json: Option<sqlx::types::JsonValue>,
        }

        let row: StatsRow = sqlx::query_as(stats_sql)
            .bind(user_id)
            .fetch_one(&self.pool)
            .await?;

        // Parse hours from JSON
        let sessions_by_hour: Vec<(i32, i64)> = row
            .hours_json
            .and_then(|json| {
                json.as_array().map(|arr| {
                    arr.iter()
                        .filter_map(|item| {
                            let hour = item.get("hour")?.as_i64()? as i32;
                            let count = item.get("count")?.as_i64()?;
                            Some((hour, count))
                        })
                        .collect()
                })
            })
            .unwrap_or_default();

        // Parse days from JSON and map DOW to day names
        let sessions_by_day: Vec<(String, i64)> = row
            .days_json
            .and_then(|json| {
                json.as_array().map(|arr| {
                    arr.iter()
                        .filter_map(|item| {
                            let dow = item.get("dow")?.as_i64()? as i32;
                            let count = item.get("count")?.as_i64()?;
                            let day_name = match dow {
                                0 => "Sunday",
                                1 => "Monday",
                                2 => "Tuesday",
                                3 => "Wednesday",
                                4 => "Thursday",
                                5 => "Friday",
                                6 => "Saturday",
                                _ => return None,
                            };
                            Some((day_name.to_string(), count))
                        })
                        .collect()
                })
            })
            .unwrap_or_default();

        let most_common_context = match (row.context_code, row.context_label, row.context_count) {
            (Some(code), Some(label), Some(count)) => Some((code, label, count)),
            _ => None,
        };

        Ok(UserSessionStats {
            total_sessions: row.total_sessions,
            total_duration_seconds: row.total_duration_seconds,
            average_duration_seconds: row.average_duration_seconds,
            longest_session_seconds: row.longest_session_seconds,
            shortest_session_seconds: row.shortest_session_seconds,
            most_common_context,
            sessions_by_hour,
            sessions_by_day,
        })
    }

}
