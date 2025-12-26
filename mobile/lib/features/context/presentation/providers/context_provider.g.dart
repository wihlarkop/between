// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for fetching contexts by module

@ProviderFor(contexts)
const contextsProvider = ContextsFamily._();

/// Provider for fetching contexts by module

final class ContextsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Context>>,
          List<Context>,
          FutureOr<List<Context>>
        >
    with $FutureModifier<List<Context>>, $FutureProvider<List<Context>> {
  /// Provider for fetching contexts by module
  const ContextsProvider._({
    required ContextsFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'contextsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contextsHash();

  @override
  String toString() {
    return r'contextsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Context>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Context>> create(Ref ref) {
    final argument = this.argument as String?;
    return contexts(ref, module: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ContextsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contextsHash() => r'9167b20d9ccec9f22adabf07a03dffa68c67df3d';

/// Provider for fetching contexts by module

final class ContextsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Context>>, String?> {
  const ContextsFamily._()
    : super(
        retry: null,
        name: r'contextsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for fetching contexts by module

  ContextsProvider call({String? module}) =>
      ContextsProvider._(argument: module, from: this);

  @override
  String toString() => r'contextsProvider';
}
