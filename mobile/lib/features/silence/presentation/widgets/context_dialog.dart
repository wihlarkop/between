import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile/config/theme/app_animations.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/utils/haptic_feedback.dart';
import 'package:mobile/features/silence/domain/entities/silence_context.dart';
import 'package:mobile/features/silence/presentation/providers/session_provider.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';

class ContextDialog extends ConsumerStatefulWidget {
  final String sessionId;

  const ContextDialog({
    super.key,
    required this.sessionId,
  });

  @override
  ConsumerState<ContextDialog> createState() => _ContextDialogState();
}

class _ContextDialogState extends ConsumerState<ContextDialog>
    with SingleTickerProviderStateMixin {
  List<SilenceContext> _contexts = [];
  SilenceContext? _selectedContext;
  final TextEditingController _noteController = TextEditingController();
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isSuccess = false;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup entry animation
    _animationController = AnimationController(
      duration: AppAnimations.medium,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: AppAnimations.dialogEntryScale,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: AppAnimations.gentle,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: AppAnimations.gentle,
    ));

    _animationController.forward();
    _fetchContexts();
  }

  Future<void> _fetchContexts() async {
    final contexts = await ref.read(sessionProvider.notifier).getContexts();
    if (mounted) {
      setState(() {
        _contexts = contexts;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_selectedContext == null || _isSaving) return;

    setState(() => _isSaving = true);
    await AppHaptics.medium();

    try {
      await ref.read(sessionProvider.notifier).attachContext(
            sessionId: widget.sessionId,
            contextCode: _selectedContext!.code,
            note: _noteController.text.trim().isNotEmpty
                ? _noteController.text.trim()
                : null,
          );

      if (mounted) {
        await AppHaptics.success();
        setState(() {
          _isSaving = false;
          _isSuccess = true;
        });

        // Show success animation for a moment
        await Future.delayed(const Duration(milliseconds: 800));

        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _skip() {
    AppHaptics.light();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final noteLength = _noteController.text.length;
    final maxNoteLength = AppConstants.maxContextNoteLength;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.xl),
          ),
          title: const Text('Add Context'),
          titleTextStyle: AppTypography.onboardingTitle.copyWith(
            fontSize: 20,
          ),
          contentPadding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          actionsPadding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: _isSuccess
                ? SizedBox(
                    height: 200,
                    child: Center(
                      child: TweenAnimationBuilder<double>(
                        duration: AppAnimations.medium,
                        curve: AppAnimations.gentle,
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Opacity(
                              opacity: value,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    size: 80,
                                    color: AppColors.success,
                                  ),
                                  SizedBox(height: AppSpacing.md),
                                  Text(
                                    'Saved',
                                    style: AppTypography.onboardingTitle.copyWith(
                                      color: AppColors.success,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : _isLoading
                    ? Padding(
                        padding: EdgeInsets.all(AppSpacing.xl),
                        child: const CenteredLoadingIndicator(
                          message: 'Loading contexts',
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How was the silence?',
                              style: AppTypography.emptyStateDescription,
                            ),

                            SizedBox(height: AppSpacing.md),

                            // Context chips with animation
                            AnimatedSwitcher(
                              duration: AppAnimations.medium,
                              child: _contexts.isEmpty
                                  ? Text(
                                      'No contexts available',
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.textDisabled,
                                      ),
                                    )
                                  : Wrap(
                                      spacing: AppSpacing.chipSpacing,
                                      runSpacing: AppSpacing.chipSpacing,
                                      children: _contexts.map((ctx) {
                                        final isSelected =
                                            _selectedContext?.code == ctx.code;
                                        return AnimatedContainer(
                                          duration: AppAnimations.fast,
                                          curve: AppAnimations.gentle,
                                          child: ChoiceChip(
                                            label: Text(ctx.label),
                                            selected: isSelected,
                                            onSelected: (selected) {
                                              AppHaptics.selection();
                                              setState(() {
                                                _selectedContext =
                                                    selected ? ctx : null;
                                              });
                                            },
                                            selectedColor: AppColors.primaryLight,
                                            backgroundColor: AppColors.surfaceVariant,
                                            labelStyle: TextStyle(
                                              color: isSelected
                                                  ? AppColors.text
                                                  : AppColors.textSecondary,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                            ),
                                            side: BorderSide(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : AppColors.border,
                                              width: isSelected ? 1.5 : 1,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                            ),

                            SizedBox(height: AppSpacing.lg),

                            // Note field with character counter
                            TextField(
                              controller: _noteController,
                              decoration: InputDecoration(
                                labelText: 'Note (Optional)',
                                hintText: 'Any thoughts?',
                                helperText: '$noteLength / $maxNoteLength',
                                helperStyle: AppTypography.helperText,
                                counterText: '',
                              ),
                              maxLines: 3,
                              maxLength: maxNoteLength,
                              onChanged: (_) => setState(() {}),
                            ),
                          ],
                        ),
                      ),
          ),
          actions: _isSuccess
              ? []
              : [
                  TextButton(
                    onPressed: _isSaving ? null : _skip,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                      ),
                    ),
                    child: const Text('Skip'),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    onPressed:
                        _selectedContext == null || _isSaving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: LoadingIndicator.small(),
                          )
                        : const Text('Save'),
                  ),
                ],
        ),
      ),
    );
  }
}
