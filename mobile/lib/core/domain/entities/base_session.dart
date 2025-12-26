import 'package:flutter/material.dart';

/// Base interface for all session types across modules
///
/// This enables polymorphic handling of sessions from different modules
/// (Silence, Decision, etc.) in cross-module features like the Insights screen.
abstract class BaseSession {
  /// Unique identifier for the session
  String get id;

  /// Module this session belongs to (e.g., 'silence', 'decision')
  String get moduleId;

  /// When the session/activity started
  DateTime get startedAt;

  /// When the session/activity ended (null if still active)
  DateTime? get endedAt;

  /// Duration in seconds (null if still active or not applicable)
  int? get durationSeconds;

  // Display properties for polymorphic UI rendering

  /// Title to display in lists (e.g., "Silence Session", "Decision: Buy a car")
  String get displayTitle;

  /// Optional subtitle (e.g., context label, decision status)
  String? get displaySubtitle;

  /// Icon representing this session type
  IconData get displayIcon;
}
