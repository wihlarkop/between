import 'package:dio/dio.dart';

import 'package:mobile/core/constants/api_constants.dart';
import 'package:mobile/core/utils/logger.dart';

class ApiInterceptor extends Interceptor {
  final Future<String?> Function() getAccessToken;
  final Future<String?> Function() getRefreshToken;
  final Future<void> Function(String accessToken, String refreshToken)
  saveTokens;
  final Future<void> Function() clearTokens;
  final Future<Map<String, dynamic>> Function(String refreshToken)
  refreshTokenRequest;
  final void Function()? onUnauthorized;

  ApiInterceptor({
    required this.getAccessToken,
    required this.getRefreshToken,
    required this.saveTokens,
    required this.clearTokens,
    required this.refreshTokenRequest,
    this.onUnauthorized,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add access token to header if available
    final accessToken = await getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers[ApiConstants.authorizationHeader] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if error is 401 (Unauthorized)
    if (err.response?.statusCode == 401) {
      Logger.log(
        'Received 401, attempting token refresh',
        tag: 'ApiInterceptor',
      );

      try {
        // Get refresh token
        final refreshToken = await getRefreshToken();

        if (refreshToken == null || refreshToken.isEmpty) {
          Logger.warning(
            'No refresh token available, clearing tokens and logging out',
            tag: 'ApiInterceptor',
          );
          await clearTokens();
          onUnauthorized?.call();
          return handler.reject(err);
        }

        // Attempt to refresh token
        final response = await refreshTokenRequest(refreshToken);

        // Extract new tokens from response
        final data = response['data'] as Map<String, dynamic>;
        final tokens = data['tokens'] as Map<String, dynamic>;
        final newAccessToken = tokens['access_token'] as String;
        final newRefreshToken = tokens['refresh_token'] as String;

        // Save new tokens
        await saveTokens(newAccessToken, newRefreshToken);

        Logger.log('Token refreshed successfully', tag: 'ApiInterceptor');

        // Retry the original request with new token
        final opts = err.requestOptions;
        opts.headers[ApiConstants.authorizationHeader] =
            'Bearer $newAccessToken';
        opts.headers['Accept'] = 'application/json';

        final dio = Dio(BaseOptions(baseUrl: opts.baseUrl));
        final retryResponse = await dio.fetch(opts);

        return handler.resolve(retryResponse);
      } catch (e) {
        Logger.error(
          'Token refresh failed, logging out',
          tag: 'ApiInterceptor',
          error: e,
        );
        // Clear tokens and reject the request
        await clearTokens();
        onUnauthorized?.call();
        return handler.reject(err);
      }
    }

    handler.next(err);
  }
}
