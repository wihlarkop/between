use crate::domain::activity::entity::UserActivityWithContext;
use crate::domain::activity::repository::{ActivityRepositoryTrait, ActivityStats};
use crate::shared::error::{BetweenError, Result};
use crate::shared::schema::activity::{
    ActivityItem, ActivityListResponse, ActivityStatsResponse, ModuleCount as SchemaModuleCount,
    ContextCount as SchemaContextCount,
};
use async_trait::async_trait;
use chrono::{DateTime, Utc};
use chrono_tz::Tz;
use uuid::Uuid;

#[async_trait]
pub trait ActivityServiceTrait: Send + Sync {
    async fn get_activities(
        &self,
        user_id: Uuid,
        user_timezone: &str,
        module: Option<String>,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
    ) -> Result<(ActivityListResponse, u64)>;

    async fn get_stats(
        &self,
        user_id: Uuid,
        module: Option<String>,
    ) -> Result<ActivityStatsResponse>;

    async fn get_activity_by_id(
        &self,
        activity_id: Uuid,
        user_id: Uuid,
        user_timezone: &str,
    ) -> Result<ActivityItem>;
}

pub struct ActivityService<R: ActivityRepositoryTrait> {
    activity_repo: R,
}

impl<R: ActivityRepositoryTrait> ActivityService<R> {
    pub fn new(activity_repo: R) -> Self {
        Self {
            activity_repo,
        }
    }

    fn to_local_time(&self, utc_time: DateTime<Utc>, timezone: &str) -> Result<String> {
        let tz: Tz = timezone
            .parse()
            .map_err(|_| BetweenError::BadRequest(format!("Invalid timezone: {}", timezone)))?;
        let local_time = utc_time.with_timezone(&tz);
        Ok(local_time.to_rfc3339())
    }

    fn convert_activity_to_item(
        &self,
        activity: UserActivityWithContext,
        user_timezone: &str,
    ) -> Result<ActivityItem> {
        let started_at_local = self.to_local_time(activity.started_at, user_timezone)?;
        let ended_at_local = activity
            .ended_at
            .map(|dt| self.to_local_time(dt, user_timezone))
            .transpose()?;

        Ok(ActivityItem {
            id: activity.id,
            module: activity.module,
            module_session_id: activity.module_session_id,
            started_at: activity.started_at,
            started_at_local,
            ended_at: activity.ended_at,
            ended_at_local,
            duration_seconds: activity.duration_seconds,
            context_code: activity.context_code,
            context_label: activity.context_label,
            metadata: activity.metadata,
        })
    }
}

#[async_trait]
impl<R: ActivityRepositoryTrait + Send + Sync> ActivityServiceTrait for ActivityService<R> {
    async fn get_activities(
        &self,
        user_id: Uuid,
        user_timezone: &str,
        module: Option<String>,
        page: u32,
        limit: u32,
        from_date: Option<DateTime<Utc>>,
        to_date: Option<DateTime<Utc>>,
    ) -> Result<(ActivityListResponse, u64)> {
        let (activities, total) = self
            .activity_repo
            .find_activities_paginated(user_id, module, page, limit, from_date, to_date)
            .await?;

        let activity_items: Result<Vec<ActivityItem>> = activities
            .into_iter()
            .map(|activity| self.convert_activity_to_item(activity, user_timezone))
            .collect();

        Ok((
            ActivityListResponse {
                activities: activity_items?,
            },
            total,
        ))
    }

    async fn get_stats(
        &self,
        user_id: Uuid,
        module: Option<String>,
    ) -> Result<ActivityStatsResponse> {
        let stats: ActivityStats = self.activity_repo.get_user_stats(user_id, module).await?;

        let activities_by_module: Vec<SchemaModuleCount> = stats
            .activities_by_module
            .into_iter()
            .map(|mc| SchemaModuleCount {
                module: mc.module,
                count: mc.count,
            })
            .collect();

        let most_common_context = stats.most_common_context.map(|cc| SchemaContextCount {
            code: cc.code,
            label: cc.label,
            count: cc.count,
        });

        Ok(ActivityStatsResponse {
            total_activities: stats.total_activities,
            total_duration_seconds: stats.total_duration_seconds,
            average_duration_seconds: stats.average_duration_seconds,
            longest_activity_seconds: stats.longest_activity_seconds,
            shortest_activity_seconds: stats.shortest_activity_seconds,
            activities_by_module,
            most_common_context,
        })
    }

    async fn get_activity_by_id(
        &self,
        activity_id: Uuid,
        user_id: Uuid,
        user_timezone: &str,
    ) -> Result<ActivityItem> {
        // Fetch activity with context label
        let activity = self
            .activity_repo
            .find_by_id_with_context(activity_id)
            .await?
            .ok_or_else(|| BetweenError::NotFound("Activity not found".to_string()))?;

        // Verify ownership - return 404 (not 403) for security
        if activity.user_id != user_id {
            return Err(BetweenError::NotFound("Activity not found".to_string()));
        }

        // Convert to ActivityItem with timezone conversion
        self.convert_activity_to_item(activity, user_timezone)
    }
}
