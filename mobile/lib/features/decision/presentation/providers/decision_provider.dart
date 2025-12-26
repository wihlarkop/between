import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/decision/domain/entities/decision.dart';
import 'package:mobile/features/decision/domain/entities/decision_stats.dart';
import 'package:mobile/features/decision/presentation/providers/providers.dart';

part 'decision_provider.g.dart';

/// Filter for decision list
enum DecisionFilter {
  all,
  pending,
  completed,
  quick,
}

/// State for decision list
class DecisionListState {
  final List<Decision> decisions;
  final bool isLoading;
  final String? error;
  final DecisionFilter filter;
  final int currentPage;
  final bool hasMore;

  const DecisionListState({
    this.decisions = const [],
    this.isLoading = false,
    this.error,
    this.filter = DecisionFilter.all,
    this.currentPage = 1,
    this.hasMore = true,
  });

  DecisionListState copyWith({
    List<Decision>? decisions,
    bool? isLoading,
    String? error,
    DecisionFilter? filter,
    int? currentPage,
    bool? hasMore,
    bool clearError = false,
  }) {
    return DecisionListState(
      decisions: decisions ?? this.decisions,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      filter: filter ?? this.filter,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

/// Notifier for decision list and operations
@riverpod
class DecisionNotifier extends _$DecisionNotifier {
  static const int _pageSize = 20;

  @override
  DecisionListState build() {
    // Defer the initial load to avoid accessing state before it's set
    Future.microtask(() => _loadDecisions(initial: true));
    return const DecisionListState(isLoading: true);
  }

  Future<void> _loadDecisions({bool refresh = false, bool initial = false}) async {
    // Skip the state check on initial load since state isn't set yet
    if (!initial && state.isLoading && !refresh) return;

    final currentState = initial ? const DecisionListState(isLoading: true) : state;

    state = currentState.copyWith(
      isLoading: true,
      clearError: true,
      currentPage: refresh ? 1 : currentState.currentPage,
      decisions: refresh ? [] : currentState.decisions,
    );

    final repository = ref.read(decisionRepositoryProvider);
    final result = await repository.getDecisions(
      page: refresh || initial ? 1 : state.currentPage,
      limit: _pageSize,
      status: _filterToStatus(initial ? DecisionFilter.all : state.filter),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (decisions) {
        state = state.copyWith(
          isLoading: false,
          decisions: refresh ? decisions : [...state.decisions, ...decisions],
          hasMore: decisions.length >= _pageSize,
        );
      },
    );
  }

  String? _filterToStatus(DecisionFilter filter) {
    switch (filter) {
      case DecisionFilter.pending:
        return 'pending';
      case DecisionFilter.completed:
        return 'completed';
      case DecisionFilter.quick:
        return 'quick';
      case DecisionFilter.all:
        return null;
    }
  }

  Future<void> refresh() async {
    await _loadDecisions(refresh: true);
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;
    state = state.copyWith(currentPage: state.currentPage + 1);
    await _loadDecisions();
  }

  void setFilter(DecisionFilter filter) {
    if (state.filter == filter) return;
    state = state.copyWith(filter: filter);
    _loadDecisions(refresh: true);
  }

  Future<Decision?> createDecision({
    required String title,
    DateTime? decidedAt,
    String? reason,
    String? expectation,
    DateTime? completedAt,
    String? actualResult,
    String? learnings,
    int? contextCode,
    List<String>? tags,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final repository = ref.read(decisionRepositoryProvider);
    final result = await repository.createDecision(
      title: title,
      decidedAt: decidedAt,
      reason: reason,
      expectation: expectation,
      completedAt: completedAt,
      actualResult: actualResult,
      learnings: learnings,
      contextCode: contextCode,
      tags: tags,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return null;
      },
      (decision) {
        state = state.copyWith(
          isLoading: false,
          decisions: [decision, ...state.decisions],
        );
        HapticFeedback.lightImpact();
        Logger.log('Decision created: ${decision.id}', tag: 'DecisionProvider');
        return decision;
      },
    );
  }

  Future<Decision?> updateDecision({
    required String id,
    String? title,
    DateTime? decidedAt,
    String? reason,
    String? expectation,
    DateTime? completedAt,
    String? actualResult,
    String? learnings,
    int? contextCode,
    List<String>? tags,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final repository = ref.read(decisionRepositoryProvider);
    final result = await repository.updateDecision(
      id: id,
      title: title,
      decidedAt: decidedAt,
      reason: reason,
      expectation: expectation,
      completedAt: completedAt,
      actualResult: actualResult,
      learnings: learnings,
      contextCode: contextCode,
      tags: tags,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return null;
      },
      (decision) {
        final updatedDecisions = state.decisions.map((d) {
          return d.id == id ? decision : d;
        }).toList();

        state = state.copyWith(
          isLoading: false,
          decisions: updatedDecisions,
        );
        HapticFeedback.lightImpact();
        Logger.log('Decision updated: ${decision.id}', tag: 'DecisionProvider');
        return decision;
      },
    );
  }

  Future<Decision?> markAsDecided(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final repository = ref.read(decisionRepositoryProvider);
    final result = await repository.markAsDecided(id);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return null;
      },
      (decision) {
        final updatedDecisions = state.decisions.map((d) {
          return d.id == id ? decision : d;
        }).toList();

        state = state.copyWith(
          isLoading: false,
          decisions: updatedDecisions,
        );
        HapticFeedback.mediumImpact();
        Logger.log('Decision marked as decided: ${decision.id}',
            tag: 'DecisionProvider');
        return decision;
      },
    );
  }

  Future<Decision?> completeDecision({
    required String id,
    String? actualResult,
    String? learnings,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final repository = ref.read(decisionRepositoryProvider);
    final result = await repository.completeDecision(
      id: id,
      actualResult: actualResult,
      learnings: learnings,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return null;
      },
      (decision) {
        final updatedDecisions = state.decisions.map((d) {
          return d.id == id ? decision : d;
        }).toList();

        state = state.copyWith(
          isLoading: false,
          decisions: updatedDecisions,
        );
        HapticFeedback.heavyImpact();
        Logger.log('Decision completed: ${decision.id}',
            tag: 'DecisionProvider');
        return decision;
      },
    );
  }

  Future<bool> deleteDecision(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final repository = ref.read(decisionRepositoryProvider);
    final result = await repository.deleteDecision(id);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (_) {
        final updatedDecisions =
            state.decisions.where((d) => d.id != id).toList();
        state = state.copyWith(
          isLoading: false,
          decisions: updatedDecisions,
        );
        HapticFeedback.lightImpact();
        Logger.log('Decision deleted: $id', tag: 'DecisionProvider');
        return true;
      },
    );
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

/// Provider for fetching decision stats
@riverpod
Future<DecisionStats> decisionStats(Ref ref) async {
  final repository = ref.read(decisionRepositoryProvider);
  final result = await repository.getStats();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (stats) => stats,
  );
}

/// Provider for fetching a single decision by ID
@riverpod
Future<Decision> decisionDetails(Ref ref, String decisionId) async {
  final repository = ref.read(decisionRepositoryProvider);
  final result = await repository.getDecisionById(decisionId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (decision) => decision,
  );
}
