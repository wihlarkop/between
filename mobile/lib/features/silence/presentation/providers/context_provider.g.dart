// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ContextNotifier)
const contextProvider = ContextNotifierProvider._();

final class ContextNotifierProvider
    extends $NotifierProvider<ContextNotifier, ContextState> {
  const ContextNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contextNotifierHash();

  @$internal
  @override
  ContextNotifier create() => ContextNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContextState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContextState>(value),
    );
  }
}

String _$contextNotifierHash() => r'3b7319ea5e85d7aaa1620229e7987a129624ef57';

abstract class _$ContextNotifier extends $Notifier<ContextState> {
  ContextState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ContextState, ContextState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ContextState, ContextState>,
              ContextState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
