use crate::domain::context::entity::{Context, Contexts};
use crate::domain::context::repository::ContextRepositoryTrait;
use crate::shared::error::Result;
use async_trait::async_trait;
use sea_query::{Expr, Order, PostgresQueryBuilder, Query};
use sea_query_binder::SqlxBinder;
use sqlx::PgPool;

#[derive(Clone)]
pub struct ContextRepository {
    pool: PgPool,
}

impl ContextRepository {
    pub fn new(pool: PgPool) -> Self {
        Self { pool }
    }
}

#[async_trait]
impl ContextRepositoryTrait for ContextRepository {
    async fn get_contexts(&self, module: Option<String>) -> Result<Vec<Context>> {
        let mut query = Query::select();
        query
            .columns([Contexts::Code, Contexts::Label, Contexts::Module])
            .from(Contexts::Table)
            .order_by(Contexts::Code, Order::Asc);

        // Apply module filter if provided
        if let Some(module_filter) = module {
            query.and_where(
                Expr::col(Contexts::Module)
                    .eq(&module_filter)
                    .or(Expr::col(Contexts::Module).eq("all")),
            );
        }

        let (sql, values) = query.build_sqlx(PostgresQueryBuilder);

        let contexts = sqlx::query_as_with::<_, Context, _>(&sql, values)
            .fetch_all(&self.pool)
            .await?;

        Ok(contexts)
    }

    async fn get_context_by_code(&self, code: i16) -> Result<Option<Context>> {
        let (sql, values) = Query::select()
            .columns([Contexts::Code, Contexts::Label, Contexts::Module])
            .from(Contexts::Table)
            .and_where(Expr::col(Contexts::Code).eq(code))
            .build_sqlx(PostgresQueryBuilder);

        let context = sqlx::query_as_with::<_, Context, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(context)
    }

    async fn verify_context_code(&self, code: i16, module: Option<String>) -> Result<bool> {
        let mut query = Query::select();
        query
            .expr(sea_query::Func::count(Expr::col(Contexts::Code)))
            .from(Contexts::Table)
            .and_where(Expr::col(Contexts::Code).eq(code));

        // Apply module filter if provided
        if let Some(module_filter) = module {
            query.and_where(
                Expr::col(Contexts::Module)
                    .eq(&module_filter)
                    .or(Expr::col(Contexts::Module).eq("all")),
            );
        }

        let (sql, values) = query.build_sqlx(PostgresQueryBuilder);

        let count: (i64,) = sqlx::query_as_with(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        Ok(count.0 > 0)
    }
}
