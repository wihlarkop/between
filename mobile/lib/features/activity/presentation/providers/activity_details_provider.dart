import 'package:mobile/features/activity/data/models/activity_models.dart';
import 'package:mobile/features/activity/presentation/providers/activity_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_details_provider.g.dart';

@riverpod
Future<ActivityItem> activityDetails(Ref ref, String activityId) async {
  final repository = ref.watch(activityRepositoryProvider);

  // Directly fetch from API using dedicated endpoint (cache disabled for testing)
  final response = await repository.getActivityById(activityId);

  if (!response.success) {
    throw Exception(response.message ?? 'Failed to fetch activity details');
  }

  return response.data;
}
