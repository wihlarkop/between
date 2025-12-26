import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/constants/module_constants.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/activity/presentation/providers/activity_details_provider.dart';
import 'package:mobile/features/silence/presentation/widgets/context_dialog.dart';
import 'package:mobile/features/activity/data/models/activity_models.dart';

class ActivityDetailsScreen extends ConsumerWidget {
  final String activityId;

  const ActivityDetailsScreen({
    super.key,
    required this.activityId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(activityDetailsProvider(activityId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Details'),
        actions: [
          activityAsync.maybeWhen(
            data: (activity) {
              // Only show edit button for silence module
              if (activity.module == ModuleConstants.silence) {
                return IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => _editContext(context, ref, activity),
                );
              }
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: activityAsync.when(
        data: (activity) => _buildDetails(context, ref, activity),
        loading: () => const LoadingIndicator(),
        error: (error, stack) => EmptyState(
          icon: Icons.error_outline,
          title: 'Error',
          description: error.toString(),
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context, WidgetRef ref, ActivityItem activity) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.screenPaddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module & Status Header
          _buildHeaderCard(activity),

          SizedBox(height: AppSpacing.lg),

          // Duration Section
          _buildDurationSection(activity),

          SizedBox(height: AppSpacing.lg),

          // Timestamps Section
          _buildTimestampsSection(activity),

          SizedBox(height: AppSpacing.lg),

          // Context Section (if exists)
          if (activity.contextLabel != null)
            _buildContextSection(context, ref, activity),

          if (activity.contextLabel != null) SizedBox(height: AppSpacing.lg),

          // Metadata Section (module-specific)
          if (activity.metadata != null && activity.metadata!.isNotEmpty)
            _buildMetadataSection(activity),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(ActivityItem activity) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Module icon
          Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
            child: Icon(
              _getModuleIcon(activity.module),
              size: 32,
              color: AppColors.primary,
            ),
          ),

          SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ModuleConstants.getDisplayName(activity.module),
                  style: AppTypography.sectionHeader.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  activity.endedAt != null ? 'Completed' : 'In Progress',
                  style: AppTypography.caption.copyWith(
                    color: activity.endedAt != null
                        ? AppColors.success
                        : AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSection(ActivityItem activity) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DURATION',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: AppSpacing.sm),

          if (activity.durationSeconds != null)
            Text(
              _formatDurationLong(activity.durationSeconds!),
              style: AppTypography.durationText.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            )
          else
            Text(
              'In Progress',
              style: AppTypography.durationText.copyWith(
                fontSize: 24,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimestampsSection(ActivityItem activity) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TIMELINE',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: AppSpacing.md),

          // Started at
          _buildTimestampRow(
            'Started',
            activity.startedAt,
            activity.startedAtLocal,
          ),

          if (activity.endedAt != null) ...[
            Divider(height: AppSpacing.lg * 2),
            _buildTimestampRow(
              'Ended',
              activity.endedAt!,
              activity.endedAtLocal!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimestampRow(String label, DateTime utc, String local) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          DateFormat('MMM d, yyyy • HH:mm:ss').format(utc),
          style: AppTypography.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(height: AppSpacing.xs / 2),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs / 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
          ),
          child: Text(
            'Local: $local',
            style: AppTypography.caption.copyWith(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContextSection(
    BuildContext context,
    WidgetRef ref,
    ActivityItem activity,
  ) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CONTEXT',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  letterSpacing: 1.5,
                ),
              ),

              // Edit button (only for silence module)
              if (activity.module == ModuleConstants.silence)
                TextButton.icon(
                  onPressed: () => _editContext(context, ref, activity),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),

          // Context label chip
          Chip(
            label: Text(activity.contextLabel!),
            backgroundColor: AppColors.primaryLight,
            side: BorderSide(color: AppColors.primary),
          ),

          // Context note (if exists)
          if (activity.metadata?['context_note'] != null) ...[
            SizedBox(height: AppSpacing.md),
            Text(
              'Note:',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              activity.metadata!['context_note'],
              style: AppTypography.caption.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetadataSection(ActivityItem activity) {
    // Filter out context_note (already displayed in context section)
    final displayMetadata = Map<String, dynamic>.from(activity.metadata!)
      ..remove('context_note');

    if (displayMetadata.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ADDITIONAL INFORMATION',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: AppSpacing.md),

          ...displayMetadata.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatMetadataKey(entry.key),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    entry.value.toString(),
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _editContext(BuildContext context, WidgetRef ref, ActivityItem activity) {
    if (activity.module == ModuleConstants.silence) {
      // Show silence context dialog
      showDialog(
        context: context,
        builder: (_) => ContextDialog(sessionId: activity.moduleSessionId),
      ).then((updated) {
        if (updated == true) {
          // Invalidate provider to refetch updated activity
          ref.invalidate(activityDetailsProvider(activityId));
        }
      });
    } else {
      // For other modules, show not editable message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This activity cannot be edited'),
        ),
      );
    }
  }

  String _formatMetadataKey(String key) {
    // Convert snake_case to Title Case
    return key.split('_').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  String _formatDurationLong(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    final parts = <String>[];
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (secs > 0 || parts.isEmpty) parts.add('${secs}s');

    return parts.join(' ');
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
}
