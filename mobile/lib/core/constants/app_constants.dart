class AppConstants {
  // App info
  static const String appName = 'Between';
  static const String appVersion = '1.0.0';

  // Session constraints
  static const int minSessionDurationSeconds = 5;
  static const int maxSessionDurationSeconds = 21600; // 6 hours
  static const int maxSessionDurationWarningSeconds = 20700; // 5h 45m

  // Context constraints
  static const int maxContextNoteLength = 500;

  // Silence context codes
  static const int contextAlone = 1;
  static const int contextWaiting = 2;
  static const int contextWalking = 3;
  static const int contextThinking = 4;
  static const int contextEmpty = 5;

  // Pagination
  static const int defaultPageLimit = 50;
  static const int defaultPageOffset = 0;

  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String activeSessionKey = 'active_session';
  static const String sessionHistoryCacheKey = 'session_history_cache';
  static const String sessionStatsCacheKey = 'session_stats_cache';

  // Timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Timer
  static const Duration timerTickDuration = Duration(seconds: 1);
}
