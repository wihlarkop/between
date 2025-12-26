// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityItem _$ActivityItemFromJson(Map<String, dynamic> json) =>
    _ActivityItem(
      id: json['id'] as String,
      module: json['module'] as String,
      moduleSessionId: json['module_session_id'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
      startedAtLocal: json['started_at_local'] as String,
      endedAt: json['ended_at'] == null
          ? null
          : DateTime.parse(json['ended_at'] as String),
      endedAtLocal: json['ended_at_local'] as String?,
      durationSeconds: (json['duration_seconds'] as num?)?.toInt(),
      contextCode: (json['context_code'] as num?)?.toInt(),
      contextLabel: json['context_label'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ActivityItemToJson(_ActivityItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'module': instance.module,
      'module_session_id': instance.moduleSessionId,
      'started_at': instance.startedAt.toIso8601String(),
      'started_at_local': instance.startedAtLocal,
      'ended_at': instance.endedAt?.toIso8601String(),
      'ended_at_local': instance.endedAtLocal,
      'duration_seconds': instance.durationSeconds,
      'context_code': instance.contextCode,
      'context_label': instance.contextLabel,
      'metadata': instance.metadata,
    };

_ActivityListResponse _$ActivityListResponseFromJson(
  Map<String, dynamic> json,
) => _ActivityListResponse(
  activities: (json['activities'] as List<dynamic>)
      .map((e) => ActivityItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ActivityListResponseToJson(
  _ActivityListResponse instance,
) => <String, dynamic>{'activities': instance.activities};

_ModuleCount _$ModuleCountFromJson(Map<String, dynamic> json) => _ModuleCount(
  module: json['module'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$ModuleCountToJson(_ModuleCount instance) =>
    <String, dynamic>{'module': instance.module, 'count': instance.count};

_ContextCount _$ContextCountFromJson(Map<String, dynamic> json) =>
    _ContextCount(
      code: (json['code'] as num).toInt(),
      label: json['label'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$ContextCountToJson(_ContextCount instance) =>
    <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'count': instance.count,
    };

_ActivityStatsResponse _$ActivityStatsResponseFromJson(
  Map<String, dynamic> json,
) => _ActivityStatsResponse(
  totalActivities: (json['total_activities'] as num).toInt(),
  totalDurationSeconds: (json['total_duration_seconds'] as num).toInt(),
  averageDurationSeconds: (json['average_duration_seconds'] as num).toInt(),
  longestActivitySeconds: (json['longest_activity_seconds'] as num).toInt(),
  shortestActivitySeconds: (json['shortest_activity_seconds'] as num).toInt(),
  activitiesByModule: (json['activities_by_module'] as List<dynamic>)
      .map((e) => ModuleCount.fromJson(e as Map<String, dynamic>))
      .toList(),
  mostCommonContext: json['most_common_context'] == null
      ? null
      : ContextCount.fromJson(
          json['most_common_context'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ActivityStatsResponseToJson(
  _ActivityStatsResponse instance,
) => <String, dynamic>{
  'total_activities': instance.totalActivities,
  'total_duration_seconds': instance.totalDurationSeconds,
  'average_duration_seconds': instance.averageDurationSeconds,
  'longest_activity_seconds': instance.longestActivitySeconds,
  'shortest_activity_seconds': instance.shortestActivitySeconds,
  'activities_by_module': instance.activitiesByModule,
  'most_common_context': instance.mostCommonContext,
};
