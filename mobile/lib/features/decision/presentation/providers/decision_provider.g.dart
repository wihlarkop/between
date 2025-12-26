// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for decision list and operations

@ProviderFor(DecisionNotifier)
const decisionProvider = DecisionNotifierProvider._();

/// Notifier for decision list and operations
final class DecisionNotifierProvider
    extends $NotifierProvider<DecisionNotifier, DecisionListState> {
  /// Notifier for decision list and operations
  const DecisionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'decisionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$decisionNotifierHash();

  @$internal
  @override
  DecisionNotifier create() => DecisionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DecisionListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DecisionListState>(value),
    );
  }
}

String _$decisionNotifierHash() => r'f52c10856ea6094ac02b8a5c95492b910a0ff01c';

/// Notifier for decision list and operations

abstract class _$DecisionNotifier extends $Notifier<DecisionListState> {
  DecisionListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DecisionListState, DecisionListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DecisionListState, DecisionListState>,
              DecisionListState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider for fetching decision stats

@ProviderFor(decisionStats)
const decisionStatsProvider = DecisionStatsProvider._();

/// Provider for fetching decision stats

final class DecisionStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<DecisionStats>,
          DecisionStats,
          FutureOr<DecisionStats>
        >
    with $FutureModifier<DecisionStats>, $FutureProvider<DecisionStats> {
  /// Provider for fetching decision stats
  const DecisionStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'decisionStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$decisionStatsHash();

  @$internal
  @override
  $FutureProviderElement<DecisionStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DecisionStats> create(Ref ref) {
    return decisionStats(ref);
  }
}

String _$decisionStatsHash() => r'ac5b1790cf5feba86fc5e7b08833e571e70a96ec';

/// Provider for fetching a single decision by ID

@ProviderFor(decisionDetails)
const decisionDetailsProvider = DecisionDetailsFamily._();

/// Provider for fetching a single decision by ID

final class DecisionDetailsProvider
    extends
        $FunctionalProvider<AsyncValue<Decision>, Decision, FutureOr<Decision>>
    with $FutureModifier<Decision>, $FutureProvider<Decision> {
  /// Provider for fetching a single decision by ID
  const DecisionDetailsProvider._({
    required DecisionDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'decisionDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$decisionDetailsHash();

  @override
  String toString() {
    return r'decisionDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Decision> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Decision> create(Ref ref) {
    final argument = this.argument as String;
    return decisionDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DecisionDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$decisionDetailsHash() => r'c690d53d24b7eed2914fce9b4c2a0a0bb604ea67';

/// Provider for fetching a single decision by ID

final class DecisionDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Decision>, String> {
  const DecisionDetailsFamily._()
    : super(
        retry: null,
        name: r'decisionDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for fetching a single decision by ID

  DecisionDetailsProvider call(String decisionId) =>
      DecisionDetailsProvider._(argument: decisionId, from: this);

  @override
  String toString() => r'decisionDetailsProvider';
}
