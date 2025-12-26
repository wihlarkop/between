import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/features/auth/presentation/providers/providers.dart';
import 'package:mobile/features/context/data/datasources/context_remote_datasource.dart';
import 'package:mobile/features/context/data/repositories/context_repository_impl.dart';
import 'package:mobile/features/context/domain/entities/context.dart';
import 'package:mobile/features/context/domain/repositories/context_repository.dart';

part 'context_provider.g.dart';

/// Provider for context remote data source
final contextRemoteDataSourceProvider = Provider<ContextRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return ContextRemoteDataSource(dio);
});

/// Provider for context repository
final contextRepositoryProvider = Provider<ContextRepository>((ref) {
  final remoteDataSource = ref.watch(contextRemoteDataSourceProvider);
  return ContextRepositoryImpl(remoteDataSource);
});

/// Provider for fetching contexts by module
@riverpod
Future<List<Context>> contexts(Ref ref, {String? module}) async {
  final repository = ref.read(contextRepositoryProvider);
  final result = await repository.getContexts(module: module);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (contexts) => contexts,
  );
}
