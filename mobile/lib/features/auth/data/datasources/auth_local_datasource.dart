import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/error/exceptions.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  AuthLocalDataSource(this._secureStorage);

  Future<void> saveAccessToken(String token) async {
    try {
      await _secureStorage.write(
        key: AppConstants.accessTokenKey,
        value: token,
      );
    } catch (e) {
      throw CacheException(message: 'Failed to save access token: $e');
    }
  }

  Future<void> saveRefreshToken(String token) async {
    try {
      await _secureStorage.write(
        key: AppConstants.refreshTokenKey,
        value: token,
      );
    } catch (e) {
      throw CacheException(message: 'Failed to save refresh token: $e');
    }
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
  }

  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.accessTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to get access token: $e');
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.refreshTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to get refresh token: $e');
    }
  }

  Future<void> deleteAccessToken() async {
    try {
      await _secureStorage.delete(key: AppConstants.accessTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to delete access token: $e');
    }
  }

  Future<void> deleteRefreshToken() async {
    try {
      await _secureStorage.delete(key: AppConstants.refreshTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to delete refresh token: $e');
    }
  }

  Future<void> clearTokens() async {
    await deleteAccessToken();
    await deleteRefreshToken();
  }

  Future<bool> hasValidTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    return accessToken != null &&
        accessToken.isNotEmpty &&
        refreshToken != null &&
        refreshToken.isNotEmpty;
  }
}
