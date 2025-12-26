import 'package:flutter/material.dart';

import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';

/// A reusable widget for displaying error states across the app.
///
/// Provides a consistent way to show errors with optional retry functionality.
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.screenPaddingHorizontal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error icon
            Icon(icon, size: 64, color: AppColors.error),

            SizedBox(height: AppSpacing.lg),

            // Error message
            Text(
              message,
              style: AppTypography.emptyStateDescription.copyWith(
                color: AppColors.text,
              ),
              textAlign: TextAlign.center,
            ),

            if (onRetry != null) ...[
              SizedBox(height: AppSpacing.xl),

              // Retry button
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.border),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// An inline error message for form fields and small errors.
class InlineError extends StatelessWidget {
  final String message;
  final IconData icon;

  const InlineError({
    super.key,
    required this.message,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.error),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
