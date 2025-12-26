import 'package:flutter/material.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';

/// Elevation levels for cards and surfaces
enum CardElevation {
  /// No elevation - flat with border only
  flat,

  /// Subtle elevation - minimal shadow for cards
  elevated,

  /// Prominent elevation - for floating elements like dialogs
  floating,
}

/// Display mode for card elevation
enum CardElevationMode {
  /// Use shadow for elevation (modern, Apple-style)
  shadow,

  /// Use border for elevation (classic, Todoist-style)
  border,
}

/// A card widget with configurable elevation using shadows or borders.
///
/// Provides three elevation levels (flat, elevated, floating) and supports
/// both shadow and border modes for flexibility. Maintains the app's
/// minimalist aesthetic while adding subtle depth.
class ElevatedCard extends StatelessWidget {
  const ElevatedCard({
    super.key,
    required this.child,
    this.elevation = CardElevation.elevated,
    this.mode = CardElevationMode.shadow,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.onTap,
    this.splashColor,
  });

  /// The widget to display inside the card
  final Widget child;

  /// The elevation level (flat, elevated, floating)
  final CardElevation elevation;

  /// The elevation mode (shadow or border)
  final CardElevationMode mode;

  /// Optional padding (defaults to AppSpacing.cardPadding)
  final EdgeInsetsGeometry? padding;

  /// Optional border radius (defaults to AppSpacing.radiusMedium)
  final BorderRadius? borderRadius;

  /// Optional background color (defaults to AppColors.surface)
  final Color? backgroundColor;

  /// Optional tap callback
  final VoidCallback? onTap;

  /// Optional splash color for ripple effect (defaults to primary @ 10%)
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppSpacing.radiusMedium);
    final effectivePadding = padding ?? EdgeInsets.all(AppSpacing.cardPadding);
    final effectiveBackgroundColor = backgroundColor ?? AppColors.surface;

    // Determine shadow and border based on elevation and mode
    final shadow = _getShadow();
    final border = _getBorder();

    Widget card = Container(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: effectiveBorderRadius,
        boxShadow: shadow,
        border: border,
      ),
      padding: effectivePadding,
      child: child,
    );

    // Wrap with InkWell if tappable
    if (onTap != null) {
      final effectiveSplashColor =
          splashColor ?? AppColors.primary.withOpacity(0.1);

      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveBorderRadius,
          splashColor: effectiveSplashColor,
          highlightColor: effectiveSplashColor.withOpacity(0.5),
          child: card,
        ),
      );
    }

    return card;
  }

  /// Get shadow configuration based on elevation and mode
  List<BoxShadow>? _getShadow() {
    if (mode == CardElevationMode.border) return null;

    switch (elevation) {
      case CardElevation.flat:
        return null;

      case CardElevation.elevated:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ];

      case CardElevation.floating:
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ];
    }
  }

  /// Get border configuration based on elevation and mode
  Border? _getBorder() {
    if (mode == CardElevationMode.shadow) {
      // In shadow mode, only flat cards have borders
      if (elevation == CardElevation.flat) {
        return Border.all(
          color: AppColors.border,
          width: 0.5,
        );
      }
      return null;
    }

    // In border mode, all elevations have borders
    switch (elevation) {
      case CardElevation.flat:
        return Border.all(
          color: AppColors.border,
          width: 0.5,
        );

      case CardElevation.elevated:
        return Border.all(
          color: AppColors.border,
          width: 1.0,
        );

      case CardElevation.floating:
        return Border.all(
          color: AppColors.border,
          width: 1.5,
        );
    }
  }
}
