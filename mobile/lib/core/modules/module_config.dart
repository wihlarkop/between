import 'package:flutter/material.dart';

/// Abstract interface that all modules must implement
///
/// This enables a pluggable module system where new modules can be added
/// without modifying core navigation or home screen code.
abstract class ModuleConfig {
  /// Unique identifier for the module (e.g., 'silence', 'decision')
  String get id;

  /// Display name shown in UI (e.g., 'Silence', 'Decision')
  String get name;

  /// Short description of what the module does
  String get description;

  /// Icon representing the module
  IconData get icon;

  /// Optional accent color for the module (defaults to theme color if not specified)
  Color get accentColor;

  /// Base route for the module (e.g., '/silence')
  String get baseRoute;

  /// Get a quick stat to display on the module card (e.g., "3 sessions today")
  /// Returns null if no stat is available
  Future<String?> getQuickStat();

  /// Called when the module card is tapped
  /// Typically navigates to the module's main screen
  void onTap(BuildContext context);
}
