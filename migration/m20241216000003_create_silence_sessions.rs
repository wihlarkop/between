use sea_orm_migration::{prelude::*, schema::*};

use super::m20241216000001_create_users::Users;
use super::m20251225000001_create_decisions::Contexts;

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                Table::create()
                    .if_not_exists()
                    .table(SilenceSessions::Table)
                    .col(
                        uuid(SilenceSessions::Id)
                            .primary_key()
                            .extra("DEFAULT gen_random_uuid()"),
                    )
                    .col(uuid(SilenceSessions::UserId).not_null())
                    .col(timestamp_with_time_zone(SilenceSessions::StartedAt).not_null())
                    .col(timestamp_with_time_zone_null(SilenceSessions::EndedAt))
                    .col(integer_null(SilenceSessions::DurationSeconds))
                    .col(small_integer_null(SilenceSessions::ContextCode))
                    .col(text_null(SilenceSessions::ContextNote))
                    .col(
                        timestamp_with_time_zone(SilenceSessions::CreatedAt)
                            .extra("DEFAULT CURRENT_TIMESTAMP")
                            .not_null(),
                    )
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk_silence_sessions_user_id")
                            .from(SilenceSessions::Table, SilenceSessions::UserId)
                            .to(Users::Table, Users::Id)
                            .on_delete(ForeignKeyAction::Cascade),
                    )
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk_silence_sessions_context_code")
                            .from(SilenceSessions::Table, SilenceSessions::ContextCode)
                            .to(Contexts::Table, Contexts::Code)
                            .on_delete(ForeignKeyAction::SetNull),
                    )
                    .to_owned(),
            )
            .await?;

        // Add check constraints via raw SQL
        let db = manager.get_connection();
        db.execute_unprepared(
            r#"
            ALTER TABLE silence_sessions
            ADD CONSTRAINT check_ended_after_started
                CHECK (ended_at IS NULL OR ended_at > started_at),
            ADD CONSTRAINT check_duration_min
                CHECK (duration_seconds IS NULL OR duration_seconds >= 5),
            ADD CONSTRAINT check_duration_max
                CHECK (duration_seconds IS NULL OR duration_seconds <= 21600),
            ADD CONSTRAINT check_context_note_length
                CHECK (context_note IS NULL OR length(context_note) <= 500);
            "#,
        )
        .await?;

        Ok(())
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(
                Table::drop()
                    .table(SilenceSessions::Table)
                    .if_exists()
                    .to_owned(),
            )
            .await
    }
}

#[derive(DeriveIden)]
pub enum SilenceSessions {
    Table,
    Id,
    UserId,
    StartedAt,
    EndedAt,
    DurationSeconds,
    ContextCode,
    ContextNote,
    CreatedAt,
}
