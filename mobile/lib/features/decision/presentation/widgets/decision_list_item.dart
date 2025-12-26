import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/features/decision/domain/entities/decision.dart';

class DecisionListItem extends StatelessWidget {
  final Decision decision;
  final VoidCallback? onTap;

  const DecisionListItem({
    super.key,
    required this.decision,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Title and Status
            Row(
              children: [
                Expanded(
                  child: Text(
                    decision.title,
                    style: AppTypography.onboardingBody.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _buildStatusBadge(),
              ],
            ),

            // Context label if available
            if (decision.contextLabel != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(
                    Icons.label_outline,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    decision.contextLabel!,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],

            // Reason preview if available
            if (decision.reason != null && decision.reason!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                decision.reason!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            // Footer: Date and tags
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 14,
                  color: AppColors.textDisabled,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  _formatDate(decision.decidedAt ?? decision.createdAt),
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
                const Spacer(),
                if (decision.tags != null && decision.tags!.isNotEmpty)
                  _buildTagsPreview(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: decision.statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
      ),
      child: Text(
        decision.statusDisplayName,
        style: AppTypography.caption.copyWith(
          color: decision.statusColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTagsPreview() {
    final tags = decision.tags!;
    final displayTags = tags.take(2).toList();
    final remainingCount = tags.length - 2;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...displayTags.map((tag) => Container(
              margin: const EdgeInsets.only(left: AppSpacing.xs),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                tag,
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
                ),
              ),
            )),
        if (remainingCount > 0)
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.xs),
            child: Text(
              '+$remainingCount',
              style: AppTypography.caption.copyWith(
                color: AppColors.textDisabled,
                fontSize: 10,
              ),
            ),
          ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, y').format(date);
    }
  }
}
