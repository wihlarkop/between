import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/config/theme/app_animations.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/features/history/presentation/providers/session_history_provider.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_state.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import '../widgets/session_list_item.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(sessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('History'), elevation: 0),
      body: historyAsync.when(
        data: (sessions) {
          if (sessions.isEmpty) {
            return EmptyState(
              icon: Icons.history_outlined,
              title: 'No silence sessions yet',
              description:
                  'Your silence sessions will appear here after you complete them.',
              action: ElevatedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Silence'),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(sessionHistoryProvider.notifier).refresh(),
            color: AppColors.primary,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 120),
              itemCount: sessions.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final session = sessions[index];
                return TweenAnimationBuilder<double>(
                  key: ValueKey(session.id),
                  duration: AppAnimations.medium,
                  curve: AppAnimations.gentle,
                  // Stagger animation based on index (max 10 items)
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    // Add delay for stagger effect
                    final delay = (index < 10 ? index : 10) * 50;
                    return FutureBuilder(
                      future: Future.delayed(Duration(milliseconds: delay)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return child!;
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                  child: SessionListItem(
                    session: session,
                    animationIndex: index,
                  ),
                );
              },
            ),
          );
        },
        loading: () => ListView.builder(
          itemCount: 6,
          padding: EdgeInsets.all(AppSpacing.md),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              children: [
                const SkeletonLoader(width: 48, height: 48, borderRadius: 24),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SkeletonLoader(width: 140, height: 16),
                      SizedBox(height: AppSpacing.xs),
                      const SkeletonLoader(width: 80, height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        error: (error, stack) => ErrorState(
          message: 'Could not load session history',
          onRetry: () => ref.read(sessionHistoryProvider.notifier).refresh(),
        ),
      ),
    );
  }
}
