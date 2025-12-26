import 'package:dio/dio.dart';

import 'package:mobile/core/constants/api_constants.dart';
import 'package:mobile/core/models/api_response.dart';
import 'package:mobile/features/stats/data/models/session_stats_model.dart';
import 'package:mobile/features/silence/data/models/silence_session_model.dart';

class SilenceApiService {
  final Dio _dio;

  SilenceApiService(this._dio);

  Future<ApiResponse<SilenceSessionModel>> startSession() async {
    final response = await _dio.post(ApiConstants.startSession);
    return ApiResponse<SilenceSessionModel>.fromJson(
      response.data,
      (json) => SilenceSessionModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<SilenceSessionModel>> endSession({
    String? terminationReason,
  }) async {
    final response = await _dio.post(
      ApiConstants.endSession,
      data: {'termination_reason': terminationReason},
    );
    return ApiResponse<SilenceSessionModel>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => SilenceSessionModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<SessionListResponse>> getSessions({
    int? limit,
    int? offset,
  }) async {
    final response = await _dio.get(
      ApiConstants.sessions,
      queryParameters: {
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
      },
    );
    return ApiResponse<SessionListResponse>.fromJson(
      response.data,
      (json) => SessionListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<AttachContextResponseModel>> attachContext(
    String sessionId,
    AttachContextRequest request,
  ) async {
    final url = ApiConstants.sessionContext.replaceAll('{id}', sessionId);
    final response = await _dio.put(url, data: request.toJson());
    return ApiResponse<AttachContextResponseModel>.fromJson(
      response.data,
      (json) =>
          AttachContextResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<SessionStatsModel>> getStats() async {
    final response = await _dio.get(ApiConstants.stats);
    return ApiResponse<SessionStatsModel>.fromJson(
      response.data,
      (json) => SessionStatsModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
