import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constants/module_constants.dart';
import 'package:mobile/core/domain/entities/base_session.dart';

class SilenceSession extends Equatable implements BaseSession {
  final String id;
  final String userId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int? durationSeconds;
  final int? contextCode;
  final String? contextLabel;
  final String? contextNote;
  final String? terminationReason;
  final DateTime createdAt;

  const SilenceSession({
    required this.id,
    required this.userId,
    required this.startedAt,
    this.endedAt,
    this.durationSeconds,
    this.contextCode,
    this.contextLabel,
    this.contextNote,
    this.terminationReason,
    required this.createdAt,
  });

  bool get isActive => endedAt == null;

  bool get isCompleted => endedAt != null;

  // BaseSession implementation
  @override
  String get moduleId => ModuleConstants.silence;

  @override
  String get displayTitle => 'Silence Session';

  @override
  String? get displaySubtitle => contextLabel;

  @override
  IconData get displayIcon => Icons.circle_outlined;

  @override
  List<Object?> get props => [
    id,
    userId,
    startedAt,
    endedAt,
    durationSeconds,
    contextCode,
    contextLabel,
    contextNote,
    terminationReason,
    createdAt,
  ];
}
