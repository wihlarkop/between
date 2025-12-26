import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constants/module_constants.dart';
import 'package:mobile/core/domain/entities/base_session.dart';

/// Decision status enum matching backend
enum DecisionStatus {
  pending, // decided_at set, completedAt null
  completed, // completedAt set
  quick, // No decided_at, direct completion
}

class Decision extends Equatable implements BaseSession {
  @override
  final String id;
  final String userId;
  final String title;
  final DateTime? decidedAt;
  final DateTime? completedAt;
  final String? reason;
  final String? expectation;
  final String? actualResult;
  final String? learnings;
  final int? contextCode;
  final String? contextLabel;
  final List<String>? tags;
  final DateTime createdAt;
  final String statusString;

  const Decision({
    required this.id,
    required this.userId,
    required this.title,
    this.decidedAt,
    this.completedAt,
    this.reason,
    this.expectation,
    this.actualResult,
    this.learnings,
    this.contextCode,
    this.contextLabel,
    this.tags,
    required this.createdAt,
    required this.statusString,
  });

  /// Get decision status
  DecisionStatus get status {
    switch (statusString) {
      case 'completed':
        return DecisionStatus.completed;
      case 'quick':
        return DecisionStatus.quick;
      default:
        return DecisionStatus.pending;
    }
  }

  bool get isPending => status == DecisionStatus.pending;
  bool get isCompleted => status == DecisionStatus.completed;
  bool get isQuick => status == DecisionStatus.quick;

  String get statusDisplayName {
    switch (status) {
      case DecisionStatus.completed:
        return 'Completed';
      case DecisionStatus.quick:
        return 'Quick';
      case DecisionStatus.pending:
        return 'Pending';
    }
  }

  Color get statusColor {
    switch (status) {
      case DecisionStatus.completed:
        return Colors.green;
      case DecisionStatus.quick:
        return Colors.blue;
      case DecisionStatus.pending:
        return Colors.orange;
    }
  }

  // BaseSession implementation
  @override
  String get moduleId => ModuleConstants.decision;

  @override
  String get displayTitle => title;

  @override
  String? get displaySubtitle => contextLabel ?? statusDisplayName;

  @override
  IconData get displayIcon => Icons.lightbulb_outline;

  @override
  DateTime get startedAt => decidedAt ?? createdAt;

  @override
  DateTime? get endedAt => completedAt;

  @override
  int? get durationSeconds {
    if (completedAt == null || decidedAt == null) return null;
    return completedAt!.difference(decidedAt!).inSeconds;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        decidedAt,
        completedAt,
        reason,
        expectation,
        actualResult,
        learnings,
        contextCode,
        contextLabel,
        tags,
        createdAt,
        statusString,
      ];
}
