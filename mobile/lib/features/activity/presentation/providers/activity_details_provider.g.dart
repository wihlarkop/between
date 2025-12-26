// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activityDetails)
const activityDetailsProvider = ActivityDetailsFamily._();

final class ActivityDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActivityItem>,
          ActivityItem,
          FutureOr<ActivityItem>
        >
    with $FutureModifier<ActivityItem>, $FutureProvider<ActivityItem> {
  const ActivityDetailsProvider._({
    required ActivityDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'activityDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityDetailsHash();

  @override
  String toString() {
    return r'activityDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ActivityItem> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ActivityItem> create(Ref ref) {
    final argument = this.argument as String;
    return activityDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityDetailsHash() => r'3c192ec11e9c35bb0f98d2168adc5f818f4e7ce8';

final class ActivityDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ActivityItem>, String> {
  const ActivityDetailsFamily._()
    : super(
        retry: null,
        name: r'activityDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ActivityDetailsProvider call(String activityId) =>
      ActivityDetailsProvider._(argument: activityId, from: this);

  @override
  String toString() => r'activityDetailsProvider';
}
