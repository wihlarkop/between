import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/features/decision/domain/entities/decision_stats.dart';
import 'package:mobile/features/decision/presentation/providers/decision_provider.dart';

class DecisionStatsScreen extends ConsumerWidget {
  const DecisionStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(decisionStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Decision Statistics'),
      ),
      body: statsAsync.when(
        data: (stats) => _buildContent(context, stats),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: AppSpacing.md),
              Text(
                error.toString(),
                style: AppTypography.onboardingBody.copyWith(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextButton.icon(
                onPressed: () => ref.invalidate(decisionStatsProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DecisionStats stats) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview cards
          _buildOverviewSection(stats),

          const SizedBox(height: AppSpacing.xxl),

          // Time metrics
          if (stats.avgTimeToCompletionDays != null) ...[
            Text(
              'Performance',
              style: AppTypography.pageTitle.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildStatCard(
              icon: Icons.timer_outlined,
              title: 'Avg. Time to Complete',
              value: '${stats.avgTimeToCompletionDays!.toStringAsFixed(1)} days',
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],

          // Context breakdown
          if (stats.byContext.isNotEmpty) ...[
            Text(
              'By Context',
              style: AppTypography.pageTitle.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: AppSpacing.md),
            ...stats.byContext.map((ctx) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _buildContextRow(ctx, stats.totalDecisions),
                )),
            const SizedBox(height: AppSpacing.xxl),
          ],

          // Monthly breakdown
          if (stats.byMonth.isNotEmpty) ...[
            Text(
              'Monthly Activity',
              style: AppTypography.pageTitle.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildMonthlyChart(stats.byMonth),
          ],
        ],
      ),
    );
  }

  Widget _buildOverviewSection(DecisionStats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: AppTypography.pageTitle.copyWith(color: AppColors.text),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.lightbulb_outline,
                title: 'Total',
                value: stats.totalDecisions.toString(),
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                icon: Icons.pending_outlined,
                title: 'Pending',
                value: stats.pendingDecisions.toString(),
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.check_circle_outline,
                title: 'Completed',
                value: stats.completedDecisions.toString(),
                color: Colors.green,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_today_outlined,
                title: 'This Month',
                value: stats.decisionsThisMonth.toString(),
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.statValue.copyWith(
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContextRow(ContextCount context, int total) {
    final percentage = total > 0 ? (context.count / total * 100) : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.contextLabel,
                style: AppTypography.onboardingBody.copyWith(
                  color: AppColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${context.count} (${percentage.toStringAsFixed(0)}%)',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyChart(List<MonthCount> months) {
    if (months.isEmpty) return const SizedBox.shrink();

    final maxCount = months.map((m) => m.count).reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: months.take(6).map((month) {
              final height = maxCount > 0 ? (month.count / maxCount * 100) : 0.0;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Text(
                        month.count.toString(),
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Container(
                        height: height.clamp(8, 100),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _formatMonth(month.month),
                        style: AppTypography.helperText.copyWith(
                          color: AppColors.textDisabled,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _formatMonth(String month) {
    if (month.length >= 7) {
      final parts = month.split('-');
      if (parts.length >= 2) {
        final monthNum = int.tryParse(parts[1]);
        if (monthNum != null && monthNum >= 1 && monthNum <= 12) {
          const monthNames = [
            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
          ];
          return monthNames[monthNum - 1];
        }
      }
    }
    return month;
  }
}
