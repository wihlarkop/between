import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/features/silence/presentation/providers/providers.dart';
import 'package:mobile/features/stats/domain/entities/session_stats.dart';

part 'silence_stats_provider.g.dart';

/// Provider for fetching silence session statistics
@riverpod
class SilenceStats extends _$SilenceStats {
  @override
  Future<SessionStats> build() async {
    return _fetchStats();
  }

  Future<SessionStats> _fetchStats() async {
    final silenceRepository = ref.read(silenceRepositoryProvider);
    final result = await silenceRepository.getStats();
    return result.fold(
      (failure) {
        throw Exception(failure.message);
      },
      (stats) => stats,
    );
  }

  Future<void> refresh() async {
    if (!ref.mounted) return;

    state = const AsyncValue.loading();
    final newState = await AsyncValue.guard(() => _fetchStats());

    if (ref.mounted) {
      state = newState;
    }
  }
}
