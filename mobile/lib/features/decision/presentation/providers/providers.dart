import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/features/auth/presentation/providers/providers.dart';
import 'package:mobile/features/decision/data/datasources/decision_api_service.dart';
import 'package:mobile/features/decision/data/repositories/decision_repository_impl.dart';
import 'package:mobile/features/decision/domain/repositories/decision_repository.dart';

part 'providers.g.dart';

@riverpod
DecisionApiService decisionApiService(Ref ref) {
  final dio = ref.read(dioProvider);
  return DecisionApiService(dio);
}

@riverpod
DecisionRepository decisionRepository(Ref ref) {
  return DecisionRepositoryImpl(
    apiService: ref.read(decisionApiServiceProvider),
  );
}
