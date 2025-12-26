import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/utils/haptic_feedback.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/context/domain/entities/context.dart' as domain;
import 'package:mobile/features/context/presentation/providers/context_provider.dart';
import 'package:mobile/features/decision/presentation/providers/decision_provider.dart';

class EditDecisionScreen extends ConsumerStatefulWidget {
  final String decisionId;

  const EditDecisionScreen({
    super.key,
    required this.decisionId,
  });

  @override
  ConsumerState<EditDecisionScreen> createState() =>
      _EditDecisionScreenState();
}

class _EditDecisionScreenState extends ConsumerState<EditDecisionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _reasonController;
  late TextEditingController _expectationController;
  late TextEditingController _actualResultController;
  late TextEditingController _learningsController;
  final TextEditingController _tagInputController = TextEditingController();

  domain.Context? _selectedContext;
  List<String> _tags = [];
  bool _isLoading = false;
  bool _controllersInitialized = false;

  @override
  void dispose() {
    if (_controllersInitialized) {
      _titleController.dispose();
      _reasonController.dispose();
      _expectationController.dispose();
      _actualResultController.dispose();
      _learningsController.dispose();
    }
    _tagInputController.dispose();
    super.dispose();
  }

  void _initializeControllers(decision) {
    if (!_controllersInitialized) {
      _titleController = TextEditingController(text: decision.title);
      _reasonController = TextEditingController(text: decision.reason ?? '');
      _expectationController =
          TextEditingController(text: decision.expectation ?? '');
      _actualResultController =
          TextEditingController(text: decision.actualResult ?? '');
      _learningsController =
          TextEditingController(text: decision.learnings ?? '');
      _tags = List<String>.from(decision.tags ?? []);
      _controllersInitialized = true;
    }
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await AppHaptics.medium();

    final decision =
        await ref.read(decisionProvider.notifier).updateDecision(
              id: widget.decisionId,
              title: _titleController.text.trim(),
              reason: _reasonController.text.trim().isNotEmpty
                  ? _reasonController.text.trim()
                  : null,
              expectation: _expectationController.text.trim().isNotEmpty
                  ? _expectationController.text.trim()
                  : null,
              actualResult: _actualResultController.text.trim().isNotEmpty
                  ? _actualResultController.text.trim()
                  : null,
              learnings: _learningsController.text.trim().isNotEmpty
                  ? _learningsController.text.trim()
                  : null,
              contextCode: _selectedContext?.code,
              tags: _tags.isNotEmpty ? _tags : null,
            );

    setState(() => _isLoading = false);

    if (decision != null && mounted) {
      await AppHaptics.success();
      ref.invalidate(decisionDetailsProvider(widget.decisionId));
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Decision updated successfully')),
      );
    } else if (mounted) {
      final error = ref.read(decisionProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Failed to update decision'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _addTag() {
    final tag = _tagInputController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagInputController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    final decisionAsync = ref.watch(decisionDetailsProvider(widget.decisionId));
    final contextsAsync = ref.watch(contextsProvider(module: 'decision'));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Edit Decision'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: decisionAsync.when(
        data: (decision) {
          _initializeControllers(decision);

          // Set selected context if not already set
          if (_selectedContext == null && decision.contextCode != null) {
            contextsAsync.whenData((contexts) {
              final context = contexts.firstWhere(
                (c) => c.code == decision.contextCode,
                orElse: () => contexts.first,
              );
              if (mounted) {
                setState(() {
                  _selectedContext = context;
                });
              }
            });
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(AppSpacing.screenPaddingHorizontal),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Decision type badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: decision.statusColor.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSmall),
                      border: Border.all(
                        color: decision.statusColor.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      decision.statusDisplayName,
                      style: AppTypography.caption.copyWith(
                        color: decision.statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // DECISION DETAILS section
                  Text('DECISION DETAILS', style: AppTypography.statLabel),
                  const SizedBox(height: AppSpacing.md),

                  // Title field
                  _buildTextField(
                    label: 'Title',
                    controller: _titleController,
                    hint: 'What decision are you making?',
                    maxLength: 200,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      if (val.trim().length < 1 || val.trim().length > 200) {
                        return 'Title must be between 1 and 200 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Reason field (Pending + Completed only)
                  if (decision.isPending || decision.isCompleted) ...[
                    _buildTextField(
                      label: 'Why? (Optional)',
                      controller: _reasonController,
                      hint: 'Reason for this decision',
                      maxLength: 1000,
                      maxLines: 3,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  // Expectation field (Pending + Completed only)
                  if (decision.isPending || decision.isCompleted) ...[
                    _buildTextField(
                      label: 'Expected Outcome (Optional)',
                      controller: _expectationController,
                      hint: 'What do you expect to happen?',
                      maxLength: 1000,
                      maxLines: 3,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  // Actual Result field (Completed + Quick only)
                  if (decision.isCompleted || decision.isQuick) ...[
                    _buildTextField(
                      label: 'Actual Result (Optional)',
                      controller: _actualResultController,
                      hint: 'What actually happened?',
                      maxLength: 1000,
                      maxLines: 3,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  // Learnings field (Completed + Quick only)
                  if (decision.isCompleted || decision.isQuick) ...[
                    _buildTextField(
                      label: 'Learnings (Optional)',
                      controller: _learningsController,
                      hint: 'What did you learn?',
                      maxLength: 1000,
                      maxLines: 3,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  const SizedBox(height: AppSpacing.lg),

                  // CONTEXT section
                  Text('CONTEXT (OPTIONAL)', style: AppTypography.statLabel),
                  const SizedBox(height: AppSpacing.md),
                  contextsAsync.when(
                    data: (contexts) => Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: contexts.map((context) {
                        final isSelected = _selectedContext?.code == context.code;
                        return FilterChip(
                          label: Text(context.label),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedContext = selected ? context : null;
                            });
                          },
                          backgroundColor: AppColors.background,
                          selectedColor: AppColors.primary.withOpacity(0.2),
                          checkmarkColor: AppColors.primary,
                          labelStyle: AppTypography.caption.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.text,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                          ),
                        );
                      }).toList(),
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // TAGS section
                  Text('TAGS (OPTIONAL)', style: AppTypography.statLabel),
                  const SizedBox(height: AppSpacing.md),

                  // Tag input field
                  TextField(
                    controller: _tagInputController,
                    style: AppTypography.onboardingBody
                        .copyWith(color: AppColors.text),
                    decoration: InputDecoration(
                      hintText: 'Enter tag and press enter',
                      hintStyle: AppTypography.onboardingBody.copyWith(
                        color: AppColors.textDisabled,
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSmall),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                    onSubmitted: (_) => _addTag(),
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  // Display tags
                  if (_tags.isNotEmpty)
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: _tags.map((tag) {
                        return Chip(
                          label: Text(tag),
                          onDeleted: () => _removeTag(tag),
                          deleteIcon: const Icon(Icons.close, size: 16),
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          labelStyle: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                          ),
                          side: BorderSide(
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: AppSpacing.xl),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSpacing.md),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSmall),
                        ),
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
                          : Text(
                              'Save Changes',
                              style: AppTypography.onboardingBody.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          );
        },
        loading: () => const LoadingIndicator(),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error loading decision',
                style: AppTypography.pageTitle.copyWith(color: AppColors.text),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                error.toString(),
                style: AppTypography.caption
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int? maxLength,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          style: AppTypography.onboardingBody.copyWith(color: AppColors.text),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.onboardingBody.copyWith(
              color: AppColors.textDisabled,
            ),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            counterStyle: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          maxLength: maxLength,
          maxLines: maxLines,
          textCapitalization: TextCapitalization.sentences,
          validator: validator,
        ),
      ],
    );
  }
}
