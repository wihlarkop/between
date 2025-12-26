import 'package:dio/dio.dart';
import 'package:mobile/core/models/api_response.dart';
import 'package:mobile/features/activity/data/models/activity_models.dart';

class ActivityApiService {
  final Dio _dio;

  ActivityApiService(this._dio);

  /// Get activities with optional filters
  Future<ApiResponse<ActivityListResponse>> getActivities({
    String? module,
    int? page,
    int? limit,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final queryParams = <String, dynamic>{};

    if (module != null) queryParams['module'] = module;
    if (page != null) queryParams['page'] = page;
    if (limit != null) queryParams['limit'] = limit;
    if (fromDate != null) queryParams['from_date'] = fromDate.toIso8601String();
    if (toDate != null) queryParams['to_date'] = toDate.toIso8601String();

    final response = await _dio.get(
      '/api/sessions',
      queryParameters: queryParams,
    );

    return ApiResponse<ActivityListResponse>.fromJson(
      response.data,
      (json) => ActivityListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Get activity statistics
  Future<ApiResponse<ActivityStatsResponse>> getStats({
    String? module,
  }) async {
    final queryParams = <String, dynamic>{};
    if (module != null) queryParams['module'] = module;

    final response = await _dio.get(
      '/api/sessions/stats',
      queryParameters: queryParams,
    );

    return ApiResponse<ActivityStatsResponse>.fromJson(
      response.data,
      (json) => ActivityStatsResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Get a single activity by ID
  Future<ApiResponse<ActivityItem>> getActivityById(String id) async {
    final response = await _dio.get('/api/sessions/$id');

    return ApiResponse<ActivityItem>.fromJson(
      response.data,
      (json) => ActivityItem.fromJson(json as Map<String, dynamic>),
    );
  }
}
