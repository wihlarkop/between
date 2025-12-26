// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for fetching decision history for aggregate activity views

@ProviderFor(DecisionHistory)
const decisionHistoryProvider = DecisionHistoryProvider._();

/// Provider for fetching decision history for aggregate activity views
final class DecisionHistoryProvider
    extends $AsyncNotifierProvider<DecisionHistory, List<Decision>> {
  /// Provider for fetching decision history for aggregate activity views
  const DecisionHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'decisionHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$decisionHistoryHash();

  @$internal
  @override
  DecisionHistory create() => DecisionHistory();
}

String _$decisionHistoryHash() => r'99e1c3989b4970966dde390306c2ba073c47ba55';

/// Provider for fetching decision history for aggregate activity views

abstract class _$DecisionHistory extends $AsyncNotifier<List<Decision>> {
  FutureOr<List<Decision>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Decision>>, List<Decision>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Decision>>, List<Decision>>,
              AsyncValue<List<Decision>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
