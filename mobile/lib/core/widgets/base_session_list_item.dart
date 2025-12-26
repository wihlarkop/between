import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/domain/entities/base_session.dart';

/// Polymorphic session list item that works for any module
///
/// Displays session information using the BaseSession interface,
/// allowing it to render sessions from different modules (Silence, Decision, etc.)
/// with a consistent design.
class BaseSessionListItem extends StatelessWidget {
  final BaseSession session;

  const BaseSessionListItem({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.sm / 2,
      ),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            // Duration box (left side)
            if (session.durationSeconds != null)
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatDurationShort(session.durationSeconds!),
                      style: AppTypography.durationText.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getDurationUnit(session.durationSeconds!),
                      style: AppTypography.caption.copyWith(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
            else
              // Icon if no duration (e.g., active session or decision without duration)
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                ),
                child: Icon(
                  session.displayIcon,
                  size: 24,
                  color: AppColors.primary,
                ),
              ),

            SizedBox(width: AppSpacing.md),

            // Session info (center)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    session.displayTitle,
                    style: AppTypography.durationText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: AppSpacing.xs),

                  // Date/time
                  Text(
                    _formatDateTime(session.startedAt),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  // Subtitle (if available)
                  if (session.displaySubtitle != null) ...[
                    SizedBox(height: AppSpacing.xs / 2),
                    Text(
                      session.displaySubtitle!,
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
          ],
        ),
      ),
    );
  }

  String _formatDurationShort(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return hours.toString();
    } else {
      return minutes.toString();
    }
  }

  String _getDurationUnit(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;

    if (hours > 0) {
      return hours == 1 ? 'hour' : 'hours';
    } else {
      return 'min';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy • HH:mm').format(dateTime);
  }
}
