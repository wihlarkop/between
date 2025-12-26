import 'package:dio/dio.dart';

import 'package:mobile/core/constants/api_constants.dart';
import 'package:mobile/core/models/api_response.dart';
import 'package:mobile/features/auth/data/models/profile_request.dart';
import 'package:mobile/features/auth/data/models/user_model.dart';

class ProfileApiService {
  final Dio _dio;

  ProfileApiService(this._dio);

  Future<ApiResponse<UserModel>> getProfile() async {
    final response = await _dio.get(ApiConstants.me);
    return ApiResponse<UserModel>.fromJson(
      response.data,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<void>> updateProfile(UpdateProfileRequest request) async {
    final response = await _dio.put(
      ApiConstants.updateProfile,
      data: request.toJson(),
    );

    // Handle 204 No Content or null response body
    if (response.data == null) {
      return ApiResponse<void>(
        data: null,
        success: true,
        statusCode: response.statusCode ?? 200,
        timestamp: DateTime.now().toIso8601String(),
        message: 'Profile updated successfully',
      );
    }

    return ApiResponse<void>.fromJson(
      response.data as Map<String, dynamic>,
      (_) => null,
    );
  }
}
