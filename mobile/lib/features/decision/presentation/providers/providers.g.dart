// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(decisionApiService)
const decisionApiServiceProvider = DecisionApiServiceProvider._();

final class DecisionApiServiceProvider
    extends
        $FunctionalProvider<
          DecisionApiService,
          DecisionApiService,
          DecisionApiService
        >
    with $Provider<DecisionApiService> {
  const DecisionApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'decisionApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$decisionApiServiceHash();

  @$internal
  @override
  $ProviderElement<DecisionApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DecisionApiService create(Ref ref) {
    return decisionApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DecisionApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DecisionApiService>(value),
    );
  }
}

String _$decisionApiServiceHash() =>
    r'7c98b91697f72a131ae20e4d169528f092c9bb99';

@ProviderFor(decisionRepository)
const decisionRepositoryProvider = DecisionRepositoryProvider._();

final class DecisionRepositoryProvider
    extends
        $FunctionalProvider<
          DecisionRepository,
          DecisionRepository,
          DecisionRepository
        >
    with $Provider<DecisionRepository> {
  const DecisionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'decisionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$decisionRepositoryHash();

  @$internal
  @override
  $ProviderElement<DecisionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DecisionRepository create(Ref ref) {
    return decisionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DecisionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DecisionRepository>(value),
    );
  }
}

String _$decisionRepositoryHash() =>
    r'b34aff2e5d7c1e1cf22bbb1bcee60a9902c416b7';
