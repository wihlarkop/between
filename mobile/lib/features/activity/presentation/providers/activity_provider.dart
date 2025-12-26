import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/features/activity/data/datasources/activity_api_service.dart';
import 'package:mobile/features/activity/data/models/activity_models.dart';
import 'package:mobile/features/activity/domain/repositories/activity_repository.dart';
import 'package:mobile/features/auth/presentation/providers/providers.dart';

part 'activity_provider.g.dart';

/// Activity API service provider
@riverpod
ActivityApiService activityApiService(Ref ref) {
  final dio = ref.read(dioProvider);
  return ActivityApiService(dio);
}

/// Activity repository provider
@riverpod
ActivityRepository activityRepository(Ref ref) {
  return ActivityRepository(ref.read(activityApiServiceProvider));
}

/// Provider for recent activities (limit 3)
@riverpod
Future<List<ActivityItem>> recentActivities(Ref ref) async {
  final repository = ref.watch(activityRepositoryProvider);

  final response = await repository.getActivities(
    limit: 3,
  );

  if (!response.success) {
    throw Exception(response.message ?? 'Failed to fetch recent activities');
  }

  return response.data.activities;
}

/// Provider for activities with filters
@riverpod
class ActivityList extends _$ActivityList {
  @override
  Future<List<ActivityItem>> build({
    String? module,
    int page = 1,
    int limit = 20,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final repository = ref.watch(activityRepositoryProvider);

    final response = await repository.getActivities(
      module: module,
      page: page,
      limit: limit,
      fromDate: fromDate,
      toDate: toDate,
    );

    if (!response.success) {
      throw Exception(response.message ?? 'Failed to fetch activities');
    }

    return response.data.activities;
  }

  /// Refresh the activity list
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build(
          module: module,
          page: page,
          limit: limit,
          fromDate: fromDate,
          toDate: toDate,
        ));
  }
}

/// Provider for activity statistics
@riverpod
Future<ActivityStatsResponse> activityStats(
  Ref ref, {
  String? module,
}) async {
  final repository = ref.watch(activityRepositoryProvider);

  final response = await repository.getStats(
    module: module,
  );

  if (!response.success) {
    throw Exception(response.message ?? 'Failed to fetch statistics');
  }

  return response.data;
}
