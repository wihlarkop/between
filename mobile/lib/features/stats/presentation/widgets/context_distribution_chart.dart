import 'package:flutter/material.dart';

import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';

/// Horizontal bar chart showing frequency of different contexts.
///
/// Simple, minimal display of which contexts are most common.
class ContextDistributionChart extends StatelessWidget {
  final Map<String, int> contextCounts; // context label -> count

  const ContextDistributionChart({super.key, required this.contextCounts});

  @override
  Widget build(BuildContext context) {
    if (contextCounts.isEmpty) {
      return _buildEmptyState();
    }

    // Sort contexts by count (descending)
    final sortedContexts = contextCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final maxCount = sortedContexts.first.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CONTEXT DISTRIBUTION', style: AppTypography.statLabel),
        SizedBox(height: AppSpacing.sm),
        Text('Most common contexts', style: AppTypography.caption),
        SizedBox(height: AppSpacing.md),
        ...sortedContexts.map((entry) {
          return _ContextBar(
            label: entry.key,
            count: entry.value,
            maxCount: maxCount,
          );
        }),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CONTEXT DISTRIBUTION', style: AppTypography.statLabel),
        SizedBox(height: AppSpacing.md),
        Text('No context data yet', style: AppTypography.emptyStateDescription),
      ],
    );
  }
}

/// Individual horizontal bar for a context
class _ContextBar extends StatelessWidget {
  final String label;
  final int count;
  final int maxCount;

  const _ContextBar({
    required this.label,
    required this.count,
    required this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = maxCount > 0 ? count / maxCount : 0.0;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          // Context label
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(width: AppSpacing.sm),

          // Progress bar
          Expanded(
            child: Stack(
              children: [
                // Background bar
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                  ),
                ),

                // Filled bar
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusSmall,
                      ),
                    ),
                  ),
                ),

                // Count label
                Container(
                  height: 24,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
