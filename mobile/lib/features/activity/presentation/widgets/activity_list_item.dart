import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/constants/module_constants.dart';
import 'package:mobile/features/activity/data/models/activity_models.dart';

class ActivityListItem extends StatelessWidget {
  final ActivityItem activity;
  final VoidCallback onTap;

  const ActivityListItem({
    super.key,
    required this.activity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPaddingHorizontal,
          vertical: AppSpacing.sm / 2,
        ),
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          child: Row(
            children: [
              // Duration box (left)
              _buildDurationBox(),
              SizedBox(width: AppSpacing.md),

              // Activity info (center)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Module name
                    Text(
                      ModuleConstants.getDisplayName(activity.module),
                      style: AppTypography.durationText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),

                    // Timestamp
                    Text(
                      DateFormat('MMM d, yyyy • HH:mm')
                          .format(activity.startedAt),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    // Context label (if exists)
                    if (activity.contextLabel != null) ...[
                      SizedBox(height: AppSpacing.xs / 2),
                      Text(
                        activity.contextLabel!,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Chevron (right)
              Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDurationBox() {
    final moduleColor = _getModuleColor(activity.module);

    if (activity.durationSeconds == null) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: moduleColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
        ),
        child: Icon(
          _getModuleIcon(activity.module),
          size: 24,
          color: moduleColor,
        ),
      );
    }

    final duration = Duration(seconds: activity.durationSeconds!);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final String displayValue;
    final String displayUnit;

    if (hours > 0) {
      displayValue = hours.toString();
      displayUnit = hours == 1 ? 'hour' : 'hours';
    } else if (minutes > 0) {
      displayValue = minutes.toString();
      displayUnit = 'min';
    } else {
      displayValue = seconds.toString();
      displayUnit = 'sec';
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: moduleColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            displayValue,
            style: AppTypography.durationText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: moduleColor,
            ),
          ),
          SizedBox(height: 2),
          Text(
            displayUnit,
            style: AppTypography.caption.copyWith(
              fontSize: 10,
              color: moduleColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getModuleIcon(String module) {
    switch (module) {
      case 'silence':
        return Icons.circle_outlined;
      case 'decision':
        return Icons.lightbulb_outline;
      default:
        return Icons.circle_outlined;
    }
  }

  Color _getModuleColor(String module) {
    switch (module) {
      case 'silence':
        return AppColors.moduleSilence;
      case 'decision':
        return AppColors.moduleDecision;
      default:
        return AppColors.primary;
    }
  }
}
