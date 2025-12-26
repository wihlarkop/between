use sea_orm_migration::{prelude::*, schema::*};

use super::m20241216000001_create_users::Users;

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                Table::create()
                    .if_not_exists()
                    .table(UserActivities::Table)
                    .col(
                        uuid(UserActivities::Id)
                            .primary_key()
                            .extra("DEFAULT gen_random_uuid()"),
                    )
                    .col(uuid(UserActivities::UserId).not_null())
                    .col(string_len(UserActivities::Module, 50).not_null())
                    .col(uuid(UserActivities::ModuleSessionId).not_null())
                    .col(timestamp_with_time_zone(UserActivities::StartedAt).not_null())
                    .col(timestamp_with_time_zone_null(UserActivities::EndedAt))
                    .col(integer_null(UserActivities::DurationSeconds))
                    .col(small_integer_null(UserActivities::ContextCode))
                    .col(json_null(UserActivities::Metadata))
                    .col(
                        timestamp_with_time_zone(UserActivities::CreatedAt)
                            .extra("DEFAULT CURRENT_TIMESTAMP")
                            .not_null(),
                    )
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk_user_activities_user_id")
                            .from(UserActivities::Table, UserActivities::UserId)
                            .to(Users::Table, Users::Id)
                            .on_delete(ForeignKeyAction::Cascade),
                    )
                    .to_owned(),
            )
            .await?;

        // Add check constraints via raw SQL
        let db = manager.get_connection();
        db.execute_unprepared(
            r#"
            ALTER TABLE user_activities
            ADD CONSTRAINT check_ended_after_started
                CHECK (ended_at IS NULL OR ended_at > started_at),
            ADD CONSTRAINT check_duration_positive
                CHECK (duration_seconds IS NULL OR duration_seconds > 0),
            ADD CONSTRAINT check_module_valid
                CHECK (module IN ('silence', 'decision', 'focus', 'reflection'));
            "#,
        )
        .await?;

        Ok(())
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(
                Table::drop()
                    .table(UserActivities::Table)
                    .if_exists()
                    .to_owned(),
            )
            .await
    }
}

#[derive(DeriveIden)]
pub enum UserActivities {
    Table,
    Id,
    UserId,
    Module,
    ModuleSessionId,
    StartedAt,
    EndedAt,
    DurationSeconds,
    ContextCode,
    Metadata,
    CreatedAt,
}
