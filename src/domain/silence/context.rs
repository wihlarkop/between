use sea_query::Iden;
use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use utoipa::ToSchema;

/// Silence context entity from database
#[derive(Debug, Clone, Serialize, Deserialize, FromRow, ToSchema)]
pub struct SilenceContext {
    pub code: i16,
    pub label: String,
}

/// Table identifier for silence_contexts table (sea-query)
#[derive(Iden)]
pub enum SilenceContexts {
    Table,
    Code,
    Label,
}
