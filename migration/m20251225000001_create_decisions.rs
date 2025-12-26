use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                Table::create()
                    .if_not_exists()
                    .table(Decisions::Table)
                    .col(
                        uuid(Decisions::Id)
                            .primary_key()
                            .extra("DEFAULT gen_random_uuid()"),
                    )
                    .col(uuid(Decisions::UserId).not_null())
                    .col(string_len(Decisions::Title, 200).not_null())
                    .col(timestamp_with_time_zone_null(Decisions::DecidedAt))
                    .col(text_null(Decisions::Reason))
                    .col(text_null(Decisions::Expectation))
                    .col(timestamp_with_time_zone_null(Decisions::CompletedAt))
                    .col(text_null(Decisions::ActualResult))
                    .col(text_null(Decisions::Learnings))
                    .col(small_integer_null(Decisions::ContextCode))
                    .col(ColumnDef::new(Decisions::Tags).array(ColumnType::Text))
                    .col(
                        timestamp_with_time_zone(Decisions::CreatedAt)
                            .default(Expr::current_timestamp())
                            .not_null(),
                    )
                    .foreign_key(
                        ForeignKey::create()
                            .from(Decisions::Table, Decisions::UserId)
                            .to(Users::Table, Users::Id)
                            .on_delete(ForeignKeyAction::Cascade),
                    )
                    .foreign_key(
                        ForeignKey::create()
                            .from(Decisions::Table, Decisions::ContextCode)
                            .to(Contexts::Table, Contexts::Code)
                            .on_delete(ForeignKeyAction::SetNull),
                    )
                    .to_owned(),
            )
            .await?;

        // Add CHECK constraints via raw SQL
        manager.get_connection().execute_unprepared(
            r#"
            ALTER TABLE decisions
            ADD CONSTRAINT check_title_length CHECK (length(title) >= 1 AND length(title) <= 200),
            ADD CONSTRAINT check_reason_length CHECK (reason IS NULL OR length(reason) <= 1000),
            ADD CONSTRAINT check_expectation_length CHECK (expectation IS NULL OR length(expectation) <= 1000),
            ADD CONSTRAINT check_actual_result_length CHECK (actual_result IS NULL OR length(actual_result) <= 1000),
            ADD CONSTRAINT check_learnings_length CHECK (learnings IS NULL OR length(learnings) <= 1000),
            ADD CONSTRAINT check_at_least_one_date CHECK (decided_at IS NOT NULL OR completed_at IS NOT NULL),
            ADD CONSTRAINT check_completed_after_decided CHECK (completed_at IS NULL OR decided_at IS NULL OR completed_at >= decided_at);
            "#
        ).await?;

        Ok(())
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(Decisions::Table).if_exists().to_owned())
            .await
    }
}

#[derive(DeriveIden)]
enum Decisions {
    Table,
    Id,
    UserId,
    Title,
    DecidedAt,
    Reason,
    Expectation,
    CompletedAt,
    ActualResult,
    Learnings,
    ContextCode,
    Tags,
    CreatedAt,
}

#[derive(DeriveIden)]
enum Users {
    Table,
    Id,
}

#[derive(DeriveIden)]
pub enum Contexts {
    Table,
    Code,
}
