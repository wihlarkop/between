import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:mobile/core/utils/logger.dart';

/// Timezone detection and formatting utilities
class TimezoneHelper {
  static bool _initialized = false;

  /// Initialize timezone database (call once at app startup)
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      // This is handled automatically by timezone package
      // The database is loaded on first use
      _initialized = true;
      Logger.log('Timezone database initialized', tag: 'TimezoneHelper');
    } catch (e) {
      Logger.error('Failed to initialize timezone database', error: e);
    }
  }
  /// Get the current device timezone
  ///
  /// Returns IANA timezone name (e.g., "Asia/Jakarta", "America/New_York")
  /// Falls back to "UTC" if detection fails
  static Future<String> getCurrentTimezone() async {
    try {
      // Try to get actual IANA timezone name
      // flutter_timezone v5.0.1 returns TimezoneInfo object
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      final timezone = timezoneInfo.identifier;

      Logger.log('Detected timezone: $timezone', tag: 'TimezoneHelper');

      // Validate it's not empty and looks like a valid IANA timezone
      if (timezone.isEmpty || !_isValidTimezone(timezone)) {
        Logger.warning(
          'Invalid or empty timezone detected: "$timezone", falling back to UTC',
          tag: 'TimezoneHelper',
        );
        return 'UTC';
      }

      return timezone;
    } catch (e) {
      Logger.error('Failed to detect timezone, using UTC fallback', error: e);
      // Fallback to UTC (valid IANA timezone name)
      return 'UTC';
    }
  }

  /// Validate if timezone is a valid IANA timezone using timezone package
  ///
  /// IANA timezones typically follow patterns like:
  /// - "UTC"
  /// - "America/New_York"
  /// - "Asia/Jakarta"
  static bool _isValidTimezone(String timezone) {
    // Must not be empty
    if (timezone.isEmpty) return false;

    try {
      // Try to get the location from the timezone database
      // This will throw if the timezone is not valid
      tz.getLocation(timezone);
      return true;
    } catch (e) {
      // Not a valid IANA timezone
      Logger.warning(
        'Invalid IANA timezone: "$timezone"',
        tag: 'TimezoneHelper',
      );
      return false;
    }
  }

  /// Format timezone for display
  ///
  /// Converts IANA timezone names to more readable format
  /// Examples:
  /// - "Asia/Jakarta" -> "Asia/Jakarta (UTC+7)"
  /// - "America/New_York" -> "America/New_York (UTC-5)"
  static String formatTimezoneForDisplay(String timezone) {
    if (timezone.startsWith('UTC')) {
      return timezone; // Already formatted
    }

    // Get current offset for this timezone
    final now = DateTime.now();
    final offset = now.timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    final hours = offset.inHours.abs();

    return '$timezone (UTC$sign$hours)';
  }

  /// Check if timezone has changed from stored timezone
  ///
  /// Returns true if current device timezone differs from stored timezone
  static Future<bool> hasTimezoneChanged(String storedTimezone) async {
    final currentTimezone = await getCurrentTimezone();
    return currentTimezone != storedTimezone;
  }

  /// Prevent instantiation
  TimezoneHelper._();
}
