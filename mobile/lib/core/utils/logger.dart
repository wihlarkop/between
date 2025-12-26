import 'package:flutter/foundation.dart';

class Logger {
  static void log(String message, {String? tag}) {
    if (kDebugMode) {
      final prefix = tag != null ? '[$tag]' : '[LOG]';
      print('$prefix $message');
    }
  }

  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      final prefix = tag != null ? '[$tag]' : '[ERROR]';
      print('$prefix $message');
      if (error != null) {
        print('Error: $error');
      }
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
  }

  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      final prefix = tag != null ? '[$tag]' : '[WARNING]';
      print('$prefix $message');
    }
  }

  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      final prefix = tag != null ? '[$tag]' : '[DEBUG]';
      print('$prefix $message');
    }
  }
}
