import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/features/stats/domain/entities/session_stats.dart';
import 'providers.dart';

part 'stats_provider.g.dart';

@riverpod
class Stats extends _$Stats {
  @override
  FutureOr<SessionStats> build() async {
    return _fetchStats();
  }

  Future<SessionStats> _fetchStats() async {
    final silenceRepository = ref.read(silenceRepositoryProvider);
    final result = await silenceRepository.getStats();
    return result.fold((failure) {
      throw Exception(failure.message);
    }, (stats) => stats);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchStats());
  }
}
