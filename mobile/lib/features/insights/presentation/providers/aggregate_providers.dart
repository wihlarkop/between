import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/core/constants/module_constants.dart';
import 'package:mobile/core/domain/entities/base_session.dart';
import 'package:mobile/features/history/presentation/providers/session_history_provider.dart';
import 'package:mobile/features/decision/presentation/providers/decision_history_provider.dart';

part 'aggregate_providers.g.dart';

/// Provider that aggregates sessions from all modules
///
/// Supports filtering by module ID:
/// - null: return all sessions from all modules
/// - ModuleConstants.silence: return only silence sessions
/// - ModuleConstants.decision: return only decision sessions
/// etc.
@riverpod
Future<List<BaseSession>> allSessions(
  Ref ref, {
  String? moduleId,
}) async {
  final List<BaseSession> sessions = [];

  // Add Silence sessions (if not filtered or if filtering for silence)
  if (moduleId == null || moduleId == ModuleConstants.silence) {
    final silenceSessions = await ref.watch(sessionHistoryProvider.future);
    sessions.addAll(silenceSessions);
  }

  // Add Decision sessions (if not filtered or if filtering for decision)
  if (moduleId == null || moduleId == ModuleConstants.decision) {
    final decisionSessions = await ref.watch(decisionHistoryProvider.future);
    sessions.addAll(decisionSessions);
  }

  // Sort by most recent first
  sessions.sort((a, b) => b.startedAt.compareTo(a.startedAt));

  return sessions;
}

/// Provider for aggregate statistics across all modules
///
/// Calculates total sessions, total duration, etc. across all modules
/// or for a specific module if moduleId is provided.
@riverpod
Future<AggregateStats> aggregateStats(
  Ref ref, {
  String? moduleId,
}) async {
  final sessions = await ref.watch(allSessionsProvider(moduleId: moduleId).future);

  // Filter only completed sessions with duration
  final completedSessions = sessions
      .where((s) => s.endedAt != null && s.durationSeconds != null)
      .toList();

  if (completedSessions.isEmpty) {
    return const AggregateStats(
      totalSessions: 0,
      totalDurationSeconds: 0,
      averageDurationSeconds: 0,
      longestSessionSeconds: 0,
      shortestSessionSeconds: 0,
    );
  }

  final totalSessions = completedSessions.length;
  final totalDuration = completedSessions.fold<int>(
    0,
    (sum, session) => sum + (session.durationSeconds ?? 0),
  );
  final avgDuration = (totalDuration / totalSessions).round();
  final longest = completedSessions
      .map((s) => s.durationSeconds ?? 0)
      .reduce((a, b) => a > b ? a : b);
  final shortest = completedSessions
      .map((s) => s.durationSeconds ?? 0)
      .reduce((a, b) => a < b ? a : b);

  return AggregateStats(
    totalSessions: totalSessions,
    totalDurationSeconds: totalDuration,
    averageDurationSeconds: avgDuration,
    longestSessionSeconds: longest,
    shortestSessionSeconds: shortest,
  );
}

/// Aggregate statistics data class
class AggregateStats {
  final int totalSessions;
  final int totalDurationSeconds;
  final int averageDurationSeconds;
  final int longestSessionSeconds;
  final int shortestSessionSeconds;

  const AggregateStats({
    required this.totalSessions,
    required this.totalDurationSeconds,
    required this.averageDurationSeconds,
    required this.longestSessionSeconds,
    required this.shortestSessionSeconds,
  });
}
