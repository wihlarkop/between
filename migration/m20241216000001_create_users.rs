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
                    .table(Users::Table)
                    .col(
                        uuid(Users::Id)
                            .primary_key()
                            .extra("DEFAULT gen_random_uuid()"),
                    )
                    .col(string_len(Users::Fullname, 255).not_null())
                    .col(string_len(Users::Email, 255).not_null().unique_key())
                    .col(text(Users::PasswordHash).not_null())
                    .col(
                        string_len(Users::Timezone, 100)
                            .not_null()
                            .default("UTC"),
                    )
                    .col(
                        timestamp_with_time_zone(Users::CreatedAt)
                            .extra("DEFAULT CURRENT_TIMESTAMP")
                            .not_null(),
                    )
                    .col(
                        timestamp_with_time_zone(Users::UpdatedAt)
                            .extra("DEFAULT CURRENT_TIMESTAMP")
                            .not_null(),
                    )
                    .to_owned(),
            )
            .await?;

        // Create index for email lookups
        manager
            .create_index(
                Index::create()
                    .name("idx_users_email")
                    .table(Users::Table)
                    .col(Users::Email)
                    .to_owned(),
            )
            .await?;

        // Create trigger to auto-update updated_at
        let db = manager.get_connection();
        db.execute_unprepared(
            r#"
            CREATE OR REPLACE FUNCTION update_updated_at_column()
            RETURNS TRIGGER AS $$
            BEGIN
                NEW.updated_at = CURRENT_TIMESTAMP;
                RETURN NEW;
            END;
            $$ language 'plpgsql';

            CREATE TRIGGER update_users_updated_at
                BEFORE UPDATE ON users
                FOR EACH ROW
                EXECUTE FUNCTION update_updated_at_column();
            "#,
        )
        .await?;

        Ok(())
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        // Drop trigger and function
        let db = manager.get_connection();
        db.execute_unprepared(
            r#"
            DROP TRIGGER IF EXISTS update_users_updated_at ON users;
            DROP FUNCTION IF EXISTS update_updated_at_column();
            "#,
        )
        .await?;

        manager
            .drop_table(Table::drop().table(Users::Table).if_exists().to_owned())
            .await
    }
}

#[derive(DeriveIden)]
pub enum Users {
    Table,
    Id,
    Fullname,
    Email,
    PasswordHash,
    Timezone,
    CreatedAt,
    UpdatedAt,
}
