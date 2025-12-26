pub use sea_orm_migration::prelude::*;

mod m20241216000001_create_users;
mod m20241216000003_create_silence_sessions;
mod m20241216000004_create_indexes;
mod m20251223000001_add_termination_reason_to_silence_sessions;
mod m20251225000001_create_decisions;
mod m20251225000002_create_decision_indexes;
mod m20251226000001_create_user_activities;
mod m20251226000002_create_user_activity_indexes;

pub struct Migrator;

#[async_trait::async_trait]
impl MigratorTrait for Migrator {
    fn migrations() -> Vec<Box<dyn MigrationTrait>> {
        vec![
            Box::new(m20241216000001_create_users::Migration),
            Box::new(m20241216000003_create_silence_sessions::Migration),
            Box::new(m20241216000004_create_indexes::Migration),
            Box::new(m20251223000001_add_termination_reason_to_silence_sessions::Migration),
            Box::new(m20251225000001_create_decisions::Migration),
            Box::new(m20251225000002_create_decision_indexes::Migration),
            Box::new(m20251226000001_create_user_activities::Migration),
            Box::new(m20251226000002_create_user_activity_indexes::Migration),
        ]
    }
}
