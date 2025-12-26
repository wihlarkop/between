// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Activity API service provider

@ProviderFor(activityApiService)
const activityApiServiceProvider = ActivityApiServiceProvider._();

/// Activity API service provider

final class ActivityApiServiceProvider
    extends
        $FunctionalProvider<
          ActivityApiService,
          ActivityApiService,
          ActivityApiService
        >
    with $Provider<ActivityApiService> {
  /// Activity API service provider
  const ActivityApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityApiServiceHash();

  @$internal
  @override
  $ProviderElement<ActivityApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ActivityApiService create(Ref ref) {
    return activityApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActivityApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActivityApiService>(value),
    );
  }
}

String _$activityApiServiceHash() =>
    r'2f269256f89e4aadc58a5221e8e728a4d86d005e';

/// Activity repository provider

@ProviderFor(activityRepository)
const activityRepositoryProvider = ActivityRepositoryProvider._();

/// Activity repository provider

final class ActivityRepositoryProvider
    extends
        $FunctionalProvider<
          ActivityRepository,
          ActivityRepository,
          ActivityRepository
        >
    with $Provider<ActivityRepository> {
  /// Activity repository provider
  const ActivityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityRepositoryHash();

  @$internal
  @override
  $ProviderElement<ActivityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ActivityRepository create(Ref ref) {
    return activityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActivityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActivityRepository>(value),
    );
  }
}

String _$activityRepositoryHash() =>
    r'5b43c475ba116b222f77823d98e642fc514191eb';

/// Provider for recent activities (limit 3)

@ProviderFor(recentActivities)
const recentActivitiesProvider = RecentActivitiesProvider._();

/// Provider for recent activities (limit 3)

final class RecentActivitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityItem>>,
          List<ActivityItem>,
          FutureOr<List<ActivityItem>>
        >
    with
        $FutureModifier<List<ActivityItem>>,
        $FutureProvider<List<ActivityItem>> {
  /// Provider for recent activities (limit 3)
  const RecentActivitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentActivitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentActivitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityItem>> create(Ref ref) {
    return recentActivities(ref);
  }
}

String _$recentActivitiesHash() => r'a35bfd9b4afbf24324f7ae068b2332fa33590a73';

/// Provider for activities with filters

@ProviderFor(ActivityList)
const activityListProvider = ActivityListFamily._();

/// Provider for activities with filters
final class ActivityListProvider
    extends $AsyncNotifierProvider<ActivityList, List<ActivityItem>> {
  /// Provider for activities with filters
  const ActivityListProvider._({
    required ActivityListFamily super.from,
    required ({
      String? module,
      int page,
      int limit,
      DateTime? fromDate,
      DateTime? toDate,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'activityListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityListHash();

  @override
  String toString() {
    return r'activityListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ActivityList create() => ActivityList();

  @override
  bool operator ==(Object other) {
    return other is ActivityListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityListHash() => r'6d8825a19616f308955e83666953f0f8dc416c6c';

/// Provider for activities with filters

final class ActivityListFamily extends $Family
    with
        $ClassFamilyOverride<
          ActivityList,
          AsyncValue<List<ActivityItem>>,
          List<ActivityItem>,
          FutureOr<List<ActivityItem>>,
          ({
            String? module,
            int page,
            int limit,
            DateTime? fromDate,
            DateTime? toDate,
          })
        > {
  const ActivityListFamily._()
    : super(
        retry: null,
        name: r'activityListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for activities with filters

  ActivityListProvider call({
    String? module,
    int page = 1,
    int limit = 20,
    DateTime? fromDate,
    DateTime? toDate,
  }) => ActivityListProvider._(
    argument: (
      module: module,
      page: page,
      limit: limit,
      fromDate: fromDate,
      toDate: toDate,
    ),
    from: this,
  );

  @override
  String toString() => r'activityListProvider';
}

/// Provider for activities with filters

abstract class _$ActivityList extends $AsyncNotifier<List<ActivityItem>> {
  late final _$args =
      ref.$arg
          as ({
            String? module,
            int page,
            int limit,
            DateTime? fromDate,
            DateTime? toDate,
          });
  String? get module => _$args.module;
  int get page => _$args.page;
  int get limit => _$args.limit;
  DateTime? get fromDate => _$args.fromDate;
  DateTime? get toDate => _$args.toDate;

  FutureOr<List<ActivityItem>> build({
    String? module,
    int page = 1,
    int limit = 20,
    DateTime? fromDate,
    DateTime? toDate,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      module: _$args.module,
      page: _$args.page,
      limit: _$args.limit,
      fromDate: _$args.fromDate,
      toDate: _$args.toDate,
    );
    final ref =
        this.ref as $Ref<AsyncValue<List<ActivityItem>>, List<ActivityItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ActivityItem>>, List<ActivityItem>>,
              AsyncValue<List<ActivityItem>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider for activity statistics

@ProviderFor(activityStats)
const activityStatsProvider = ActivityStatsFamily._();

/// Provider for activity statistics

final class ActivityStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActivityStatsResponse>,
          ActivityStatsResponse,
          FutureOr<ActivityStatsResponse>
        >
    with
        $FutureModifier<ActivityStatsResponse>,
        $FutureProvider<ActivityStatsResponse> {
  /// Provider for activity statistics
  const ActivityStatsProvider._({
    required ActivityStatsFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'activityStatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityStatsHash();

  @override
  String toString() {
    return r'activityStatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ActivityStatsResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ActivityStatsResponse> create(Ref ref) {
    final argument = this.argument as String?;
    return activityStats(ref, module: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityStatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityStatsHash() => r'231a894a76412913b16915a3ba8bebcb27fdd262';

/// Provider for activity statistics

final class ActivityStatsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ActivityStatsResponse>, String?> {
  const ActivityStatsFamily._()
    : super(
        retry: null,
        name: r'activityStatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for activity statistics

  ActivityStatsProvider call({String? module}) =>
      ActivityStatsProvider._(argument: module, from: this);

  @override
  String toString() => r'activityStatsProvider';
}
