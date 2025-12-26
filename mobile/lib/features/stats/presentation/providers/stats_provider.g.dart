// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Stats)
const statsProvider = StatsProvider._();

final class StatsProvider extends $AsyncNotifierProvider<Stats, SessionStats> {
  const StatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsHash();

  @$internal
  @override
  Stats create() => Stats();
}

String _$statsHash() => r'ce4425f7903cba1b858100259be42c5c0d286fae';

abstract class _$Stats extends $AsyncNotifier<SessionStats> {
  FutureOr<SessionStats> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<SessionStats>, SessionStats>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SessionStats>, SessionStats>,
              AsyncValue<SessionStats>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
