import 'package:dio/dio.dart';
import 'package:mobile/core/constants/api_constants.dart';
import 'package:mobile/core/models/api_response.dart';
import 'package:mobile/features/decision/data/models/decision_models.dart';

class DecisionApiService {
  final Dio _dio;

  DecisionApiService(this._dio);

  /// Create a new decision
  Future<ApiResponse<DecisionModel>> createDecision(
    CreateDecisionRequest request,
  ) async {
    final response = await _dio.post(
      ApiConstants.decisions,
      data: request.toJson(),
    );
    return ApiResponse<DecisionModel>.fromJson(
      response.data,
      (json) => DecisionModel.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Get decisions with optional filters
  Future<ApiResponse<DecisionListResponse>> getDecisions({
    int? page,
    int? limit,
    String? status,
    int? contextCode,
    String? tags,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final response = await _dio.get(
      ApiConstants.decisions,
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (status != null) 'status': status,
        if (contextCode != null) 'context_code': contextCode,
        if (tags != null) 'tags': tags,
        if (fromDate != null) 'from_date': fromDate.toIso8601String(),
        if (toDate != null) 'to_date': toDate.toIso8601String(),
      },
    );
    return ApiResponse<DecisionListResponse>.fromJson(
      response.data,
      (json) => DecisionListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Get a single decision by ID
  Future<ApiResponse<DecisionModel>> getDecisionById(String id) async {
    final url = ApiConstants.decisionById.replaceAll('{id}', id);
    final response = await _dio.get(url);
    return ApiResponse<DecisionModel>.fromJson(
      response.data,
      (json) => DecisionModel.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Update a decision
  Future<ApiResponse<DecisionModel>> updateDecision(
    String id,
    UpdateDecisionRequest request,
  ) async {
    final url = ApiConstants.decisionById.replaceAll('{id}', id);
    final response = await _dio.put(url, data: request.toJson());
    return ApiResponse<DecisionModel>.fromJson(
      response.data,
      (json) => DecisionModel.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Delete a decision
  Future<ApiResponse<void>> deleteDecision(String id) async {
    final url = ApiConstants.decisionById.replaceAll('{id}', id);
    final response = await _dio.delete(url);
    return ApiResponse<void>.fromJson(
      response.data,
      (_) {},
    );
  }

  /// Get decision statistics
  Future<ApiResponse<DecisionStatsModel>> getStats() async {
    final response = await _dio.get(ApiConstants.decisionStats);
    return ApiResponse<DecisionStatsModel>.fromJson(
      response.data,
      (json) => DecisionStatsModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
