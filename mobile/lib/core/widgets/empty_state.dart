import 'package:flutter/material.dart';

import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';

/// A reusable widget for displaying empty states across the app.
///
/// Provides a consistent, calm way to inform users when there's no data
/// without being pushy or judgmental.
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.action,
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
            // Icon
            Icon(icon, size: 64, color: AppColors.textDisabled),

            SizedBox(height: AppSpacing.lg),

            // Title
            Text(
              title,
              style: AppTypography.emptyStateTitle,
              textAlign: TextAlign.center,
            ),

            if (description != null) ...[
              SizedBox(height: AppSpacing.sm),

              // Description
              Text(
                description!,
                style: AppTypography.emptyStateDescription,
                textAlign: TextAlign.center,
              ),
            ],

            if (action != null) ...[SizedBox(height: AppSpacing.xl), action!],
          ],
        ),
      ),
    );
  }
}
