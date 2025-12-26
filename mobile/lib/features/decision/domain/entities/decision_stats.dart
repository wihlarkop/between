import 'package:equatable/equatable.dart';

class DecisionStats extends Equatable {
  final int totalDecisions;
  final int pendingDecisions;
  final int completedDecisions;
  final int decisionsThisWeek;
  final int decisionsThisMonth;
  final double? avgTimeToCompletionDays;
  final ContextCount? mostCommonContext;
  final List<MonthCount> byMonth;
  final List<ContextCount> byContext;

  const DecisionStats({
    required this.totalDecisions,
    required this.pendingDecisions,
    required this.completedDecisions,
    required this.decisionsThisWeek,
    required this.decisionsThisMonth,
    this.avgTimeToCompletionDays,
    this.mostCommonContext,
    this.byMonth = const [],
    this.byContext = const [],
  });

  @override
  List<Object?> get props => [
        totalDecisions,
        pendingDecisions,
        completedDecisions,
        decisionsThisWeek,
        decisionsThisMonth,
        avgTimeToCompletionDays,
        mostCommonContext,
        byMonth,
        byContext,
      ];
}

class ContextCount extends Equatable {
  final int contextCode;
  final String contextLabel;
  final int count;

  const ContextCount({
    required this.contextCode,
    required this.contextLabel,
    required this.count,
  });

  @override
  List<Object?> get props => [contextCode, contextLabel, count];
}

class MonthCount extends Equatable {
  final String month;
  final int count;

  const MonthCount({
    required this.month,
    required this.count,
  });

  @override
  List<Object?> get props => [month, count];
}
