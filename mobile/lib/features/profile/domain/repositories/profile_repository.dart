import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';

abstract class ProfileRepository {
  /// Get current user profile
  Future<Either<Failure, User>> getProfile();

  /// Update user profile
  /// All parameters are optional - only provide fields you want to update
  Future<Either<Failure, void>> updateProfile({
    String? fullname,
    String? timezone,
    String? password,
  });
}
