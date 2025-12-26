import 'package:mobile/features/silence/domain/entities/silence_session.dart';

/// Utility class for computing chart data from silence sessions.
///
/// Provides static methods to transform session lists into chart-ready data.
class ChartDataHelper {
  /// Compute daily average durations for sessions.
  ///
  /// Groups sessions by date (ignoring time) and calculates average duration
  /// for each date. Only includes completed sessions with duration data.
  ///
  /// Returns a map of date → average duration in seconds.
  static Map<DateTime, double> computeDailyAverageDurations(
    List<SilenceSession> sessions,
  ) {
    // Filter completed sessions with duration
    final completedSessions = sessions
        .where((s) => s.isCompleted && s.durationSeconds != null)
        .toList();

    if (completedSessions.isEmpty) {
      return {};
    }

    // Group sessions by date (year-month-day, ignore time)
    final sessionsByDate = <DateTime, List<int>>{};

    for (final session in completedSessions) {
      final date = DateTime(
        session.startedAt.year,
        session.startedAt.month,
        session.startedAt.day,
      );

      sessionsByDate.putIfAbsent(date, () => []);
      sessionsByDate[date]!.add(session.durationSeconds!);
    }

    // Compute average for each date
    final dailyAverages = <DateTime, double>{};

    sessionsByDate.forEach((date, durations) {
      final sum = durations.reduce((a, b) => a + b);
      final average = sum / durations.length;
      dailyAverages[date] = average;
    });

    return dailyAverages;
  }

  /// Compute hourly distribution of sessions (0-23 hours).
  ///
  /// Counts how many sessions started in each hour of the day.
  /// Returns a map of hour (0-23) → session count.
  static Map<int, int> computeHourlyDistribution(
    List<SilenceSession> sessions,
  ) {
    final hourCounts = <int, int>{};

    for (final session in sessions) {
      final hour = session.startedAt.hour;
      hourCounts[hour] = (hourCounts[hour] ?? 0) + 1;
    }

    return hourCounts;
  }

  /// Compute context frequency distribution.
  ///
  /// Counts how many times each context appears across all sessions.
  /// Only includes sessions with a context label.
  ///
  /// Returns a map of context label → count.
  static Map<String, int> computeContextCounts(
    List<SilenceSession> sessions,
  ) {
    final contextCounts = <String, int>{};

    for (final session in sessions) {
      if (session.contextLabel != null && session.contextLabel!.isNotEmpty) {
        final label = session.contextLabel!;
        contextCounts[label] = (contextCounts[label] ?? 0) + 1;
      }
    }

    return contextCounts;
  }

  // Prevent instantiation
  ChartDataHelper._();
}
