// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'silence_stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for fetching silence session statistics

@ProviderFor(SilenceStats)
const silenceStatsProvider = SilenceStatsProvider._();

/// Provider for fetching silence session statistics
final class SilenceStatsProvider
    extends $AsyncNotifierProvider<SilenceStats, SessionStats> {
  /// Provider for fetching silence session statistics
  const SilenceStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'silenceStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$silenceStatsHash();

  @$internal
  @override
  SilenceStats create() => SilenceStats();
}

String _$silenceStatsHash() => r'ae06e0f242d60921768679142f107dcb577d7aef';

/// Provider for fetching silence session statistics

abstract class _$SilenceStats extends $AsyncNotifier<SessionStats> {
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
