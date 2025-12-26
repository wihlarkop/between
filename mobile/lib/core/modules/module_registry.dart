import 'package:mobile/core/modules/module_config.dart';

/// Singleton registry for managing all available modules in the app
///
/// Modules register themselves at app startup (in main.dart) and the registry
/// provides access to them throughout the app (e.g., for the module grid).
class ModuleRegistry {
  // Singleton pattern
  static final ModuleRegistry _instance = ModuleRegistry._internal();

  factory ModuleRegistry() => _instance;

  ModuleRegistry._internal();

  // Internal list of registered modules
  final List<ModuleConfig> _modules = [];

  /// Register a new module
  ///
  /// Prevents duplicate registrations - if a module with the same ID
  /// is already registered, it won't be added again.
  void register(ModuleConfig module) {
    if (!_modules.any((m) => m.id == module.id)) {
      _modules.add(module);
    }
  }

  /// Get all registered modules
  ///
  /// Returns an unmodifiable list to prevent external modifications
  List<ModuleConfig> getAll() => List.unmodifiable(_modules);

  /// Get a specific module by ID
  ///
  /// Returns null if no module with the given ID is found
  ModuleConfig? getById(String id) {
    try {
      return _modules.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Check if a module is registered
  bool isRegistered(String id) => _modules.any((m) => m.id == id);

  /// Get the number of registered modules
  int get count => _modules.length;

  /// Clear all modules (mainly for testing)
  void clear() => _modules.clear();
}
