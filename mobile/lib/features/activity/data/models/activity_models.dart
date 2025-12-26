import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_models.freezed.dart';
part 'activity_models.g.dart';

/// Activity item from the unified /api/sessions endpoint
@freezed
abstract class ActivityItem with _$ActivityItem {
  const factory ActivityItem({
    required String id,
    required String module,
    @JsonKey(name: 'module_session_id') required String moduleSessionId,
    @JsonKey(name: 'started_at') required DateTime startedAt,
    @JsonKey(name: 'started_at_local') required String startedAtLocal,
    @JsonKey(name: 'ended_at') DateTime? endedAt,
    @JsonKey(name: 'ended_at_local') String? endedAtLocal,
    @JsonKey(name: 'duration_seconds') int? durationSeconds,
    @JsonKey(name: 'context_code') int? contextCode,
    @JsonKey(name: 'context_label') String? contextLabel,
    Map<String, dynamic>? metadata,
  }) = _ActivityItem;

  factory ActivityItem.fromJson(Map<String, dynamic> json) =>
      _$ActivityItemFromJson(json);
}

/// Response from GET /api/sessions
@freezed
abstract class ActivityListResponse with _$ActivityListResponse {
  const factory ActivityListResponse({
    required List<ActivityItem> activities,
  }) = _ActivityListResponse;

  factory ActivityListResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityListResponseFromJson(json);
}

/// Query parameters for GET /api/sessions
class ActivityQueryParams {
  final String? module;
  final int? page;
  final int? limit;
  final DateTime? fromDate;
  final DateTime? toDate;

  const ActivityQueryParams({
    this.module,
    this.page,
    this.limit,
    this.fromDate,
    this.toDate,
  });

  Map<String, String> toQueryParams() {
    final params = <String, String>{};

    if (module != null) params['module'] = module!;
    if (page != null) params['page'] = page.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (fromDate != null) params['from_date'] = fromDate!.toIso8601String();
    if (toDate != null) params['to_date'] = toDate!.toIso8601String();

    return params;
  }
}

/// Module count in statistics
@freezed
abstract class ModuleCount with _$ModuleCount {
  const factory ModuleCount({
    required String module,
    required int count,
  }) = _ModuleCount;

  factory ModuleCount.fromJson(Map<String, dynamic> json) =>
      _$ModuleCountFromJson(json);
}

/// Context count in statistics
@freezed
abstract class ContextCount with _$ContextCount {
  const factory ContextCount({
    required int code,
    required String label,
    required int count,
  }) = _ContextCount;

  factory ContextCount.fromJson(Map<String, dynamic> json) =>
      _$ContextCountFromJson(json);
}

/// Activity statistics response
@freezed
abstract class ActivityStatsResponse with _$ActivityStatsResponse {
  const factory ActivityStatsResponse({
    @JsonKey(name: 'total_activities') required int totalActivities,
    @JsonKey(name: 'total_duration_seconds') required int totalDurationSeconds,
    @JsonKey(name: 'average_duration_seconds')
    required int averageDurationSeconds,
    @JsonKey(name: 'longest_activity_seconds')
    required int longestActivitySeconds,
    @JsonKey(name: 'shortest_activity_seconds')
    required int shortestActivitySeconds,
    @JsonKey(name: 'activities_by_module')
    required List<ModuleCount> activitiesByModule,
    @JsonKey(name: 'most_common_context') ContextCount? mostCommonContext,
  }) = _ActivityStatsResponse;

  factory ActivityStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityStatsResponseFromJson(json);
}
