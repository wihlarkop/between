import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/features/context/domain/entities/context.dart' as domain;
import 'package:mobile/features/context/presentation/providers/context_provider.dart';
import 'package:mobile/features/decision/presentation/providers/decision_provider.dart';

enum DecisionType {
  pending,
  quick,
}

class CreateDecisionDialog extends ConsumerStatefulWidget {
  const CreateDecisionDialog({super.key});

  @override
  ConsumerState<CreateDecisionDialog> createState() =>
      _CreateDecisionDialogState();
}

class _CreateDecisionDialogState extends ConsumerState<CreateDecisionDialog> {
  final _titleController = TextEditingController();
  final _reasonController = TextEditingController();
  final _expectationController = TextEditingController();
  bool _isLoading = false;
  domain.Context? _selectedContext;
  DecisionType _decisionType = DecisionType.pending;

  @override
  void dispose() {
    _titleController.dispose();
    _reasonController.dispose();
    _expectationController.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Backend requires at least one date (decided_at or completed_at)
    // Pending = decision with decided_at (track outcome later)
    // Quick = decision with completed_at (immediate completion)
    final isPending = _decisionType == DecisionType.pending;
    final decision =
        await ref.read(decisionProvider.notifier).createDecision(
              title: _titleController.text.trim(),
              reason: _reasonController.text.trim().isNotEmpty
                  ? _reasonController.text.trim()
                  : null,
              expectation: _expectationController.text.trim().isNotEmpty
                  ? _expectationController.text.trim()
                  : null,
              decidedAt: isPending ? DateTime.now() : null,
              completedAt: isPending ? null : DateTime.now(),
              contextCode: _selectedContext?.code,
            );

    setState(() => _isLoading = false);

    if (decision != null && mounted) {
      Navigator.of(context).pop(decision);
    }
  }

  @override
  Widget build(BuildContext context) {
    final contextsAsync = ref.watch(contextsProvider(module: 'decision'));

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'New Decision',
                    style: AppTypography.pageTitle.copyWith(
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // Title field
              Text(
                'Title',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              TextField(
                controller: _titleController,
                style:
                    AppTypography.onboardingBody.copyWith(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: 'What decision are you making?',
                  hintStyle: AppTypography.onboardingBody.copyWith(
                    color: AppColors.textDisabled,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                maxLength: 200,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: AppSpacing.md),

              // Reason field
              Text(
                'Why? (Optional)',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              TextField(
                controller: _reasonController,
                style:
                    AppTypography.onboardingBody.copyWith(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: 'Why are you making this decision?',
                  hintStyle: AppTypography.onboardingBody.copyWith(
                    color: AppColors.textDisabled,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                maxLines: 3,
                maxLength: 1000,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: AppSpacing.md),

              // Expectation field
              Text(
                'Expected Outcome (Optional)',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              TextField(
                controller: _expectationController,
                style:
                    AppTypography.onboardingBody.copyWith(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: 'What do you expect to happen?',
                  hintStyle: AppTypography.onboardingBody.copyWith(
                    color: AppColors.textDisabled,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                maxLines: 3,
                maxLength: 1000,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: AppSpacing.md),

              // Context selector
              Text(
                'Context (Optional)',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              contextsAsync.when(
                data: (contexts) => Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: contexts
                      .map((ctx) {
                        final isSelected = _selectedContext?.code == ctx.code;
                        return FilterChip(
                          label: Text(ctx.label),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedContext = selected ? ctx : null;
                            });
                          },
                          backgroundColor: AppColors.background,
                          selectedColor: AppColors.primary.withValues(alpha: 0.2),
                          labelStyle: AppTypography.caption.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          checkmarkColor: AppColors.primary,
                        );
                      })
                      .toList(),
                ),
                loading: () => const SizedBox(
                  height: 32,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                error: (_, __) => const SizedBox.shrink(),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Decision type selector
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Decision Type',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SegmentedButton<DecisionType>(
                    segments: const [
                      ButtonSegment<DecisionType>(
                        value: DecisionType.pending,
                        label: Text('Pending'),
                        icon: Icon(Icons.schedule, size: 18),
                      ),
                      ButtonSegment<DecisionType>(
                        value: DecisionType.quick,
                        label: Text('Quick'),
                        icon: Icon(Icons.flash_on, size: 18),
                      ),
                    ],
                    selected: {_decisionType},
                    onSelectionChanged: (Set<DecisionType> selected) {
                      setState(() => _decisionType = selected.first);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.primary.withValues(alpha: 0.2);
                        }
                        return AppColors.background;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.primary;
                        }
                        return AppColors.textSecondary;
                      }),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _decisionType == DecisionType.pending
                        ? 'Track outcome later - decision will be pending until you record the result'
                        : 'Quick decision - mark as complete immediately',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textDisabled,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed:
                          _isLoading ? null : () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: AppTypography.onboardingBody.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleCreate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
