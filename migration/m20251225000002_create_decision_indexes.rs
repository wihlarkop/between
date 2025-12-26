use sea_orm_migration::prelude::*;

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager.get_connection().execute_unprepared(
            r#"
            CREATE INDEX idx_decisions_user_completed ON decisions(user_id, completed_at DESC);
            CREATE INDEX idx_decisions_user_decided ON decisions(user_id, decided_at DESC);
            CREATE INDEX idx_decisions_context ON decisions(user_id, context_code);
            CREATE INDEX idx_decisions_tags ON decisions USING GIN(tags);
            "#
        ).await?;

        Ok(())
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager.get_connection().execute_unprepared(
            r#"
            DROP INDEX IF EXISTS idx_decisions_user_completed;
            DROP INDEX IF EXISTS idx_decisions_user_decided;
            DROP INDEX IF EXISTS idx_decisions_context;
            DROP INDEX IF EXISTS idx_decisions_tags;
            "#
        ).await?;

        Ok(())
    }
}
