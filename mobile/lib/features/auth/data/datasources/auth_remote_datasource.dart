import 'package:dio/dio.dart';

import 'package:mobile/core/constants/api_constants.dart';
import 'package:mobile/core/models/api_response.dart';
import 'package:mobile/features/auth/data/models/auth_request.dart';
import 'package:mobile/features/auth/data/models/auth_response.dart';

class AuthApiService {
  final Dio _dio;

  AuthApiService(this._dio);

  Future<ApiResponse<AuthResponse>> register(RegisterRequest request) async {
    final response = await _dio.post(
      ApiConstants.register,
      data: request.toJson(),
    );
    return ApiResponse<AuthResponse>.fromJson(
      response.data,
      (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<AuthResponse>> login(LoginRequest request) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: request.toJson(),
    );
    return ApiResponse<AuthResponse>.fromJson(
      response.data,
      (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<AuthResponse>> refreshToken(
    RefreshTokenRequest request,
  ) async {
    final response = await _dio.post(
      ApiConstants.refreshToken,
      data: request.toJson(),
    );
    return ApiResponse<AuthResponse>.fromJson(
      response.data,
      (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
