/// Application-wide constants.
class AppConstants {
  // Context note max length
  static const int maxContextNoteLength = 500;

  // Session constraints
  static const int minSessionDurationSeconds = 5;
  static const int maxSessionDurationSeconds = 21600; // 6 hours

  // Pagination
  static const int defaultPageSize = 50;

  // Prevent instantiation
  AppConstants._();
}
