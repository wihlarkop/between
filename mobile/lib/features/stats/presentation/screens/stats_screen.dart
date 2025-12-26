import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/features/history/presentation/providers/session_history_provider.dart';
import 'package:mobile/features/stats/presentation/providers/stats_provider.dart';
import 'package:mobile/features/stats/presentation/utils/chart_data_helper.dart';
import 'package:mobile/features/stats/presentation/widgets/context_distribution_chart.dart';
import 'package:mobile/features/stats/presentation/widgets/duration_trend_chart.dart';
import 'package:mobile/features/stats/presentation/widgets/time_distribution_chart.dart';
import 'package:mobile/core/widgets/error_state.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsProvider);
    final historyAsync = ref.watch(sessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics'), elevation: 0),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            ref.read(statsProvider.notifier).refresh(),
            ref.read(sessionHistoryProvider.notifier).refresh(),
          ]);
        },
        color: AppColors.primary,
        child: statsAsync.when(
          data: (stats) {
            return historyAsync.when(
              data: (sessions) {
                // Compute chart data from session history
                final dailyAverageDurations =
                    ChartDataHelper.computeDailyAverageDurations(sessions);
                final hourlyDistribution =
                    ChartDataHelper.computeHourlyDistribution(sessions);
                final contextCounts = ChartDataHelper.computeContextCounts(
                  sessions,
                );

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.screenPaddingHorizontal,
                    AppSpacing.screenPaddingHorizontal,
                    AppSpacing.screenPaddingHorizontal,
                    120, // Bottom padding for glass nav bar
                  ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Summary Stats Cards
                      _StatCard(
                        label: 'Total Sessions',
                        value: stats.totalSessions.toString(),
                        icon: Icons.numbers,
                      ),
                      SizedBox(height: AppSpacing.md),
                      _StatCard(
                        label: 'Total Duration',
                        value: _formatDuration(stats.totalSilenceSeconds),
                        icon: Icons.hourglass_full,
                      ),
                      SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              label: 'Longest',
                              value: _formatDuration(
                                stats.longestSessionSeconds ?? 0,
                              ),
                              icon: Icons.arrow_upward,
                            ),
                          ),
                          SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _StatCard(
                              label: 'Shortest',
                              value: _formatDuration(
                                stats.shortestSessionSeconds ?? 0,
                              ),
                              icon: Icons.arrow_downward,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.md),
                      _StatCard(
                        label: 'Most Common Context',
                        value: stats.mostCommonContext ?? 'N/A',
                        icon: Icons.category,
                      ),

                      // Charts Section
                      SizedBox(height: AppSpacing.xxxl),

                      // Duration Trends Chart
                      DurationTrendChart(
                        dailyAverageDurations: dailyAverageDurations,
                      ),

                      SizedBox(height: AppSpacing.xxxl),

                      // Time Distribution Chart
                      TimeDistributionChart(
                        hourlyDistribution: hourlyDistribution,
                      ),

                      SizedBox(height: AppSpacing.xxxl),

                      // Context Distribution Chart
                      ContextDistributionChart(contextCounts: contextCounts),

                      SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                );
              },
              loading: () =>
                  const CenteredLoadingIndicator(message: 'Loading charts'),
              error: (error, stack) => ErrorState(
                message: 'Could not load session history',
                onRetry: () =>
                    ref.read(sessionHistoryProvider.notifier).refresh(),
              ),
            );
          },
          loading: () =>
              const CenteredLoadingIndicator(message: 'Loading stats'),
          error: (error, stack) => ErrorState(
            message: 'Could not load statistics',
            onRetry: () => ref.read(statsProvider.notifier).refresh(),
          ),
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    if (seconds < 60) return '$seconds sec';
    final m = seconds ~/ 60;
    if (m < 60) return '$m min';
    final h = m ~/ 60;
    final remainingM = m % 60;
    return '${h}h ${remainingM}m';
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: AppColors.primary),
          SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.statValue,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.statLabel,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
