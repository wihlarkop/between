import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';
import 'package:mobile/features/profile/domain/repositories/profile_repository.dart';
import 'package:mobile/features/profile/data/datasources/profile_api_service.dart';
import 'package:mobile/features/auth/data/models/profile_request.dart';
import 'package:mobile/features/auth/data/models/user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _apiService;

  ProfileRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, User>> getProfile() async {
    try {
      final response = await _apiService.getProfile();

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to fetch profile',
            statusCode: response.statusCode,
          ),
        );
      }

      final user = _mapUserModelToEntity(response.data);
      return Right(user);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error(
        'Unexpected error fetching profile',
        tag: 'ProfileRepo',
        error: e,
      );
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile({
    String? fullname,
    String? timezone,
    String? password,
  }) async {
    try {
      final request = UpdateProfileRequest(
        fullname: fullname,
        timezone: timezone,
        password: password,
      );

      final response = await _apiService.updateProfile(request);

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to update profile',
            statusCode: response.statusCode,
          ),
        );
      }

      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error(
        'Unexpected error updating profile',
        tag: 'ProfileRepo',
        error: e,
      );
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Helper mapping (copied context from AuthRepo for consistency)
  User _mapUserModelToEntity(UserModel userModel) {
    return User(
      id: userModel.id,
      fullname: userModel.fullname,
      email: userModel.email,
      timezone: userModel.timezone,
      createdAt: userModel.createdAt != null
          ? DateTime.parse(userModel.createdAt!)
          : DateTime.now(),
      updatedAt: userModel.updatedAt != null
          ? DateTime.parse(userModel.updatedAt!)
          : null,
    );
  }

  Failure _handleDioException(DioException e) {
    // Reuse error handling logic from a shared place or AuthRepo
    // For now, simple mapping
    return ServerFailure(
      message: e.message ?? 'API Error',
      statusCode: e.response?.statusCode,
    );
  }
}
