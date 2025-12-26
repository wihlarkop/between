// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeSessionDataSource)
const activeSessionDataSourceProvider = ActiveSessionDataSourceProvider._();

final class ActiveSessionDataSourceProvider
    extends
        $FunctionalProvider<
          ActiveSessionDataSource,
          ActiveSessionDataSource,
          ActiveSessionDataSource
        >
    with $Provider<ActiveSessionDataSource> {
  const ActiveSessionDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeSessionDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeSessionDataSourceHash();

  @$internal
  @override
  $ProviderElement<ActiveSessionDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ActiveSessionDataSource create(Ref ref) {
    return activeSessionDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActiveSessionDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActiveSessionDataSource>(value),
    );
  }
}

String _$activeSessionDataSourceHash() =>
    r'7a3576415c1a18f1bfc1ca1e221dd2c95a95ceb9';

@ProviderFor(sessionCacheDataSource)
const sessionCacheDataSourceProvider = SessionCacheDataSourceProvider._();

final class SessionCacheDataSourceProvider
    extends
        $FunctionalProvider<
          SessionCacheDataSource,
          SessionCacheDataSource,
          SessionCacheDataSource
        >
    with $Provider<SessionCacheDataSource> {
  const SessionCacheDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionCacheDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionCacheDataSourceHash();

  @$internal
  @override
  $ProviderElement<SessionCacheDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SessionCacheDataSource create(Ref ref) {
    return sessionCacheDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionCacheDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionCacheDataSource>(value),
    );
  }
}

String _$sessionCacheDataSourceHash() =>
    r'02b1a528eb8cb69b447bfb3a12b729dad263153e';

@ProviderFor(silenceApiService)
const silenceApiServiceProvider = SilenceApiServiceProvider._();

final class SilenceApiServiceProvider
    extends
        $FunctionalProvider<
          SilenceApiService,
          SilenceApiService,
          SilenceApiService
        >
    with $Provider<SilenceApiService> {
  const SilenceApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'silenceApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$silenceApiServiceHash();

  @$internal
  @override
  $ProviderElement<SilenceApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SilenceApiService create(Ref ref) {
    return silenceApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SilenceApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SilenceApiService>(value),
    );
  }
}

String _$silenceApiServiceHash() => r'bed7e897d5210bd3edf72d99d42c0e379a35dfe4';

@ProviderFor(silenceRepository)
const silenceRepositoryProvider = SilenceRepositoryProvider._();

final class SilenceRepositoryProvider
    extends
        $FunctionalProvider<
          SilenceRepository,
          SilenceRepository,
          SilenceRepository
        >
    with $Provider<SilenceRepository> {
  const SilenceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'silenceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$silenceRepositoryHash();

  @$internal
  @override
  $ProviderElement<SilenceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SilenceRepository create(Ref ref) {
    return silenceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SilenceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SilenceRepository>(value),
    );
  }
}

String _$silenceRepositoryHash() => r'65453ac19beb32187a56d2bd40906fcced57ea73';
