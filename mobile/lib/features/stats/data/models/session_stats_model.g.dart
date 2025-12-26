// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionStatsModel _$SessionStatsModelFromJson(Map<String, dynamic> json) =>
    _SessionStatsModel(
      totalSessions: (json['total_sessions'] as num).toInt(),
      totalDurationSeconds: (json['total_duration_seconds'] as num).toInt(),
      averageDurationSeconds: (json['average_duration_seconds'] as num).toInt(),
      longestSessionSeconds: (json['longest_session_seconds'] as num?)?.toInt(),
      shortestSessionSeconds: (json['shortest_session_seconds'] as num?)
          ?.toInt(),
      mostCommonContext: json['most_common_context'] == null
          ? null
          : ContextCountModel.fromJson(
              json['most_common_context'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SessionStatsModelToJson(_SessionStatsModel instance) =>
    <String, dynamic>{
      'total_sessions': instance.totalSessions,
      'total_duration_seconds': instance.totalDurationSeconds,
      'average_duration_seconds': instance.averageDurationSeconds,
      'longest_session_seconds': instance.longestSessionSeconds,
      'shortest_session_seconds': instance.shortestSessionSeconds,
      'most_common_context': instance.mostCommonContext,
    };
