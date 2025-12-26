import 'package:mobile/features/activity/data/models/activity_models.dart';
import 'package:mobile/features/activity/presentation/providers/activity_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_pagination_provider.g.dart';

@riverpod
class ActivityPagination extends _$ActivityPagination {
  static const int pageSize = 20;

  // Internal state for pagination
  int _currentPage = 1;
  bool _hasMore = true;
  List<ActivityItem> _allActivities = [];
  bool _isLoadingMore = false;

  // Store parameters for use in refresh/loadMore
  String? _module;
  DateTime? _fromDate;
  DateTime? _toDate;

  // Getters for external access
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  @override
  Future<List<ActivityItem>> build({
    String? module,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    // Store parameters
    _module = module;
    _fromDate = fromDate;
    _toDate = toDate;

    // Reset state when parameters change
    _currentPage = 1;
    _hasMore = true;
    _allActivities = [];
    _isLoadingMore = false;

    // Fetch first page
    final activities = await _fetchPage(1);

    // Check if there's more data
    if (activities.isEmpty || activities.length < pageSize) {
      _hasMore = false;
    }

    return activities;
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore || state.isLoading) return;

    _isLoadingMore = true;
    _currentPage++;

    try {
      final newActivities = await _fetchPage(_currentPage);

      if (newActivities.isEmpty || newActivities.length < pageSize) {
        _hasMore = false;
      }

      _allActivities.addAll(newActivities);
      state = AsyncValue.data(_allActivities);
    } catch (error, stackTrace) {
      // Revert page increment on error
      _currentPage--;
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> refresh() async {
    if (!ref.mounted) return;

    // Reset pagination state
    _currentPage = 1;
    _hasMore = true;
    _allActivities = [];
    _isLoadingMore = false;

    // Set loading state
    state = const AsyncValue.loading();

    // Fetch first page
    try {
      final activities = await _fetchPage(1);

      // Check if there's more data
      if (activities.isEmpty || activities.length < pageSize) {
        _hasMore = false;
      }

      if (ref.mounted) {
        state = AsyncValue.data(activities);
      }
    } catch (error, stackTrace) {
      if (ref.mounted) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }

  Future<List<ActivityItem>> _fetchPage(int page) async {
    final repository = ref.read(activityRepositoryProvider);
    final response = await repository.getActivities(
      module: _module,
      page: page,
      limit: pageSize,
      fromDate: _fromDate,
      toDate: _toDate,
    );

    if (!response.success) {
      throw Exception(response.message ?? 'Failed to fetch activities');
    }

    final activities = response.data.activities;

    // Update accumulated list if this is the first page
    if (page == 1) {
      _allActivities = activities;
    }

    return activities;
  }
}
