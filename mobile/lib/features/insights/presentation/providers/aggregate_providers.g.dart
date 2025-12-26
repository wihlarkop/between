// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aggregate_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider that aggregates sessions from all modules
///
/// Supports filtering by module ID:
/// - null: return all sessions from all modules
/// - ModuleConstants.silence: return only silence sessions
/// - ModuleConstants.decision: return only decision sessions
/// etc.

@ProviderFor(allSessions)
const allSessionsProvider = AllSessionsFamily._();

/// Provider that aggregates sessions from all modules
///
/// Supports filtering by module ID:
/// - null: return all sessions from all modules
/// - ModuleConstants.silence: return only silence sessions
/// - ModuleConstants.decision: return only decision sessions
/// etc.

final class AllSessionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BaseSession>>,
          List<BaseSession>,
          FutureOr<List<BaseSession>>
        >
    with
        $FutureModifier<List<BaseSession>>,
        $FutureProvider<List<BaseSession>> {
  /// Provider that aggregates sessions from all modules
  ///
  /// Supports filtering by module ID:
  /// - null: return all sessions from all modules
  /// - ModuleConstants.silence: return only silence sessions
  /// - ModuleConstants.decision: return only decision sessions
  /// etc.
  const AllSessionsProvider._({
    required AllSessionsFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'allSessionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$allSessionsHash();

  @override
  String toString() {
    return r'allSessionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<BaseSession>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BaseSession>> create(Ref ref) {
    final argument = this.argument as String?;
    return allSessions(ref, moduleId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AllSessionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$allSessionsHash() => r'21d6dad00a284057c9b3a1f5ffdcb8bc8de60184';

/// Provider that aggregates sessions from all modules
///
/// Supports filtering by module ID:
/// - null: return all sessions from all modules
/// - ModuleConstants.silence: return only silence sessions
/// - ModuleConstants.decision: return only decision sessions
/// etc.

final class AllSessionsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<BaseSession>>, String?> {
  const AllSessionsFamily._()
    : super(
        retry: null,
        name: r'allSessionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider that aggregates sessions from all modules
  ///
  /// Supports filtering by module ID:
  /// - null: return all sessions from all modules
  /// - ModuleConstants.silence: return only silence sessions
  /// - ModuleConstants.decision: return only decision sessions
  /// etc.

  AllSessionsProvider call({String? moduleId}) =>
      AllSessionsProvider._(argument: moduleId, from: this);

  @override
  String toString() => r'allSessionsProvider';
}

/// Provider for aggregate statistics across all modules
///
/// Calculates total sessions, total duration, etc. across all modules
/// or for a specific module if moduleId is provided.

@ProviderFor(aggregateStats)
const aggregateStatsProvider = AggregateStatsFamily._();

/// Provider for aggregate statistics across all modules
///
/// Calculates total sessions, total duration, etc. across all modules
/// or for a specific module if moduleId is provided.

final class AggregateStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AggregateStats>,
          AggregateStats,
          FutureOr<AggregateStats>
        >
    with $FutureModifier<AggregateStats>, $FutureProvider<AggregateStats> {
  /// Provider for aggregate statistics across all modules
  ///
  /// Calculates total sessions, total duration, etc. across all modules
  /// or for a specific module if moduleId is provided.
  const AggregateStatsProvider._({
    required AggregateStatsFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'aggregateStatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aggregateStatsHash();

  @override
  String toString() {
    return r'aggregateStatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AggregateStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AggregateStats> create(Ref ref) {
    final argument = this.argument as String?;
    return aggregateStats(ref, moduleId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AggregateStatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aggregateStatsHash() => r'70116d75db85a7ba2f574034605944f255cdfd50';

/// Provider for aggregate statistics across all modules
///
/// Calculates total sessions, total duration, etc. across all modules
/// or for a specific module if moduleId is provided.

final class AggregateStatsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AggregateStats>, String?> {
  const AggregateStatsFamily._()
    : super(
        retry: null,
        name: r'aggregateStatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for aggregate statistics across all modules
  ///
  /// Calculates total sessions, total duration, etc. across all modules
  /// or for a specific module if moduleId is provided.

  AggregateStatsProvider call({String? moduleId}) =>
      AggregateStatsProvider._(argument: moduleId, from: this);

  @override
  String toString() => r'aggregateStatsProvider';
}
