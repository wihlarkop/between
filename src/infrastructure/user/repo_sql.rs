use crate::domain::user::entity::{User, Users};
use crate::domain::user::repository::UserRepositoryTrait;
use crate::shared::error::{BetweenError, Result};
use async_trait::async_trait;
use sea_query::{Expr, PostgresQueryBuilder, Query};
use sea_query_binder::SqlxBinder;
use sqlx::PgPool;
use uuid::Uuid;

#[derive(Clone)]
pub struct UserRepository {
    pool: PgPool,
}

impl UserRepository {
    pub fn new(pool: PgPool) -> Self {
        Self { pool }
    }
}

#[async_trait]
impl UserRepositoryTrait for UserRepository {
    async fn create(&self, user: User) -> Result<User> {
        let (sql, values) = Query::insert()
            .into_table(Users::Table)
            .columns([
                Users::Id,
                Users::Fullname,
                Users::Email,
                Users::PasswordHash,
                Users::Timezone,
                Users::CreatedAt,
                Users::UpdatedAt,
            ])
            .values_panic([
                user.id.into(),
                user.fullname.into(),
                user.email.into(),
                user.password_hash.into(),
                user.timezone.into(),
                user.created_at.into(),
                user.updated_at.into(),
            ])
            .returning_all()
            .build_sqlx(PostgresQueryBuilder);

        let created = sqlx::query_as_with::<_, User, _>(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        Ok(created)
    }

    async fn find_by_id(&self, id: Uuid) -> Result<Option<User>> {
        let (sql, values) = Query::select()
            .columns([
                Users::Id,
                Users::Fullname,
                Users::Email,
                Users::PasswordHash,
                Users::Timezone,
                Users::CreatedAt,
                Users::UpdatedAt,
            ])
            .from(Users::Table)
            .and_where(Expr::col(Users::Id).eq(id))
            .build_sqlx(PostgresQueryBuilder);

        let user = sqlx::query_as_with::<_, User, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(user)
    }

    async fn find_by_email(&self, email: &str) -> Result<Option<User>> {
        let (sql, values) = Query::select()
            .columns([
                Users::Id,
                Users::Fullname,
                Users::Email,
                Users::PasswordHash,
                Users::Timezone,
                Users::CreatedAt,
                Users::UpdatedAt,
            ])
            .from(Users::Table)
            .and_where(Expr::col(Users::Email).eq(email))
            .build_sqlx(PostgresQueryBuilder);

        let user = sqlx::query_as_with::<_, User, _>(&sql, values)
            .fetch_optional(&self.pool)
            .await?;

        Ok(user)
    }

    async fn update(&self, user: User) -> Result<User> {
        let (sql, values) = Query::update()
            .table(Users::Table)
            .values([
                (Users::Fullname, user.fullname.clone().into()),
                (Users::Email, user.email.clone().into()),
                (Users::Timezone, user.timezone.clone().into()),
            ])
            .and_where(Expr::col(Users::Id).eq(user.id))
            .returning_all()
            .build_sqlx(PostgresQueryBuilder);

        let updated = sqlx::query_as_with::<_, User, _>(&sql, values)
            .fetch_one(&self.pool)
            .await?;

        Ok(updated)
    }

    async fn delete(&self, id: Uuid) -> Result<()> {
        let (sql, values) = Query::delete()
            .from_table(Users::Table)
            .and_where(Expr::col(Users::Id).eq(id))
            .build_sqlx(PostgresQueryBuilder);

        let result = sqlx::query_with(&sql, values).execute(&self.pool).await?;

        if result.rows_affected() == 0 {
            return Err(BetweenError::NotFound(format!(
                "User with id {} not found",
                id
            )));
        }

        Ok(())
    }

    async fn email_exists(&self, email: &str) -> Result<bool> {
        let user = self.find_by_email(email).await?;
        Ok(user.is_some())
    }
}
