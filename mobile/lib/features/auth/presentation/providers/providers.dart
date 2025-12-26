import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile/features/profile/data/datasources/profile_api_service.dart';
import 'package:mobile/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mobile/features/profile/domain/repositories/profile_repository.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  final storage = ref.read(secureStorageProvider);
  return AuthLocalDataSource(storage);
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final authLocalDataSource = ref.read(authLocalDataSourceProvider);
  return DioClient.createDio(authLocalDataSource: authLocalDataSource);
}

@riverpod
AuthApiService authApiService(Ref ref) {
  final dio = ref.read(dioProvider);
  return AuthApiService(dio);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    apiService: ref.read(authApiServiceProvider),
    localDataSource: ref.read(authLocalDataSourceProvider),
  );
}

@riverpod
ProfileApiService profileApiService(Ref ref) {
  final dio = ref.read(dioProvider);
  return ProfileApiService(dio);
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepositoryImpl(ref.read(profileApiServiceProvider));
}
