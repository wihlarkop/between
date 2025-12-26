import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/features/silence/domain/entities/silence_session.dart';
import 'providers.dart';

part 'session_history_provider.g.dart';

@riverpod
class SessionHistory extends _$SessionHistory {
  @override
  FutureOr<List<SilenceSession>> build() async {
    return _fetchHistory();
  }

  Future<List<SilenceSession>> _fetchHistory() async {
    final silenceRepository = ref.read(silenceRepositoryProvider);
    final result = await silenceRepository.getSessionHistory(limit: 50);
    return result.fold((failure) {
      // Log error but return empty list or throw depending on preference.
      // For AsyncValue handling, throwing allows error state.
      throw Exception(failure.message);
    }, (sessions) => sessions);
  }

  Future<void> refresh() async {
    // Check if provider is still mounted before updating state
    if (!ref.mounted) return;

    state = const AsyncValue.loading();
    final newState = await AsyncValue.guard(() => _fetchHistory());

    // Check again after async operation
    if (ref.mounted) {
      state = newState;
    }
  }
}
