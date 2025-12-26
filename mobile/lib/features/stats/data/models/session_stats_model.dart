import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile/features/stats/data/models/context_count_model.dart';

part 'session_stats_model.freezed.dart';
part 'session_stats_model.g.dart';

@freezed
abstract class SessionStatsModel with _$SessionStatsModel {
  const factory SessionStatsModel({
    @JsonKey(name: 'total_sessions') required int totalSessions,
    @JsonKey(name: 'total_duration_seconds') required int totalDurationSeconds,
    @JsonKey(name: 'average_duration_seconds')
    required int averageDurationSeconds,
    @JsonKey(name: 'longest_session_seconds') int? longestSessionSeconds,
    @JsonKey(name: 'shortest_session_seconds') int? shortestSessionSeconds,
    @JsonKey(name: 'most_common_context') ContextCountModel? mostCommonContext,
  }) = _SessionStatsModel;

  factory SessionStatsModel.fromJson(Map<String, dynamic> json) =>
      _$SessionStatsModelFromJson(json);
}
