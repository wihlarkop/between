import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/features/decision/domain/entities/decision.dart';
import 'package:mobile/features/decision/presentation/providers/decision_provider.dart';

class DecisionDetailScreen extends ConsumerStatefulWidget {
  final String decisionId;

  const DecisionDetailScreen({super.key, required this.decisionId});

  @override
  ConsumerState<DecisionDetailScreen> createState() =>
      _DecisionDetailScreenState();
}

class _DecisionDetailScreenState extends ConsumerState<DecisionDetailScreen> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final decisionAsync = ref.watch(decisionDetailsProvider(widget.decisionId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Decision Details'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'edit') {
                context.push('/decision/${widget.decisionId}/edit');
              } else if (value == 'delete') {
                final confirm = await _showDeleteConfirmation(context);
                if (confirm == true) {
                  setState(() => _isDeleting = true);
                  final success = await ref
                      .read(decisionProvider.notifier)
                      .deleteDecision(widget.decisionId);
                  setState(() => _isDeleting = false);
                  if (success && mounted) {
                    context.pop();
                  }
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, color: AppColors.text),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Edit'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: AppColors.error),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Delete', style: TextStyle(color: AppColors.error)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isDeleting
          ? const Center(child: CircularProgressIndicator())
          : decisionAsync.when(
              data: (decision) => _buildContent(context, ref, decision),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: AppColors.error),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      error.toString(),
                      style: AppTypography.onboardingBody.copyWith(
                        color: AppColors.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TextButton.icon(
                      onPressed: () =>
                          ref.invalidate(decisionDetailsProvider(widget.decisionId)),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, Decision decision) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  decision.title,
                  style: AppTypography.pageTitle.copyWith(
                    color: AppColors.text,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              _buildStatusBadge(decision),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Context
          if (decision.contextLabel != null) ...[
            _buildInfoRow(
              icon: Icons.label_outline,
              label: 'Context',
              value: decision.contextLabel!,
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Dates
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Created',
            value: _formatDateTime(decision.createdAt),
          ),
          if (decision.decidedAt != null) ...[
            const SizedBox(height: AppSpacing.md),
            _buildInfoRow(
              icon: Icons.check_circle_outline,
              label: 'Decided',
              value: _formatDateTime(decision.decidedAt!),
            ),
          ],
          if (decision.completedAt != null) ...[
            const SizedBox(height: AppSpacing.md),
            _buildInfoRow(
              icon: Icons.done_all,
              label: 'Completed',
              value: _formatDateTime(decision.completedAt!),
            ),
          ],

          const SizedBox(height: AppSpacing.xl),
          const Divider(color: AppColors.border),
          const SizedBox(height: AppSpacing.xl),

          // Reason
          if (decision.reason != null && decision.reason!.isNotEmpty) ...[
            _buildSection(
              title: 'Why I Made This Decision',
              content: decision.reason!,
              icon: Icons.psychology_outlined,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          // Expectation
          if (decision.expectation != null &&
              decision.expectation!.isNotEmpty) ...[
            _buildSection(
              title: 'Expected Outcome',
              content: decision.expectation!,
              icon: Icons.lightbulb_outline,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          // Actual Result (if completed)
          if (decision.actualResult != null &&
              decision.actualResult!.isNotEmpty) ...[
            _buildSection(
              title: 'Actual Result',
              content: decision.actualResult!,
              icon: Icons.fact_check_outlined,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          // Learnings (if completed)
          if (decision.learnings != null &&
              decision.learnings!.isNotEmpty) ...[
            _buildSection(
              title: 'What I Learned',
              content: decision.learnings!,
              icon: Icons.school_outlined,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          // Tags
          if (decision.tags != null && decision.tags!.isNotEmpty) ...[
            Text(
              'Tags',
              style: AppTypography.sectionHeader.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: decision.tags!
                  .map((tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                        ),
                        child: Text(
                          tag,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          // Action buttons based on status
          _buildActionButtons(context, ref, decision),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(Decision decision) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: decision.statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
      ),
      child: Text(
        decision.statusDisplayName,
        style: AppTypography.contextBadge.copyWith(
          color: decision.statusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.sm),
        Text(
          '$label: ',
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTypography.onboardingBody.copyWith(
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(
              title,
              style: AppTypography.sectionHeader.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            content,
            style: AppTypography.onboardingBody.copyWith(
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    Decision decision,
  ) {
    if (decision.isCompleted) {
      return const SizedBox.shrink();
    }

    if (decision.isPending) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _showCompleteDialog(context, ref, decision),
          icon: const Icon(Icons.check),
          label: const Text('Complete Decision'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void _showCompleteDialog(
    BuildContext context,
    WidgetRef ref,
    Decision decision,
  ) {
    final actualResultController = TextEditingController();
    final learningsController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Complete Decision',
          style: AppTypography.pageTitle.copyWith(color: AppColors.text),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What was the actual result?',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              TextField(
                controller: actualResultController,
                style: AppTypography.onboardingBody.copyWith(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: 'Describe the outcome...',
                  hintStyle: AppTypography.onboardingBody.copyWith(
                    color: AppColors.textDisabled,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
                maxLength: 1000,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'What did you learn? (Optional)',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              TextField(
                controller: learningsController,
                style: AppTypography.onboardingBody.copyWith(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: 'Share your insights...',
                  hintStyle: AppTypography.onboardingBody.copyWith(
                    color: AppColors.textDisabled,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
                maxLength: 1000,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: AppTypography.onboardingBody.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await ref.read(decisionProvider.notifier).completeDecision(
                    id: decision.id,
                    actualResult: actualResultController.text.trim().isNotEmpty
                        ? actualResultController.text.trim()
                        : null,
                    learnings: learningsController.text.trim().isNotEmpty
                        ? learningsController.text.trim()
                        : null,
                  );
              ref.invalidate(decisionDetailsProvider(decision.id));
            },
            child: Text(
              'Complete',
              style: AppTypography.onboardingBody.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Delete Decision',
          style: AppTypography.pageTitle.copyWith(color: AppColors.text),
        ),
        content: Text(
          'Are you sure you want to delete this decision? This action cannot be undone.',
          style: AppTypography.onboardingBody.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: AppTypography.onboardingBody.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: AppTypography.onboardingBody.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, y at h:mm a').format(dateTime);
  }
}
