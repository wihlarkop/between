import 'package:dio/dio.dart';
import 'package:mobile/core/constants/api_constants.dart';
import 'package:mobile/core/models/api_response.dart';
import 'package:mobile/features/context/data/models/context_model.dart';

/// Remote data source for context operations
class ContextRemoteDataSource {
  final Dio _dio;

  ContextRemoteDataSource(this._dio);

  /// Get all contexts, optionally filtered by module
  Future<ApiResponse<ContextListResponse>> getContexts({
    String? module,
  }) async {
    final response = await _dio.get(
      ApiConstants.contexts,
      queryParameters: {
        if (module != null) 'module': module,
      },
    );
    return ApiResponse<ContextListResponse>.fromJson(
      response.data,
      (json) => ContextListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
