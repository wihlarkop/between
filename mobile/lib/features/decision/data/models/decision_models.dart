import 'package:freezed_annotation/freezed_annotation.dart';

part 'decision_models.freezed.dart';
part 'decision_models.g.dart';

/// Decision status enum
enum DecisionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('quick')
  quick,
}

/// Decision item model
@freezed
abstract class DecisionModel with _$DecisionModel {
  const factory DecisionModel({
    required String id,
    @JsonKey(name: 'user_id') String? userId,
    required String title,
    @JsonKey(name: 'decided_at') String? decidedAt,
    String? reason,
    String? expectation,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'actual_result') String? actualResult,
    String? learnings,
    @JsonKey(name: 'context_code') int? contextCode,
    @JsonKey(name: 'context_label') String? contextLabel,
    List<String>? tags,
    @JsonKey(name: 'created_at') required String createdAt,
    required String status,
  }) = _DecisionModel;

  factory DecisionModel.fromJson(Map<String, dynamic> json) =>
      _$DecisionModelFromJson(json);
}

/// Decision list response
@freezed
abstract class DecisionListResponse with _$DecisionListResponse {
  const factory DecisionListResponse({
    required List<DecisionModel> decisions,
  }) = _DecisionListResponse;

  factory DecisionListResponse.fromJson(Map<String, dynamic> json) =>
      _$DecisionListResponseFromJson(json);
}

/// Create decision request
@Freezed(toJson: true)
abstract class CreateDecisionRequest with _$CreateDecisionRequest {
  @JsonSerializable(includeIfNull: false)
  const factory CreateDecisionRequest({
    required String title,
    @JsonKey(name: 'decided_at') String? decidedAt,
    String? reason,
    String? expectation,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'actual_result') String? actualResult,
    String? learnings,
    @JsonKey(name: 'context_code') int? contextCode,
    List<String>? tags,
  }) = _CreateDecisionRequest;

  factory CreateDecisionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDecisionRequestFromJson(json);
}

/// Update decision request
@Freezed(toJson: true)
abstract class UpdateDecisionRequest with _$UpdateDecisionRequest {
  @JsonSerializable(includeIfNull: false)
  const factory UpdateDecisionRequest({
    String? title,
    @JsonKey(name: 'decided_at') String? decidedAt,
    String? reason,
    String? expectation,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'actual_result') String? actualResult,
    String? learnings,
    @JsonKey(name: 'context_code') int? contextCode,
    List<String>? tags,
  }) = _UpdateDecisionRequest;

  factory UpdateDecisionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateDecisionRequestFromJson(json);
}

/// Decision statistics response
@freezed
abstract class DecisionStatsModel with _$DecisionStatsModel {
  const factory DecisionStatsModel({
    @JsonKey(name: 'total_decisions') required int totalDecisions,
    @JsonKey(name: 'pending_decisions') required int pendingDecisions,
    @JsonKey(name: 'completed_decisions') required int completedDecisions,
    @JsonKey(name: 'decisions_this_week') required int decisionsThisWeek,
    @JsonKey(name: 'decisions_this_month') required int decisionsThisMonth,
    @JsonKey(name: 'avg_time_to_completion_days') double? avgTimeToCompletionDays,
    @JsonKey(name: 'most_common_context') ContextCountModel? mostCommonContext,
    @JsonKey(name: 'by_month') @Default([]) List<MonthCountModel> byMonth,
    @JsonKey(name: 'by_context') @Default([]) List<ContextCountModel> byContext,
  }) = _DecisionStatsModel;

  factory DecisionStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DecisionStatsModelFromJson(json);
}

/// Context count for statistics
@freezed
abstract class ContextCountModel with _$ContextCountModel {
  const factory ContextCountModel({
    @JsonKey(name: 'context_code') required int contextCode,
    @JsonKey(name: 'context_label') required String contextLabel,
    required int count,
  }) = _ContextCountModel;

  factory ContextCountModel.fromJson(Map<String, dynamic> json) =>
      _$ContextCountModelFromJson(json);
}

/// Month count for statistics
@freezed
abstract class MonthCountModel with _$MonthCountModel {
  const factory MonthCountModel({
    required String month,
    required int count,
  }) = _MonthCountModel;

  factory MonthCountModel.fromJson(Map<String, dynamic> json) =>
      _$MonthCountModelFromJson(json);
}
