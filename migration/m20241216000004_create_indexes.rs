use sea_orm_migration::prelude::*;

use super::m20241216000003_create_silence_sessions::SilenceSessions;

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        let db = manager.get_connection();

        // Partial unique index: only one active session per user
        db.execute_unprepared(
            r#"
            CREATE UNIQUE INDEX idx_one_active_silence_session
            ON silence_sessions(user_id)
            WHERE ended_at IS NULL;
            "#,
        )
        .await?;

        // Index for user's session history (ordered by started_at descending)
        manager
            .create_index(
                Index::create()
                    .name("idx_silence_sessions_user_started")
                    .table(SilenceSessions::Table)
                    .col(SilenceSessions::UserId)
                    .col(SilenceSessions::StartedAt)
                    .to_owned(),
            )
            .await?;

        // Index for completed sessions
        db.execute_unprepared(
            r#"
            CREATE INDEX idx_silence_sessions_completed
            ON silence_sessions(user_id, ended_at DESC)
            WHERE ended_at IS NOT NULL;
            "#,
        )
        .await?;

        // Index for context analysis
        manager
            .create_index(
                Index::create()
                    .name("idx_silence_sessions_context")
                    .table(SilenceSessions::Table)
                    .col(SilenceSessions::UserId)
                    .col(SilenceSessions::ContextCode)
                    .to_owned(),
            )
            .await?;

        Ok(())
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        let db = manager.get_connection();

        db.execute_unprepared("DROP INDEX IF EXISTS idx_one_active_silence_session;")
            .await?;

        db.execute_unprepared("DROP INDEX IF EXISTS idx_silence_sessions_completed;")
            .await?;

        manager
            .drop_index(
                Index::drop()
                    .name("idx_silence_sessions_user_started")
                    .table(SilenceSessions::Table)
                    .to_owned(),
            )
            .await?;

        manager
            .drop_index(
                Index::drop()
                    .name("idx_silence_sessions_context")
                    .table(SilenceSessions::Table)
                    .to_owned(),
            )
            .await
    }
}
