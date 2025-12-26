import 'package:flutter/services.dart';

/// Helper class for strategic haptic feedback throughout the app.
///
/// Haptics are used sparingly and only for meaningful moments to maintain
/// the calm, minimal feel of the app.
class AppHaptics {
  /// Light impact - for button taps and UI interactions
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium impact - for session start/stop actions
  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy impact - reserved for significant actions
  static Future<void> heavy() async {
    await HapticFeedback.heavyImpact();
  }

  /// Selection click - for picker/selector interactions
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }

  /// Success notification - for completed actions
  /// On iOS this provides a subtle success feel
  /// On Android this falls back to light impact
  static Future<void> success() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (_) {
      // Silently fail if haptics not supported
    }
  }

  /// Error notification - for error states
  /// On iOS this provides a subtle error feel
  /// On Android this falls back to medium impact
  static Future<void> error() async {
    try {
      await HapticFeedback.mediumImpact();
    } catch (_) {
      // Silently fail if haptics not supported
    }
  }

  // Prevent instantiation
  AppHaptics._();
}
