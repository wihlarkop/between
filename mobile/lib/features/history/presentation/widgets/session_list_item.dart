import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/features/silence/domain/entities/silence_session.dart';

class SessionListItem extends StatelessWidget {
  final SilenceSession session;
  final int animationIndex;

  const SessionListItem({
    super.key,
    required this.session,
    this.animationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final duration = Duration(seconds: session.durationSeconds ?? 0);
    final formattedDuration = _formatDuration(duration);
    final formattedDate = DateFormat(
      'MMM d, yyyy • HH:mm',
    ).format(session.startedAt);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.sm,
      ),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
              ),
              child: Center(
                child: Text(
                  formattedDuration,
                  style: AppTypography.timerMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: AppTypography.durationText.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  if (session.contextLabel != null)
                    Text(
                      session.contextLabel!,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                      ),
                    )
                  else
                    Text(
                      'No context',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (session.terminationReason != null)
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (hours > 0) return '${hours}h\n${minutes}m';
    if (minutes > 0) return '${minutes}m\n${seconds}s';
    return '${seconds}s';
  }
}
