use crate::domain::context::entity::Contexts;
use crate::domain::decision::entity::{Decision, DecisionWithContext, Decisions};
use crate::domain::decision::repository::{
    ContextCount, DecisionRepositoryTrait, DecisionStats, MonthCount,
};
use crate::shared::error::Result;
use async_trait::async_trait;
use chrono::{DateTime, Utc};
use sea_query::{Alias, Expr, Order, PostgresQueryBuilder, Query};
use sea_query_binder::SqlxBinder;
use sqlx::PgPool;
use uuid::Uuid;

#[derive(Clone)]
pub struct DecisionRepository {
    pool: PgPool,
}

impl DecisionRepository {
    pub fn new(pool: PgPool) -> Self {
        Self { pool }
    }
}

#[async_trait]
impl DecisionRepositoryTrait for DecisionRepository {
    async fn create(&self, decision: Decision) -> Result<Decision> {
        let (sql, values) = Query::insert()
            .into_table(Decisions::Table)
            .columns([
                Decisions::Id,
                Decisions::UserId,
                Decisions::Title,
                Decisions::DecidedAt,
                Decisions::Reason,
                Decisions::Expectation,
                Decisions::CompletedAt,
                Decisions::ActualResult,
                Decisions::Learnings,
                Decisions::ContextCode,
                Decisions::Tags,
                Decisions::CreatedAt,
            ])
            .values_panic([
                decision.id.into(),
                decision.user_id.into(),
                decision.title.clone().into(),
                decision.decided_at.into(),
                decision.reason.clone().into(),
                decision.expectation.clone().into(),
                decision.completed_at.into(),
                decision.actual_result.clone().into(),
                decision.learnings.clone().into(),
                decision.context_code.into(),
                decision.tags.clone().into(),
                decision.created_at.into(),
            ])
            .returning_all()
            .build_sqlx(PostgresQueryBuilder);

        let created = sqlx::query_as_with::<_, Decision, _>(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        Ok(created)
    }

    async fn find_by_id(&self, decision_id: Uuid) -> Result<Option<Decision>> {
        let (sql, values) = Query::select()
            .columns([
                Decisions::Id,
                Decisions::UserId,
                Decisions::Title,
                Decisions::DecidedAt,
                Decisions::Reason,
                Decisions::Expectation,
                Decisions::CompletedAt,
                Decisions::ActualResult,
                Decisions::Learnings,
                Decisions::ContextCode,
                Decisions::Tags,
                Decisions::CreatedAt,
            ])
            .from(Decisions::Table)
            .and_where(Expr::col(Decisions::Id).eq(decision_id))
            .build_sqlx(PostgresQueryBuilder);

        let decision = sqlx::query_as_with::<_, Decision, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(decision)
    }

    async fn update(&self, decision: Decision) -> Result<Decision> {
        let (sql, values) = Query::update()
            .table(Decisions::Table)
            .values([
                (Decisions::Title, decision.title.clone().into()),
                (Decisions::DecidedAt, decision.decided_at.into()),
                (Decisions::Reason, decision.reason.clone().into()),
                (Decisions::Expectation, decision.expectation.clone().into()),
                (Decisions::CompletedAt, decision.completed_at.into()),
                (
                    Decisions::ActualResult,
                    decision.actual_result.clone().into(),
                ),
                (Decisions::Learnings, decision.learnings.clone().into()),
                (Decisions::ContextCode, decision.context_code.into()),
                (Decisions::Tags, decision.tags.clone().into()),
            ])
            .and_where(Expr::col(Decisions::Id).eq(decision.id))
            .returning_all()
            .build_sqlx(PostgresQueryBuilder);

        let updated = sqlx::query_as_with::<_, Decision, _>(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        Ok(updated)
    }

    async fn delete(&self, decision_id: Uuid, user_id: Uuid) -> Result<()> {
        let (sql, values) = Query::delete()
            .from_table(Decisions::Table)
            .and_where(Expr::col(Decisions::Id).eq(decision_id))
            .and_where(Expr::col(Decisions::UserId).eq(user_id))
            .build_sqlx(PostgresQueryBuilder);

        sqlx::query_with(&sql, values)
            .execute(&self.pool)
            .await?;

        Ok(())
    }

    async fn find_decisions_paginated(
        &self,
        user_id: Uuid,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
        context_code: Option<i16>,
        tags: Option<Vec<String>>,
        status: Option<String>,
    ) -> Result<(Vec<Decision>, u64)> {
        let offset = (page.saturating_sub(1)) * limit;

        let mut query = Query::select();
        query
            .columns([
                (Decisions::Table, Decisions::Id),
                (Decisions::Table, Decisions::UserId),
                (Decisions::Table, Decisions::Title),
                (Decisions::Table, Decisions::DecidedAt),
                (Decisions::Table, Decisions::Reason),
                (Decisions::Table, Decisions::Expectation),
                (Decisions::Table, Decisions::CompletedAt),
                (Decisions::Table, Decisions::ActualResult),
                (Decisions::Table, Decisions::Learnings),
                (Decisions::Table, Decisions::ContextCode),
                (Decisions::Table, Decisions::Tags),
                (Decisions::Table, Decisions::CreatedAt),
            ])
            .expr_as(
                Expr::col((Contexts::Table, Contexts::Label)),
                Alias::new("context_label"),
            )
            .expr_as(Expr::cust("COUNT(*) OVER()"), Alias::new("total"))
            .from(Decisions::Table)
            .left_join(
                Contexts::Table,
                Expr::col((Decisions::Table, Decisions::ContextCode))
                    .equals((Contexts::Table, Contexts::Code)),
            )
            .and_where(Expr::col((Decisions::Table, Decisions::UserId)).eq(user_id))
            .order_by((Decisions::Table, Decisions::CreatedAt), Order::Desc)
            .limit(limit as u64)
            .offset(offset as u64);

        // Apply date filters
        if let Some(from) = from_date {
            query.and_where(
                Expr::col((Decisions::Table, Decisions::DecidedAt))
                    .gte(from)
                    .or(Expr::col((Decisions::Table, Decisions::CompletedAt)).gte(from)),
            );
        }

        if let Some(to) = to_date {
            query.and_where(
                Expr::col((Decisions::Table, Decisions::DecidedAt))
                    .lte(to)
                    .or(Expr::col((Decisions::Table, Decisions::CompletedAt)).lte(to)),
            );
        }

        // Apply context filter
        if let Some(code) = context_code {
            query.and_where(Expr::col((Decisions::Table, Decisions::ContextCode)).eq(code));
        }

        // Apply tags filter (contains any of the provided tags)
        if let Some(ref tags_list) = tags {
            if !tags_list.is_empty() {
                query.and_where(
                    Expr::cust_with_values::<&str, _, _>(
                        "tags && $1::text[]",
                        [tags_list.clone()],
                    )
                );
            }
        }

        // Apply status filter
        if let Some(status_str) = status {
            match status_str.as_str() {
                "pending" => {
                    // Has decided_at but no completed_at
                    query
                        .and_where(Expr::col((Decisions::Table, Decisions::DecidedAt)).is_not_null())
                        .and_where(Expr::col((Decisions::Table, Decisions::CompletedAt)).is_null());
                }
                "completed" => {
                    // Has both decided_at and completed_at (was pending, now completed)
                    query
                        .and_where(Expr::col((Decisions::Table, Decisions::DecidedAt)).is_not_null())
                        .and_where(Expr::col((Decisions::Table, Decisions::CompletedAt)).is_not_null());
                }
                "quick" => {
                    // Has completed_at but no decided_at (quick decision)
                    query
                        .and_where(Expr::col((Decisions::Table, Decisions::DecidedAt)).is_null())
                        .and_where(Expr::col((Decisions::Table, Decisions::CompletedAt)).is_not_null());
                }
                _ => {} // "all" or any other value - no filter
            }
        }

        let (sql, values) = query.build_sqlx(PostgresQueryBuilder);

        let decisions = sqlx::query_as_with::<_, DecisionWithContext, _>(&sql, values)
            .fetch_all(&self.pool)
            .await?;

        // Get total from the first row, or default to 0 if no results
        let total = decisions.first().and_then(|d| d.total).unwrap_or(0) as u64;

        // Convert DecisionWithContext to Decision for return type
        let decisions_plain: Vec<Decision> = decisions
            .into_iter()
            .map(|d| Decision {
                id: d.id,
                user_id: d.user_id,
                title: d.title,
                decided_at: d.decided_at,
                reason: d.reason,
                expectation: d.expectation,
                completed_at: d.completed_at,
                actual_result: d.actual_result,
                learnings: d.learnings,
                context_code: d.context_code,
                tags: d.tags,
                created_at: d.created_at,
            })
            .collect();

        Ok((decisions_plain, total))
    }

    async fn get_user_stats(&self, user_id: Uuid) -> Result<DecisionStats> {
        // Optimized query using CTEs to get all stats in one database round trip
        let stats_sql = r#"
            WITH basic_stats AS (
                SELECT
                    COUNT(*) as total_decisions,
                    COUNT(*) FILTER (WHERE decided_at IS NOT NULL AND completed_at IS NULL) as pending_decisions,
                    COUNT(*) FILTER (WHERE completed_at IS NOT NULL) as completed_decisions,
                    COUNT(*) FILTER (WHERE created_at >= NOW() - INTERVAL '7 days') as decisions_this_week,
                    COUNT(*) FILTER (WHERE created_at >= NOW() - INTERVAL '30 days') as decisions_this_month,
                    COALESCE(AVG(EXTRACT(EPOCH FROM (completed_at - decided_at)) / 86400) FILTER (WHERE completed_at IS NOT NULL AND decided_at IS NOT NULL), 0.0)::DOUBLE PRECISION as avg_days
                FROM decisions
                WHERE user_id = $1
            ),
            context_stats AS (
                SELECT
                    c.code,
                    c.label,
                    COUNT(*) as count,
                    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) as rn
                FROM decisions d
                JOIN contexts c ON d.context_code = c.code
                WHERE d.user_id = $1 AND d.context_code IS NOT NULL
                GROUP BY c.code, c.label
            ),
            month_stats AS (
                SELECT
                    TO_CHAR(created_at, 'YYYY-MM') as month,
                    COUNT(*) as count
                FROM decisions
                WHERE user_id = $1
                GROUP BY month
                ORDER BY month DESC
                LIMIT 12
            )
            SELECT
                bs.total_decisions,
                bs.pending_decisions,
                bs.completed_decisions,
                bs.decisions_this_week,
                bs.decisions_this_month,
                bs.avg_days,
                cs.code as most_common_context_code,
                cs.label as most_common_context_label,
                cs.count as most_common_context_count,
                (SELECT json_agg(json_build_object('month', month, 'count', count) ORDER BY month DESC)
                 FROM month_stats) as months_json,
                (SELECT json_agg(json_build_object('context_code', code, 'context_label', label, 'count', count) ORDER BY count DESC)
                 FROM context_stats) as contexts_json
            FROM basic_stats bs
            LEFT JOIN context_stats cs ON cs.rn = 1
        "#;

        #[derive(sqlx::FromRow)]
        struct StatsRow {
            total_decisions: i64,
            pending_decisions: i64,
            completed_decisions: i64,
            decisions_this_week: i64,
            decisions_this_month: i64,
            avg_days: f64,
            most_common_context_code: Option<i16>,
            most_common_context_label: Option<String>,
            most_common_context_count: Option<i64>,
            months_json: Option<sqlx::types::JsonValue>,
            contexts_json: Option<sqlx::types::JsonValue>,
        }

        let row: StatsRow = sqlx::query_as(stats_sql)
            .bind(user_id)
            .fetch_one(&self.pool)
            .await?;

        // Parse months from JSON
        let by_month: Vec<MonthCount> = row
            .months_json
            .and_then(|json| {
                json.as_array().map(|arr| {
                    arr.iter()
                        .filter_map(|item| {
                            let month = item.get("month")?.as_str()?.to_string();
                            let count = item.get("count")?.as_i64()? as u64;
                            Some(MonthCount { month, count })
                        })
                        .collect()
                })
            })
            .unwrap_or_default();

        // Parse contexts from JSON
        let by_context: Vec<ContextCount> = row
            .contexts_json
            .and_then(|json| {
                json.as_array().map(|arr| {
                    arr.iter()
                        .filter_map(|item| {
                            let context_code = item.get("context_code")?.as_i64()? as i16;
                            let context_label = item.get("context_label")?.as_str()?.to_string();
                            let count = item.get("count")?.as_i64()? as u64;
                            Some(ContextCount {
                                context_code,
                                context_label,
                                count,
                            })
                        })
                        .collect()
                })
            })
            .unwrap_or_default();

        let most_common_context = match (
            row.most_common_context_code,
            row.most_common_context_label,
            row.most_common_context_count,
        ) {
            (Some(code), Some(label), Some(count)) => Some(ContextCount {
                context_code: code,
                context_label: label,
                count: count as u64,
            }),
            _ => None,
        };

        Ok(DecisionStats {
            total_decisions: row.total_decisions as u64,
            pending_decisions: row.pending_decisions as u64,
            completed_decisions: row.completed_decisions as u64,
            decisions_this_week: row.decisions_this_week as u64,
            decisions_this_month: row.decisions_this_month as u64,
            avg_time_to_completion_days: if row.avg_days > 0.0 {
                Some(row.avg_days)
            } else {
                None
            },
            most_common_context,
            by_month,
            by_context,
        })
    }

}
