import 'package:flutter/material.dart';

import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_animations.dart';

/// Custom styled snackbar that matches the app's minimalist theme.
class AppSnackBar {
  /// Show a success snackbar
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      context,
      message: message,
      icon: Icons.check_circle_outline,
      backgroundColor: AppColors.success,
      duration: duration,
    );
  }

  /// Show an error snackbar
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      context,
      message: message,
      icon: Icons.error_outline,
      backgroundColor: AppColors.error,
      duration: duration,
    );
  }

  /// Show an info snackbar
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      context,
      message: message,
      icon: Icons.info_outline,
      backgroundColor: AppColors.primary,
      duration: duration,
    );
  }

  /// Internal method to show the snackbar
  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color backgroundColor,
    required Duration duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        margin: EdgeInsets.all(AppSpacing.md),
        duration: duration,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white.withOpacity(0.8),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1),
          curve: AppAnimations.gentle,
        ),
      ),
    );
  }

  // Prevent instantiation
  AppSnackBar._();
}
