import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/context/presentation/providers/context_provider.dart'
    as context_providers;
import 'package:mobile/features/silence/domain/entities/silence_context.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'context_provider.g.dart';

// Context state
class ContextState {
  final List<SilenceContext> contexts;
  final bool isLoading;
  final String? error;

  const ContextState({
    this.contexts = const [],
    this.isLoading = false,
    this.error,
  });

  ContextState copyWith({
    List<SilenceContext>? contexts,
    bool? isLoading,
    String? error,
  }) {
    return ContextState(
      contexts: contexts ?? this.contexts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Context notifier
@riverpod
class ContextNotifier extends _$ContextNotifier {
  @override
  ContextState build() {
    loadContexts();
    return const ContextState();
  }

  Future<void> loadContexts() async {
    if (state.isLoading || state.contexts.isNotEmpty) return; // Only load once

    state = state.copyWith(isLoading: true, error: null);

    final contextRepository = ref.read(
      context_providers.contextRepositoryProvider,
    );
    final result = await contextRepository.getContexts(module: 'silence');

    result.fold(
      (failure) {
        Logger.error(
          'Failed to load contexts',
          tag: 'ContextProvider',
          error: failure.message,
        );
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (contexts) {
        Logger.log(
          'Loaded ${contexts.length} contexts',
          tag: 'ContextProvider',
        );
        // Map Context to SilenceContext
        final silenceContexts = contexts
            .map(
              (context) =>
                  SilenceContext(code: context.code, label: context.label),
            )
            .toList();
        state = state.copyWith(
          contexts: silenceContexts,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
