import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/features/activity/presentation/providers/activity_filters_provider.dart';
import 'package:mobile/features/activity/presentation/providers/activity_pagination_provider.dart';
import 'package:mobile/features/activity/presentation/widgets/activity_filter_bar.dart';
import 'package:mobile/features/activity/presentation/widgets/activity_list_item.dart';
import 'package:mobile/features/activity/presentation/widgets/pagination_loader.dart';
import 'package:mobile/features/insights/presentation/providers/module_filter_provider.dart';

class ActivityListScreen extends ConsumerStatefulWidget {
  const ActivityListScreen({super.key});

  @override
  ConsumerState<ActivityListScreen> createState() =>
      _ActivityListScreenState();
}

class _ActivityListScreenState extends ConsumerState<ActivityListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isNearBottom && !_isLoadingMore) {
      _loadMore();
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // Load when 90% scrolled
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final selectedModule = ref.read(selectedModuleFilterProvider);
      final dateRange = ref.read(activityDateRangeFilterProvider);

      await ref
          .read(
            activityPaginationProvider(
              module: selectedModule,
              fromDate: dateRange?.start,
              toDate: dateRange?.end,
            ).notifier,
          )
          .loadMore();
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  Future<void> _refresh() async {
    final selectedModule = ref.read(selectedModuleFilterProvider);
    final dateRange = ref.read(activityDateRangeFilterProvider);

    await ref
        .read(
          activityPaginationProvider(
            module: selectedModule,
            fromDate: dateRange?.start,
            toDate: dateRange?.end,
          ).notifier,
        )
        .refresh();
  }

  @override
  Widget build(BuildContext context) {
    final selectedModule = ref.watch(selectedModuleFilterProvider);
    final dateRange = ref.watch(activityDateRangeFilterProvider);

    final activitiesAsync = ref.watch(
      activityPaginationProvider(
        module: selectedModule,
        fromDate: dateRange?.start,
        toDate: dateRange?.end,
      ),
    );

    // Get hasMore from provider notifier
    final hasMore = activitiesAsync.maybeWhen(
      data: (_) {
        final notifier = ref.read(
          activityPaginationProvider(
            module: selectedModule,
            fromDate: dateRange?.start,
            toDate: dateRange?.end,
          ).notifier,
        );
        return notifier.hasMore;
      },
      orElse: () => false,
    );

    return Column(
      children: [
        const ActivityFilterBar(),
        Expanded(
          child: activitiesAsync.when(
            data: (activities) {
              if (activities.isEmpty) {
                return EmptyState(
                  icon: Icons.inbox_outlined,
                  title: 'No Activities',
                  description: selectedModule != null || dateRange != null
                      ? 'No activities match your filters'
                      : 'No activities yet. Start a session to see your activities here.',
                );
              }

              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  itemCount: activities.length + 1, // +1 for loader
                  itemBuilder: (context, index) {
                    if (index == activities.length) {
                      // Pagination loader at bottom
                      return PaginationLoader(hasMore: hasMore);
                    }

                    final activity = activities[index];
                    return ActivityListItem(
                      activity: activity,
                      onTap: () => context.push('/activity/${activity.id}'),
                    );
                  },
                ),
              );
            },
            loading: () => const LoadingIndicator(),
            error: (error, stack) => EmptyState(
              icon: Icons.error_outline,
              title: 'Error Loading Activities',
              description: error.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
