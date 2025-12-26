import 'package:dio/dio.dart';

import 'package:mobile/config/env/env.dart';
import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/network/auth_interceptor.dart';
import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/auth/data/datasources/auth_local_datasource.dart';

class DioClient {
  static Dio createDio({AuthLocalDataSource? authLocalDataSource}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.apiBaseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add auth interceptor if authLocalDataSource is provided
    if (authLocalDataSource != null) {
      dio.interceptors.add(AuthInterceptor(authLocalDataSource));
    }

    // Add logging interceptor in debug mode
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
        request: true,
        logPrint: (obj) => Logger.debug(obj.toString(), tag: 'DIO'),
      ),
    );

    return dio;
  }
}
