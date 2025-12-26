// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wakelock_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WakelockService)
const wakelockServiceProvider = WakelockServiceProvider._();

final class WakelockServiceProvider
    extends $NotifierProvider<WakelockService, void> {
  const WakelockServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wakelockServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wakelockServiceHash();

  @$internal
  @override
  WakelockService create() => WakelockService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$wakelockServiceHash() => r'e3977f83b2dd785136a47036508b07ee966765c5';

abstract class _$WakelockService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
