import 'package:mobile/core/models/api_response.dart';
import 'package:mobile/features/activity/data/datasources/activity_api_service.dart';
import 'package:mobile/features/activity/data/models/activity_models.dart';

class ActivityRepository {
  final ActivityApiService _apiService;

  ActivityRepository(this._apiService);

  /// Get activities with optional filters
  Future<ApiResponse<ActivityListResponse>> getActivities({
    String? module,
    int? page,
    int? limit,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    return _apiService.getActivities(
      module: module,
      page: page,
      limit: limit,
      fromDate: fromDate,
      toDate: toDate,
    );
  }

  /// Get activity statistics
  Future<ApiResponse<ActivityStatsResponse>> getStats({
    String? module,
  }) async {
    return _apiService.getStats(module: module);
  }

  /// Get a single activity by ID
  Future<ApiResponse<ActivityItem>> getActivityById(String id) async {
    return _apiService.getActivityById(id);
  }
}
