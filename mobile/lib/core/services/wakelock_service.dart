import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'dart:developer' as dev;

part 'wakelock_service.g.dart';

@riverpod
class WakelockService extends _$WakelockService {
  @override
  void build() {
    // Initialization if needed
  }

  Future<void> enable() async {
    try {
      dev.log('[WakelockService] Enabling wake lock', name: 'WakelockService');
      await WakelockPlus.enable();
    } catch (e) {
      dev.log(
        '[WakelockService] Error enabling wake lock: $e',
        name: 'WakelockService',
        error: e,
      );
    }
  }

  Future<void> disable() async {
    try {
      dev.log('[WakelockService] Disabling wake lock', name: 'WakelockService');
      await WakelockPlus.disable();
    } catch (e) {
      dev.log(
        '[WakelockService] Error disabling wake lock: $e',
        name: 'WakelockService',
        error: e,
      );
    }
  }

  Future<void> toggle(bool enabled) async {
    if (enabled) {
      await enable();
    } else {
      await disable();
    }
  }
}
