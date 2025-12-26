use sea_orm_migration::prelude::*;

use super::m20251226000001_create_user_activities::UserActivities;

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        let db = manager.get_connection();

        // 1. Partial unique index: only one active session per user per module
        db.execute_unprepared(
            r#"
            CREATE UNIQUE INDEX idx_one_active_session_per_module
            ON user_activities(user_id, module)
            WHERE ended_at IS NULL;
            "#,
        )
        .await?;

        // 2. Index for user history queries (most common query pattern)
        manager
            .create_index(
                Index::create()
                    .name("idx_user_activities_user_started")
                    .table(UserActivities::Table)
                    .col(UserActivities::UserId)
                    .col(UserActivities::StartedAt)
                    .to_owned(),
            )
            .await?;

        // 3. Index for module filtering (for ?module=silence queries)
        manager
            .create_index(
                Index::create()
                    .name("idx_user_activities_user_module")
                    .table(UserActivities::Table)
                    .col(UserActivities::UserId)
                    .col(UserActivities::Module)
                    .col(UserActivities::StartedAt)
                    .to_owned(),
            )
            .await?;

        // 4. Index for active sessions lookup
        db.execute_unprepared(
            r#"
            CREATE INDEX idx_user_activities_active
            ON user_activities(user_id, module, started_at)
            WHERE ended_at IS NULL;
            "#,
        )
        .await?;

        // 5. Index for date range queries (completed sessions only)
        db.execute_unprepared(
            r#"
            CREATE INDEX idx_user_activities_date_range
            ON user_activities(user_id, started_at, ended_at)
            WHERE ended_at IS NOT NULL;
            "#,
        )
        .await?;

        // 6. Index for context analysis
        manager
            .create_index(
                Index::create()
                    .name("idx_user_activities_context")
                    .table(UserActivities::Table)
                    .col(UserActivities::UserId)
                    .col(UserActivities::ContextCode)
                    .to_owned(),
            )
            .await?;

        Ok(())
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        let db = manager.get_connection();

        // Drop partial indexes via raw SQL
        db.execute_unprepared("DROP INDEX IF EXISTS idx_one_active_session_per_module;")
            .await?;

        db.execute_unprepared("DROP INDEX IF EXISTS idx_user_activities_active;")
            .await?;

        db.execute_unprepared("DROP INDEX IF EXISTS idx_user_activities_date_range;")
            .await?;

        // Drop regular indexes via manager
        manager
            .drop_index(
                Index::drop()
                    .name("idx_user_activities_user_started")
                    .table(UserActivities::Table)
                    .to_owned(),
            )
            .await?;

        manager
            .drop_index(
                Index::drop()
                    .name("idx_user_activities_user_module")
                    .table(UserActivities::Table)
                    .to_owned(),
            )
            .await?;

        manager
            .drop_index(
                Index::drop()
                    .name("idx_user_activities_context")
                    .table(UserActivities::Table)
                    .to_owned(),
            )
            .await
    }
}
