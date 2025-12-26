// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_pagination_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActivityPagination)
const activityPaginationProvider = ActivityPaginationFamily._();

final class ActivityPaginationProvider
    extends $AsyncNotifierProvider<ActivityPagination, List<ActivityItem>> {
  const ActivityPaginationProvider._({
    required ActivityPaginationFamily super.from,
    required ({String? module, DateTime? fromDate, DateTime? toDate})
    super.argument,
  }) : super(
         retry: null,
         name: r'activityPaginationProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityPaginationHash();

  @override
  String toString() {
    return r'activityPaginationProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ActivityPagination create() => ActivityPagination();

  @override
  bool operator ==(Object other) {
    return other is ActivityPaginationProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityPaginationHash() =>
    r'2b990b8b65024a3c4e044ac60bb9cb0802cda60f';

final class ActivityPaginationFamily extends $Family
    with
        $ClassFamilyOverride<
          ActivityPagination,
          AsyncValue<List<ActivityItem>>,
          List<ActivityItem>,
          FutureOr<List<ActivityItem>>,
          ({String? module, DateTime? fromDate, DateTime? toDate})
        > {
  const ActivityPaginationFamily._()
    : super(
        retry: null,
        name: r'activityPaginationProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ActivityPaginationProvider call({
    String? module,
    DateTime? fromDate,
    DateTime? toDate,
  }) => ActivityPaginationProvider._(
    argument: (module: module, fromDate: fromDate, toDate: toDate),
    from: this,
  );

  @override
  String toString() => r'activityPaginationProvider';
}

abstract class _$ActivityPagination extends $AsyncNotifier<List<ActivityItem>> {
  late final _$args =
      ref.$arg as ({String? module, DateTime? fromDate, DateTime? toDate});
  String? get module => _$args.module;
  DateTime? get fromDate => _$args.fromDate;
  DateTime? get toDate => _$args.toDate;

  FutureOr<List<ActivityItem>> build({
    String? module,
    DateTime? fromDate,
    DateTime? toDate,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      module: _$args.module,
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
