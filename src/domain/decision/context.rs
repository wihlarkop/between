use sea_query::Iden;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use utoipa::ToSchema;

#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct DecisionContext {
    pub code: i16,
    pub label: String,
    pub module: String,
}

/// Table identifier for contexts table (sea-query)
#[derive(Iden)]
pub enum Contexts {
    Table,
    Code,
    Label,
    Module,
}
