import 'package:dio/dio.dart';

import 'package:mobile/features/auth/data/datasources/auth_local_datasource.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource _authLocalDataSource;

  AuthInterceptor(this._authLocalDataSource);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get the access token from secure storage
    final accessToken = await _authLocalDataSource.getAccessToken();

    // Add the authorization header if token exists
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }
}
