/// Module identifier constants
///
/// Centralized constants for module IDs used across the app.
/// Use these instead of hardcoded strings to avoid typos and ensure consistency.
class ModuleConstants {
  // Module IDs
  static const String silence = 'silence';
  static const String decision = 'decision';
  static const String breathe = 'breathe'; // Future module
  static const String connect = 'connect'; // Future module

  // Module display names
  static const String silenceName = 'Silence';
  static const String decisionName = 'Decision';
  static const String breatheName = 'Breathe';
  static const String connectName = 'Connect';

  // All modules filter
  static const String allModules = 'all_modules';
  static const String allModulesName = 'All Modules';

  /// Get display name for a module ID
  static String getDisplayName(String moduleId) {
    switch (moduleId) {
      case silence:
        return silenceName;
      case decision:
        return decisionName;
      case breathe:
        return breatheName;
      case connect:
        return connectName;
      case allModules:
        return allModulesName;
      default:
        return moduleId;
    }
  }

  /// Prevent instantiation
  ModuleConstants._();
}
