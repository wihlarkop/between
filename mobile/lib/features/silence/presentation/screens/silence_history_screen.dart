import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_state.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/history/presentation/providers/session_history_provider.dart';
import 'package:mobile/features/silence/presentation/providers/silence_stats_provider.dart';
import 'package:mobile/features/silence/domain/entities/silence_session.dart';
import 'package:intl/intl.dart';

class SilenceHistoryScreen extends ConsumerWidget {
  const SilenceHistoryScreen({super.key});

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m ${secs}s';
    } else if (minutes > 0) {
      return '${minutes}m ${secs}s';
    } else {
      return '${secs}s';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today ${DateFormat('HH:mm').format(dateTime)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${DateFormat('HH:mm').format(dateTime)}';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE HH:mm').format(dateTime);
    }
    return DateFormat('MMM d, HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionHistoryProvider);
    final statsAsync = ref.watch(silenceStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Silence History',
          style: AppTypography.pageTitle.copyWith(
            color: AppColors.text,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(sessionHistoryProvider);
              ref.invalidate(silenceStatsProvider);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(sessionHistoryProvider);
          ref.invalidate(silenceStatsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(AppSpacing.screenPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),

              // Stats Card
              statsAsync.when(
                data: (stats) => Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            label: 'Total Sessions',
                            value: stats.totalSessions.toString(),
                            icon: Icons.all_inclusive,
                          ),
                          _StatItem(
                            label: 'Total Duration',
                            value: _formatDuration(stats.totalSilenceSeconds),
                            icon: Icons.timer,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            label: 'Longest',
                            value: stats.longestSessionSeconds != null
                                ? _formatDuration(stats.longestSessionSeconds!)
                                : 'N/A',
                            icon: Icons.trending_up,
                          ),
                          _StatItem(
                            label: 'Avg Duration',
                            value: _formatDuration(stats.averageDurationSeconds.round()),
                            icon: Icons.analytics,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                loading: () => const SizedBox(
                  height: 150,
                  child: LoadingIndicator(),
                ),
                error: (error, _) => const SizedBox.shrink(),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Sessions List Header
              Text(
                'Recent Sessions',
                style: AppTypography.sectionHeader.copyWith(
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Sessions List
              sessionsAsync.when(
                data: (sessions) {
                  if (sessions.isEmpty) {
                    return const EmptyState(
                      icon: Icons.self_improvement,
                      title: 'No Sessions Yet',
                      description: 'Start a silence session to see your history here',
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sessions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      final session = sessions[index];
                      return _SessionCard(
                        session: session,
                        formatDuration: _formatDuration,
                        formatDateTime: _formatDateTime,
                      );
                    },
                  );
                },
                loading: () => const LoadingIndicator(),
                error: (error, stack) => ErrorState(
                  message: 'Error loading sessions: ${error.toString()}',
                  onRetry: () {
                    ref.invalidate(sessionHistoryProvider);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTypography.pageTitle.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  final SilenceSession session;
  final String Function(int) formatDuration;
  final String Function(DateTime) formatDateTime;

  const _SessionCard({
    required this.session,
    required this.formatDuration,
    required this.formatDateTime,
  });

  @override
  Widget build(BuildContext context) {
    final hasEnded = session.endedAt != null;
    final duration = session.durationSeconds ?? 0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasEnded ? Icons.check_circle : Icons.play_circle,
                color: hasEnded ? AppColors.success : AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  hasEnded ? formatDuration(duration) : 'In Progress',
                  style: AppTypography.onboardingBody.copyWith(
                    color: AppColors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (hasEnded)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                  ),
                  child: Text(
                    'Completed',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                formatDateTime(session.startedAt),
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (session.endedAt != null) ...[
                Text(
                  ' - ',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  DateFormat('HH:mm').format(session.endedAt!),
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
          if (session.contextLabel != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Icon(
                  Icons.label,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  session.contextLabel!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
          if (session.contextNote != null && session.contextNote!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              session.contextNote!,
              style: AppTypography.caption.copyWith(
                color: AppColors.text,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
