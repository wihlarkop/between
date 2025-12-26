import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/auth/data/models/auth_response.dart';

abstract class AuthRepository {
  /// Register a new user
  Future<Either<Failure, AuthResponse>> register({
    required String fullname,
    required String email,
    required String password,
    required String timezone,
  });

  /// Login with email and password
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  });

  /// Refresh access token using refresh token
  Future<Either<Failure, void>> refreshToken();

  /// Logout and clear all tokens
  Future<Either<Failure, void>> logout();

  /// Check if user is authenticated
  Future<bool> isAuthenticated();

  /// Get current access token
  Future<String?> getAccessToken();

  /// Get current refresh token
  Future<String?> getRefreshToken();
}
