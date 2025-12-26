import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/features/decision/presentation/providers/decision_provider.dart';
import 'package:mobile/features/decision/presentation/widgets/create_decision_dialog.dart';
import 'package:mobile/features/decision/presentation/widgets/decision_list_item.dart';

class DecisionScreen extends ConsumerWidget {
  const DecisionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decisionState = ref.watch(decisionProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Decisions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_outlined),
            onPressed: () => context.push('/decision/stats'),
            tooltip: 'Statistics',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter tabs
          _buildFilterTabs(context, ref, decisionState.filter),

          // Content
          Expanded(
            child: _buildContent(context, ref, decisionState),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterTabs(
    BuildContext context,
    WidgetRef ref,
    DecisionFilter currentFilter,
  ) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: DecisionFilter.values.map((filter) {
            final isSelected = currentFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: FilterChip(
                label: Text(_getFilterLabel(filter)),
                selected: isSelected,
                onSelected: (_) {
                  ref.read(decisionProvider.notifier).setFilter(filter);
                },
                backgroundColor: AppColors.background,
                selectedColor: AppColors.primary.withValues(alpha: 0.2),
                labelStyle: AppTypography.caption.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                checkmarkColor: AppColors.primary,
                showCheckmark: false,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getFilterLabel(DecisionFilter filter) {
    switch (filter) {
      case DecisionFilter.all:
        return 'All';
      case DecisionFilter.pending:
        return 'Pending';
      case DecisionFilter.completed:
        return 'Completed';
      case DecisionFilter.quick:
        return 'Quick';
    }
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    DecisionListState state,
  ) {
    if (state.isLoading && state.decisions.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null && state.decisions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              state.error!,
              style: AppTypography.onboardingBody.copyWith(color: AppColors.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            TextButton.icon(
              onPressed: () {
                ref.read(decisionProvider.notifier).refresh();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (state.decisions.isEmpty) {
      return const EmptyState(
        icon: Icons.lightbulb_outline,
        title: 'No Decisions',
        description: 'Start tracking your decisions by tapping the + button',
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(decisionProvider.notifier).refresh(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            final metrics = notification.metrics;
            if (metrics.pixels >= metrics.maxScrollExtent - 200) {
              ref.read(decisionProvider.notifier).loadMore();
            }
          }
          return false;
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: state.decisions.length + (state.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= state.decisions.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }

            final decision = state.decisions[index];
            return DecisionListItem(
              decision: decision,
              onTap: () => context.push('/decision/${decision.id}'),
            );
          },
        ),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CreateDecisionDialog(),
    );
  }
}
