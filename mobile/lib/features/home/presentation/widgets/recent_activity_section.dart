import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/constants/module_constants.dart';
import 'package:mobile/features/activity/presentation/providers/activity_provider.dart';

/// Section showing recent activity across all modules
///
/// Uses the unified /api/sessions endpoint to show recent activities
/// from all modules (Silence, Decision, etc.)
class RecentActivitySection extends ConsumerWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentActivitiesAsync = ref.watch(recentActivitiesProvider);

    return recentActivitiesAsync.when(
      data: (activities) {
        if (activities.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenPaddingHorizontal,
            AppSpacing.xl,
            AppSpacing.screenPaddingHorizontal,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              Text(
                'RECENT ACTIVITY',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: AppSpacing.md),

              // Activity list
              ...activities.map((activity) {
                final duration = activity.durationSeconds != null
                    ? _formatDuration(activity.durationSeconds!)
                    : 'In progress';

                final timeAgo = _getTimeAgo(activity.startedAt);

                // Get module display name
                final moduleName =
                    ModuleConstants.getDisplayName(activity.module);

                // Get module icon
                final icon = _getModuleIcon(activity.module);

                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMedium),
                      border: Border.all(
                        color: AppColors.border,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Module icon
                        Icon(
                          icon,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: AppSpacing.md),

                        // Activity details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                moduleName,
                                style: AppTypography.durationText.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: AppSpacing.xs),
                              Text(
                                timeAgo,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Duration badge
                        Text(
                          duration,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    if (hours > 0) {
      // 1h 23m 45s or 1h 23m (if seconds are 0)
      if (secs > 0) {
        return '${hours}h ${minutes}m ${secs}s';
      } else {
        return '${hours}h ${minutes}m';
      }
    } else if (minutes > 0) {
      // 23m 45s or 23m (if seconds are 0)
      if (secs > 0) {
        return '${minutes}m ${secs}s';
      } else {
        return '${minutes}m';
      }
    } else {
      // Just seconds: 45s
      return '${secs}s';
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return DateFormat('MMM d').format(dateTime);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  IconData _getModuleIcon(String module) {
    switch (module) {
      case ModuleConstants.silence:
        return Icons.circle_outlined;
      case ModuleConstants.decision:
        return Icons.lightbulb_outline;
      default:
        return Icons.circle_outlined;
    }
  }
}
