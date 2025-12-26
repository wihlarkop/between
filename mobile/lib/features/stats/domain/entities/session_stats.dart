import 'package:equatable/equatable.dart';

class SessionStats extends Equatable {
  final int totalSessions;
  final int totalSilenceSeconds;
  final double averageDurationSeconds;
  final int? longestSessionSeconds;
  final int? shortestSessionSeconds;
  final String? mostCommonContext;
  final int? mostCommonHour;

  const SessionStats({
    required this.totalSessions,
    required this.totalSilenceSeconds,
    required this.averageDurationSeconds,
    this.longestSessionSeconds,
    this.shortestSessionSeconds,
    this.mostCommonContext,
    this.mostCommonHour,
  });

  @override
  List<Object?> get props => [
    totalSessions,
    totalSilenceSeconds,
    averageDurationSeconds,
    longestSessionSeconds,
    shortestSessionSeconds,
    mostCommonContext,
    mostCommonHour,
  ];
}
