import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/silence/domain/entities/silence_context.dart';
import 'package:mobile/features/silence/domain/entities/silence_session.dart';
import 'package:mobile/features/context/presentation/providers/context_provider.dart';
import '../providers/providers.dart';
import 'package:mobile/core/providers/common_providers.dart';
import 'package:mobile/core/services/notification_service.dart';
import 'package:mobile/core/services/wakelock_service.dart';

part 'session_provider.g.dart';

// Session state
class SessionState {
  final SilenceSession? activeSession;
  final DateTime? startTime;
  final int currentDuration; // in seconds
  final bool isLoading;
  final String? error;

  const SessionState({
    this.activeSession,
    this.startTime,
    this.currentDuration = 0,
    this.isLoading = false,
    this.error,
  });

  bool get hasActiveSession => activeSession != null && startTime != null;

  SessionState copyWith({
    SilenceSession? activeSession,
    DateTime? startTime,
    int? currentDuration,
    bool? isLoading,
    String? error,
    bool clearSession = false,
  }) {
    return SessionState(
      activeSession: clearSession
          ? null
          : (activeSession ?? this.activeSession),
      startTime: clearSession ? null : (startTime ?? this.startTime),
      currentDuration: currentDuration ?? this.currentDuration,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Session notifier
@riverpod
class SessionNotifier extends _$SessionNotifier {
  Timer? _timer;
  Timer? _gracePeriodTimer;

  @override
  SessionState build() {
    ref.onDispose(() {
      _stopTimer();
      _gracePeriodTimer?.cancel();
      ref.read(wakelockServiceProvider.notifier).disable();
    });

    // Listen to app lifecycle changes
    ref.listen(appLifecycleProvider, (previous, next) {
      if (!state.hasActiveSession) return;

      if (next == AppLifecycleState.paused ||
          next == AppLifecycleState.hidden) {
        Logger.log(
          'App entered background, starting 5s grace period',
          tag: 'SessionProvider',
        );

        _gracePeriodTimer?.cancel();
        _gracePeriodTimer = Timer(const Duration(seconds: 5), () {
          if (state.hasActiveSession) {
            HapticFeedback.vibrate(); // Heavy feedback for distraction
            Logger.log(
              'Grace period expired, ending session with distraction reason',
              tag: 'SessionProvider',
            );
            endSession(terminationReason: 'distraction');

            // Show notification
            ref
                .read(notificationServiceProvider.notifier)
                .showNotification(
                  id: 1,
                  title: 'Silence Broken',
                  body: 'Your session ended because you left the app.',
                );
          }
        });
      } else if (next == AppLifecycleState.resumed) {
        if (_gracePeriodTimer?.isActive ?? false) {
          Logger.log(
            'App resumed within grace period, session continues',
            tag: 'SessionProvider',
          );
          _gracePeriodTimer?.cancel();
        }
      }
    });

    _restoreActiveSession();
    return const SessionState();
  }

  Future<void> _restoreActiveSession() async {
    try {
      final activeSessionDataSource = ref.read(activeSessionDataSourceProvider);
      final activeSessionData = await activeSessionDataSource
          .getActiveSession();

      if (activeSessionData == null) return;

      final duration = DateTime.now()
          .difference(activeSessionData.startTime)
          .inSeconds;

      if (duration > AppConstants.maxSessionDurationSeconds) {
        await activeSessionDataSource.clearActiveSession();
        return;
      }

      state = state.copyWith(
        activeSession: SilenceSession(
          id: activeSessionData.sessionId,
          userId: '',
          startedAt: activeSessionData.startTime,
          createdAt: activeSessionData.startTime,
        ),
        startTime: activeSessionData.startTime,
        currentDuration: duration,
      );

      _startTimer();
      ref.read(wakelockServiceProvider.notifier).enable();
    } catch (e) {
      Logger.error('Failed to restore active session', error: e);
    }
  }

  Future<bool> startSession() async {
    state = state.copyWith(isLoading: true, error: null);

    final silenceRepository = ref.read(silenceRepositoryProvider);
    final result = await silenceRepository.startSession();

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (session) async {
        final startTime = DateTime.now();
        final activeSessionDataSource = ref.read(
          activeSessionDataSourceProvider,
        );

        await activeSessionDataSource.saveActiveSession(session.id, startTime);

        state = state.copyWith(
          activeSession: session,
          startTime: startTime,
          currentDuration: 0,
          isLoading: false,
          error: null,
        );

        _startTimer();
        ref.read(wakelockServiceProvider.notifier).enable();
        HapticFeedback.lightImpact(); // Sensory cue for starting
        return true;
      },
    );
  }

  Future<SilenceSession?> endSession({String? terminationReason}) async {
    if (!state.hasActiveSession) {
      state = state.copyWith(error: 'No active session');
      return null;
    }

    if (state.currentDuration < AppConstants.minSessionDurationSeconds) {
      state = state.copyWith(
        error:
            'Session must be at least ${AppConstants.minSessionDurationSeconds} seconds',
      );
      return null;
    }

    state = state.copyWith(isLoading: true, error: null);
    _stopTimer();

    final silenceRepository = ref.read(silenceRepositoryProvider);
    final result = await silenceRepository.endSession(
      terminationReason: terminationReason,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        _startTimer();
        return null;
      },
      (session) async {
        final activeSessionDataSource = ref.read(
          activeSessionDataSourceProvider,
        );
        await activeSessionDataSource.clearActiveSession();

        state = state.copyWith(
          clearSession: true,
          isLoading: false,
          error: null,
        );

        ref.read(wakelockServiceProvider.notifier).disable();
        HapticFeedback.mediumImpact(); // Sensory cue for ending

        return session;
      },
    );
  }

  Future<List<SilenceContext>> getContexts() async {
    final contextRepository = ref.read(contextRepositoryProvider);
    final result = await contextRepository.getContexts(module: 'silence');
    return result.fold((failure) {
      Logger.error('Failed to fetch contexts: ${failure.message}');
      return [];
    }, (contexts) {
      // Map Context to SilenceContext
      return contexts
          .map((context) =>
              SilenceContext(code: context.code, label: context.label))
          .toList();
    });
  }

  Future<void> attachContext({
    required String sessionId,
    required int contextCode,
    String? note,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final silenceRepository = ref.read(silenceRepositoryProvider);
    final result = await silenceRepository.attachContext(
      sessionId: sessionId,
      contextCode: contextCode,
      contextNote: note,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (_) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  void _startTimer() {
    _stopTimer();

    _timer = Timer.periodic(AppConstants.timerTickDuration, (_) {
      if (!state.hasActiveSession || state.startTime == null) {
        _stopTimer();
        return;
      }

      final duration = DateTime.now().difference(state.startTime!).inSeconds;

      if (duration >= AppConstants.maxSessionDurationSeconds) {
        _stopTimer();
        endSession();
        return;
      }

      state = state.copyWith(currentDuration: duration);
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
