// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_filters_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActivityDateRangeFilter)
const activityDateRangeFilterProvider = ActivityDateRangeFilterProvider._();

final class ActivityDateRangeFilterProvider
    extends
        $NotifierProvider<ActivityDateRangeFilter, DateTimeRange<DateTime>?> {
  const ActivityDateRangeFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityDateRangeFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityDateRangeFilterHash();

  @$internal
  @override
  ActivityDateRangeFilter create() => ActivityDateRangeFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTimeRange<DateTime>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTimeRange<DateTime>?>(value),
    );
  }
}

String _$activityDateRangeFilterHash() =>
    r'8145ba5ddef35726b11d2e1507a0775233b6e830';

abstract class _$ActivityDateRangeFilter
    extends $Notifier<DateTimeRange<DateTime>?> {
  DateTimeRange<DateTime>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<DateTimeRange<DateTime>?, DateTimeRange<DateTime>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTimeRange<DateTime>?, DateTimeRange<DateTime>?>,
              DateTimeRange<DateTime>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
