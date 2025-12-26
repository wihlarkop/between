import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:mobile/core/error/exceptions.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mobile/features/auth/data/models/auth_request.dart';
import 'package:mobile/features/auth/data/models/auth_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _apiService;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthApiService apiService,
    required AuthLocalDataSource localDataSource,
  }) : _apiService = apiService,
       _localDataSource = localDataSource;

  @override
  Future<Either<Failure, AuthResponse>> register({
    required String fullname,
    required String email,
    required String password,
    required String timezone,
  }) async {
    try {
      final request = RegisterRequest(
        fullname: fullname,
        email: email,
        password: password,
        timezone: timezone,
      );

      final response = await _apiService.register(request);

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Registration failed',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      // Save tokens
      await _localDataSource.saveTokens(
        response.data.accessToken,
        response.data.refreshToken,
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
          errorCode: e.errorCode,
        ),
      );
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      Logger.error(
        'Unexpected error during registration',
        tag: 'AuthRepo',
        error: e,
      );
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(email: email, password: password);

      final response = await _apiService.login(request);

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Login failed',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      // Save tokens
      await _localDataSource.saveTokens(
        response.data.accessToken,
        response.data.refreshToken,
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
          errorCode: e.errorCode,
        ),
      );
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      Logger.error('Unexpected error during login', tag: 'AuthRepo', error: e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    try {
      final refreshToken = await _localDataSource.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        return const Left(
          UnauthorizedFailure(message: 'No refresh token available'),
        );
      }

      final request = RefreshTokenRequest(refreshToken: refreshToken);
      final response = await _apiService.refreshToken(request);

      if (!response.success) {
        await _localDataSource.clearTokens();
        return Left(
          UnauthorizedFailure(
            message: response.message ?? 'Token refresh failed',
          ),
        );
      }

      // Save new tokens
      await _localDataSource.saveTokens(
        response.data.accessToken,
        response.data.refreshToken,
      );

      Logger.log('Token refreshed successfully', tag: 'AuthRepo');
      return const Right(null);
    } on DioException catch (e) {
      await _localDataSource.clearTokens();
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error(
        'Unexpected error during token refresh',
        tag: 'AuthRepo',
        error: e,
      );
      await _localDataSource.clearTokens();
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _localDataSource.clearTokens();
      Logger.log('User logged out', tag: 'AuthRepo');
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      Logger.error('Unexpected error during logout', tag: 'AuthRepo', error: e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      return await _localDataSource.hasValidTokens();
    } catch (e) {
      Logger.error('Error checking authentication', tag: 'AuthRepo', error: e);
      return false;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return await _localDataSource.getAccessToken();
    } catch (e) {
      Logger.error('Error getting access token', tag: 'AuthRepo', error: e);
      return null;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await _localDataSource.getRefreshToken();
    } catch (e) {
      Logger.error('Error getting refresh token', tag: 'AuthRepo', error: e);
      return null;
    }
  }

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(message: 'Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkFailure(message: 'No internet connection');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        String message = 'Request failed';

        if (e.response?.data is Map<String, dynamic>) {
          message = e.response?.data['message'] ?? message;
        } else if (e.response?.data is String) {
          message = e.response?.data;
        }

        if (statusCode == 401) {
          return UnauthorizedFailure(message: message);
        } else if (statusCode == 400) {
          return ValidationFailure(
            message: message,
            errors: e.response?.data is Map<String, dynamic>
                ? e.response?.data['errors']
                : null,
          );
        }
        return ServerFailure(message: message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const UnknownFailure(message: 'Request cancelled');
      default:
        return UnknownFailure(message: e.message ?? 'Unknown error occurred');
    }
  }
}
