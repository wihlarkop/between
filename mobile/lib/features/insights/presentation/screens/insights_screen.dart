import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/core/widgets/elevated_card.dart';
import 'package:mobile/features/insights/presentation/providers/module_filter_provider.dart';
import 'package:mobile/features/insights/presentation/widgets/module_filter_dropdown.dart';
import 'package:mobile/features/activity/presentation/screens/activity_list_screen.dart';
import 'package:mobile/features/activity/presentation/providers/activity_provider.dart';
import 'package:mobile/core/constants/module_constants.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          title: Text(
            'Insights',
            style: AppTypography.sectionHeader.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.text,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: AppTypography.sectionHeader.copyWith(
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: AppTypography.sectionHeader,
            tabs: const [
              Tab(text: 'All Activities'),
              Tab(text: 'Analytics'),
            ],
          ),
          actions: const [
            ModuleFilterDropdown(),
          ],
        ),
        body: const TabBarView(
          children: [
            ActivityListScreen(),
            _AnalyticsTabContent(),
          ],
        ),
      ),
    );
  }
}

class _AnalyticsTabContent extends ConsumerWidget {
  const _AnalyticsTabContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the selected module filter
    final selectedModule = ref.watch(selectedModuleFilterProvider);

    // Watch activity stats filtered by module
    final statsAsync = ref.watch(
      activityStatsProvider(module: selectedModule),
    );

    return statsAsync.when(
      data: (stats) {
        if (stats.totalActivities == 0) {
          return EmptyState(
            icon: Icons.insights_outlined,
            title: 'No Statistics Yet',
            description: 'Complete activities to see your analytics here',
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.screenPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.md),

              // Overview Section
              Text(
                'Overview',
                style: AppTypography.sectionHeader.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: AppSpacing.md),

              // Stats Grid
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'Total Activities',
                      value: stats.totalActivities.toString(),
                      icon: Icons.calendar_today_outlined,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _StatCard(
                      label: 'Total Time',
                      value: _formatDuration(stats.totalDurationSeconds),
                      icon: Icons.timer_outlined,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.md),

              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'Average',
                      value: _formatDuration(stats.averageDurationSeconds),
                      icon: Icons.show_chart,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _StatCard(
                      label: 'Longest',
                      value: _formatDuration(stats.longestActivitySeconds),
                      icon: Icons.trending_up,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.lg),

              // Module Breakdown (if viewing all modules)
              if (selectedModule == null &&
                  stats.activitiesByModule.isNotEmpty) ...[
                Text(
                  'By Module',
                  style: AppTypography.sectionHeader.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: AppSpacing.md),
                ...stats.activitiesByModule.map((moduleCount) {
                  return _ModuleBreakdownRow(moduleCount: moduleCount);
                }),
                SizedBox(height: AppSpacing.lg),
              ],

              // Most Common Context
              if (stats.mostCommonContext != null) ...[
                Text(
                  'Most Common Context',
                  style: AppTypography.sectionHeader.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: AppSpacing.md),
                ElevatedCard(
                  elevation: CardElevation.elevated,
                  mode: CardElevationMode.shadow,
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        stats.mostCommonContext!.label,
                        style: AppTypography.caption.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      Text(
                        '${stats.mostCommonContext!.count} times',
                        style: AppTypography.caption.copyWith(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
      loading: () => const LoadingIndicator(),
      error: (error, stack) => EmptyState(
        icon: Icons.error_outline,
        title: 'Error Loading Analytics',
        description: error.toString(),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m';
    } else {
      return '${secs}s';
    }
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
    return ElevatedCard(
      elevation: CardElevation.elevated,
      mode: CardElevationMode.shadow,
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colored icon background
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.1),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          // Label
          Text(
            label.toUpperCase(),
            style: AppTypography.statLabel,
          ),
          SizedBox(height: AppSpacing.xs),
          // Value with enhanced typography
          Text(
            value,
            style: AppTypography.statValue.copyWith(fontSize: 28),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTypography.caption.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleBreakdownRow extends StatelessWidget {
  final moduleCount;

  const _ModuleBreakdownRow({required this.moduleCount});

  @override
  Widget build(BuildContext context) {
    final moduleName = ModuleConstants.getDisplayName(moduleCount.module);
    final moduleColor = _getModuleColor(moduleCount.module);

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: ElevatedCard(
        elevation: CardElevation.elevated,
        mode: CardElevationMode.shadow,
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            // Colored icon background
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: moduleColor.withOpacity(0.1),
              ),
              child: Icon(
                _getModuleIcon(moduleCount.module),
                size: 18,
                color: moduleColor,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                moduleName,
                style: AppTypography.caption.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              ),
            ),
            Text(
              '${moduleCount.count}',
              style: AppTypography.statValue.copyWith(
                fontSize: 20,
                color: moduleColor,
              ),
            ),
          ],
        ),
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
