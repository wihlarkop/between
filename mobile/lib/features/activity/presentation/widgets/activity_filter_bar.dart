import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/features/activity/presentation/providers/activity_filters_provider.dart';

class ActivityFilterBar extends ConsumerWidget {
  const ActivityFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateRange = ref.watch(activityDateRangeFilterProvider);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingHorizontal,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Date range filter button
          OutlinedButton.icon(
            onPressed: () => _showDateRangePicker(context, ref),
            icon: Icon(
              dateRange != null
                  ? Icons.calendar_today
                  : Icons.calendar_today_outlined,
              size: 18,
            ),
            label: Text(
              dateRange != null
                  ? '${DateFormat('MMM d').format(dateRange.start)} - ${DateFormat('MMM d').format(dateRange.end)}'
                  : 'Date Range',
              style: AppTypography.caption.copyWith(fontSize: 12),
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              side: BorderSide(
                color: dateRange != null ? AppColors.primary : AppColors.border,
              ),
            ),
          ),

          // Clear date filter (if active)
          if (dateRange != null)
            IconButton(
              icon: const Icon(Icons.clear, size: 18),
              onPressed: () {
                ref
                    .read(activityDateRangeFilterProvider.notifier)
                    .clearDateRange();
              },
              padding: EdgeInsets.all(AppSpacing.xs),
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }

  Future<void> _showDateRangePicker(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDateRange: ref.read(activityDateRangeFilterProvider),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      ref.read(activityDateRangeFilterProvider.notifier).setDateRange(result);
    }
  }
}
