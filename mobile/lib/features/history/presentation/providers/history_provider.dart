import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/silence/domain/entities/silence_session.dart';
import 'providers.dart';

part 'history_provider.g.dart';

// History state
class HistoryState {
  final List<SilenceSession> sessions;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentOffset;

  const HistoryState({
    this.sessions = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentOffset = 0,
  });

  HistoryState copyWith({
    List<SilenceSession>? sessions,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentOffset,
  }) {
    return HistoryState(
      sessions: sessions ?? this.sessions,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }
}

// History notifier
@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  @override
  HistoryState build() {
    loadSessions();
    return const HistoryState();
  }

  Future<void> loadSessions({bool refresh = false}) async {
    if (refresh) {
      state = const HistoryState(isLoading: true);
    } else if (state.isLoading || state.isLoadingMore) {
      return; // Prevent duplicate requests
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    final silenceRepository = ref.read(silenceRepositoryProvider);
    final result = await silenceRepository.getSessionHistory(
      limit: AppConstants.defaultPageLimit,
      offset: 0,
    );

    result.fold(
      (failure) {
        Logger.error(
          'Failed to load sessions',
          tag: 'HistoryProvider',
          error: failure.message,
        );
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (sessions) {
        Logger.log(
          'Loaded ${sessions.length} sessions',
          tag: 'HistoryProvider',
        );
        state = state.copyWith(
          sessions: sessions,
          isLoading: false,
          error: null,
          hasMore: sessions.length >= AppConstants.defaultPageLimit,
          currentOffset: sessions.length,
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) {
      return;
    }

    state = state.copyWith(isLoadingMore: true, error: null);

    final silenceRepository = ref.read(silenceRepositoryProvider);
    final result = await silenceRepository.getSessionHistory(
      limit: AppConstants.defaultPageLimit,
      offset: state.currentOffset,
    );

    result.fold(
      (failure) {
        Logger.error(
          'Failed to load more sessions',
          tag: 'HistoryProvider',
          error: failure.message,
        );
        state = state.copyWith(isLoadingMore: false, error: failure.message);
      },
      (newSessions) {
        Logger.log(
          'Loaded ${newSessions.length} more sessions',
          tag: 'HistoryProvider',
        );
        final allSessions = [...state.sessions, ...newSessions];
        state = state.copyWith(
          sessions: allSessions,
          isLoadingMore: false,
          error: null,
          hasMore: newSessions.length >= AppConstants.defaultPageLimit,
          currentOffset: allSessions.length,
        );
      },
    );
  }

  Future<void> refresh() async {
    await loadSessions(refresh: true);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
