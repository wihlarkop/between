import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/features/decision/domain/entities/decision.dart';
import 'package:mobile/features/decision/presentation/providers/providers.dart';

part 'decision_history_provider.g.dart';

/// Provider for fetching decision history for aggregate activity views
@riverpod
class DecisionHistory extends _$DecisionHistory {
  @override
  FutureOr<List<Decision>> build() async {
    return _fetchHistory();
  }

  Future<List<Decision>> _fetchHistory() async {
    final decisionRepository = ref.read(decisionRepositoryProvider);
    final result = await decisionRepository.getDecisions(page: 1, limit: 50);
    return result.fold(
      (failure) {
        throw Exception(failure.message);
      },
      (decisions) => decisions,
    );
  }

  Future<void> refresh() async {
    if (!ref.mounted) return;

    state = const AsyncValue.loading();
    final newState = await AsyncValue.guard(() => _fetchHistory());

    if (ref.mounted) {
      state = newState;
    }
  }
}
