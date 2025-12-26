// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SessionHistory)
const sessionHistoryProvider = SessionHistoryProvider._();

final class SessionHistoryProvider
    extends $AsyncNotifierProvider<SessionHistory, List<SilenceSession>> {
  const SessionHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionHistoryHash();

  @$internal
  @override
  SessionHistory create() => SessionHistory();
}

String _$sessionHistoryHash() => r'19c83e41b92a23a9fdc6795dda9d305ab278d31b';

abstract class _$SessionHistory extends $AsyncNotifier<List<SilenceSession>> {
  FutureOr<List<SilenceSession>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<SilenceSession>>, List<SilenceSession>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SilenceSession>>,
                List<SilenceSession>
              >,
              AsyncValue<List<SilenceSession>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
