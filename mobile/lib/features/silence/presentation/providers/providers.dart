import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/core/providers/common_providers.dart';
import 'package:mobile/core/data/datasources/local/session_cache_data_source.dart';
import 'package:mobile/features/auth/presentation/providers/providers.dart';
import 'package:mobile/features/silence/data/datasources/active_session_data_source.dart';
import 'package:mobile/features/silence/data/datasources/silence_remote_datasource.dart';
import 'package:mobile/features/silence/data/repositories/silence_repository_impl.dart';
import 'package:mobile/features/silence/domain/repositories/silence_repository.dart';

part 'providers.g.dart';

@riverpod
ActiveSessionDataSource activeSessionDataSource(Ref ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return ActiveSessionDataSource(prefs);
}

@riverpod
SessionCacheDataSource sessionCacheDataSource(Ref ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return SessionCacheDataSource(prefs);
}

@riverpod
SilenceApiService silenceApiService(Ref ref) {
  final dio = ref.read(dioProvider);
  return SilenceApiService(dio);
}

@riverpod
SilenceRepository silenceRepository(Ref ref) {
  return SilenceRepositoryImpl(
    apiService: ref.read(silenceApiServiceProvider),
    cacheDataSource: ref.read(sessionCacheDataSourceProvider),
  );
}
