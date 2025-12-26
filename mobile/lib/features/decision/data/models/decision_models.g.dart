// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DecisionModel _$DecisionModelFromJson(Map<String, dynamic> json) =>
    _DecisionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      title: json['title'] as String,
      decidedAt: json['decided_at'] as String?,
      reason: json['reason'] as String?,
      expectation: json['expectation'] as String?,
      completedAt: json['completed_at'] as String?,
      actualResult: json['actual_result'] as String?,
      learnings: json['learnings'] as String?,
      contextCode: (json['context_code'] as num?)?.toInt(),
      contextLabel: json['context_label'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: json['created_at'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$DecisionModelToJson(_DecisionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'decided_at': instance.decidedAt,
      'reason': instance.reason,
      'expectation': instance.expectation,
      'completed_at': instance.completedAt,
      'actual_result': instance.actualResult,
      'learnings': instance.learnings,
      'context_code': instance.contextCode,
      'context_label': instance.contextLabel,
      'tags': instance.tags,
      'created_at': instance.createdAt,
      'status': instance.status,
    };

_DecisionListResponse _$DecisionListResponseFromJson(
  Map<String, dynamic> json,
) => _DecisionListResponse(
  decisions: (json['decisions'] as List<dynamic>)
      .map((e) => DecisionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DecisionListResponseToJson(
  _DecisionListResponse instance,
) => <String, dynamic>{'decisions': instance.decisions};

_CreateDecisionRequest _$CreateDecisionRequestFromJson(
  Map<String, dynamic> json,
) => _CreateDecisionRequest(
  title: json['title'] as String,
  decidedAt: json['decided_at'] as String?,
  reason: json['reason'] as String?,
  expectation: json['expectation'] as String?,
  completedAt: json['completed_at'] as String?,
  actualResult: json['actual_result'] as String?,
  learnings: json['learnings'] as String?,
  contextCode: (json['context_code'] as num?)?.toInt(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$CreateDecisionRequestToJson(
  _CreateDecisionRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'decided_at': ?instance.decidedAt,
  'reason': ?instance.reason,
  'expectation': ?instance.expectation,
  'completed_at': ?instance.completedAt,
  'actual_result': ?instance.actualResult,
  'learnings': ?instance.learnings,
  'context_code': ?instance.contextCode,
  'tags': ?instance.tags,
};

_UpdateDecisionRequest _$UpdateDecisionRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateDecisionRequest(
  title: json['title'] as String?,
  decidedAt: json['decided_at'] as String?,
  reason: json['reason'] as String?,
  expectation: json['expectation'] as String?,
  completedAt: json['completed_at'] as String?,
  actualResult: json['actual_result'] as String?,
  learnings: json['learnings'] as String?,
  contextCode: (json['context_code'] as num?)?.toInt(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$UpdateDecisionRequestToJson(
  _UpdateDecisionRequest instance,
) => <String, dynamic>{
  'title': ?instance.title,
  'decided_at': ?instance.decidedAt,
  'reason': ?instance.reason,
  'expectation': ?instance.expectation,
  'completed_at': ?instance.completedAt,
  'actual_result': ?instance.actualResult,
  'learnings': ?instance.learnings,
  'context_code': ?instance.contextCode,
  'tags': ?instance.tags,
};

_DecisionStatsModel _$DecisionStatsModelFromJson(Map<String, dynamic> json) =>
    _DecisionStatsModel(
      totalDecisions: (json['total_decisions'] as num).toInt(),
      pendingDecisions: (json['pending_decisions'] as num).toInt(),
      completedDecisions: (json['completed_decisions'] as num).toInt(),
      decisionsThisWeek: (json['decisions_this_week'] as num).toInt(),
      decisionsThisMonth: (json['decisions_this_month'] as num).toInt(),
      avgTimeToCompletionDays: (json['avg_time_to_completion_days'] as num?)
          ?.toDouble(),
      mostCommonContext: json['most_common_context'] == null
          ? null
          : ContextCountModel.fromJson(
              json['most_common_context'] as Map<String, dynamic>,
            ),
      byMonth:
          (json['by_month'] as List<dynamic>?)
              ?.map((e) => MonthCountModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      byContext:
          (json['by_context'] as List<dynamic>?)
              ?.map(
                (e) => ContextCountModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DecisionStatsModelToJson(_DecisionStatsModel instance) =>
    <String, dynamic>{
      'total_decisions': instance.totalDecisions,
      'pending_decisions': instance.pendingDecisions,
      'completed_decisions': instance.completedDecisions,
      'decisions_this_week': instance.decisionsThisWeek,
      'decisions_this_month': instance.decisionsThisMonth,
      'avg_time_to_completion_days': instance.avgTimeToCompletionDays,
      'most_common_context': instance.mostCommonContext,
      'by_month': instance.byMonth,
      'by_context': instance.byContext,
    };

_ContextCountModel _$ContextCountModelFromJson(Map<String, dynamic> json) =>
    _ContextCountModel(
      contextCode: (json['context_code'] as num).toInt(),
      contextLabel: json['context_label'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$ContextCountModelToJson(_ContextCountModel instance) =>
    <String, dynamic>{
      'context_code': instance.contextCode,
      'context_label': instance.contextLabel,
      'count': instance.count,
    };

_MonthCountModel _$MonthCountModelFromJson(Map<String, dynamic> json) =>
    _MonthCountModel(
      month: json['month'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$MonthCountModelToJson(_MonthCountModel instance) =>
    <String, dynamic>{'month': instance.month, 'count': instance.count};
