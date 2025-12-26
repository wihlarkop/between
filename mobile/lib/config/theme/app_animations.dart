import 'package:flutter/animation.dart';

/// App-wide animation constants and guidelines.
///
/// Between's animation philosophy:
/// - Longer = Calmer (300-500ms instead of typical 150-250ms)
/// - Gentle curves (no bouncing, no spring physics)
/// - Subtle and purposeful
/// - Respect user motion preferences
class AppAnimations {
  // Duration constants

  /// Fast animations for micro-interactions (200ms)
  /// Use for: Button press feedback, icon changes
  static const Duration fast = Duration(milliseconds: 200);

  /// Medium animations for transitions (300ms)
  /// Use for: Dialog entries, widget state changes, fades
  static const Duration medium = Duration(milliseconds: 300);

  /// Slow animations for page changes (350ms)
  /// Use for: Route transitions, major layout shifts
  /// Balanced between calm and responsive (updated from 500ms)
  static const Duration slow = Duration(milliseconds: 350);

  /// Breathing animation for subtle pulse effects (2000ms)
  /// Use for: Active session indicator, gentle attention draws
  static const Duration breathing = Duration(milliseconds: 2000);

  /// Very fast for instant feedback (100ms)
  /// Use for: Immediate visual responses
  static const Duration veryFast = Duration(milliseconds: 100);

  // Animation curves

  /// Gentle ease in and out - primary curve for calm feel
  static const Curve gentle = Curves.easeInOutCubic;

  /// Calm ease out - for exits and completions
  static const Curve calm = Curves.easeOut;

  /// Ease in - for entrances
  static const Curve enter = Curves.easeIn;

  /// Linear - for continuous animations like breathing
  static const Curve linear = Curves.linear;

  // Stagger delays for list animations

  /// Delay between list items appearing (50ms)
  static const Duration staggerDelay = Duration(milliseconds: 50);

  /// Delay between form fields appearing (100ms)
  static const Duration formFieldDelay = Duration(milliseconds: 100);

  // Scale factors for interactions

  /// Button press scale (subtly smaller for refined feel)
  /// Updated from 0.95 to be less dramatic
  static const double buttonPressScale = 0.97;

  /// Dialog entry scale (from slightly smaller to normal)
  static const double dialogEntryScale = 0.95;

  // Opacity values for breathing animations

  /// Minimum opacity for breathing effect
  /// Enhanced from 0.8 for more noticeable pulse
  static const double breathingOpacityMin = 0.6;

  /// Maximum opacity for breathing effect
  static const double breathingOpacityMax = 1.0;

  // Animation guidelines (documentation)

  /// Guidelines for using animations in Between:
  ///
  /// 1. **Always check motion preferences**:
  ///    ```dart
  ///    final disableAnimations = MediaQuery.disableAnimationsOf(context);
  ///    final duration = disableAnimations ? Duration.zero : AppAnimations.medium;
  ///    ```
  ///
  /// 2. **Use gentle curves**: Prefer `AppAnimations.gentle` for most transitions
  ///
  /// 3. **Be purposeful**: Only animate meaningful state changes, not decorative effects
  ///
  /// 4. **Keep it subtle**: Avoid attention-grabbing animations like bouncing or spring physics
  ///
  /// 5. **Maintain 60fps**: Test animations on mid-range devices to ensure smoothness
  ///
  /// 6. **Respect the philosophy**: Animations should feel calm and intentional, never rushed

  // Prevent instantiation
  AppAnimations._();
}
