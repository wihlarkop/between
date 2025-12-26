// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the currently selected module filter in Insights screen
///
/// null = "All Modules"
/// 'silence' = Silence module only
/// 'decision' = Decision module only
/// etc.

@ProviderFor(SelectedModuleFilter)
const selectedModuleFilterProvider = SelectedModuleFilterProvider._();

/// Provider for the currently selected module filter in Insights screen
///
/// null = "All Modules"
/// 'silence' = Silence module only
/// 'decision' = Decision module only
/// etc.
final class SelectedModuleFilterProvider
    extends $NotifierProvider<SelectedModuleFilter, String?> {
  /// Provider for the currently selected module filter in Insights screen
  ///
  /// null = "All Modules"
  /// 'silence' = Silence module only
  /// 'decision' = Decision module only
  /// etc.
  const SelectedModuleFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedModuleFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedModuleFilterHash();

  @$internal
  @override
  SelectedModuleFilter create() => SelectedModuleFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedModuleFilterHash() =>
    r'47f557c56ad458dcc40c344b2cdba29dfae8295a';

/// Provider for the currently selected module filter in Insights screen
///
/// null = "All Modules"
/// 'silence' = Silence module only
/// 'decision' = Decision module only
/// etc.

abstract class _$SelectedModuleFilter extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
