import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/config/env/env_config.dart';

class Env {
  static Environment _currentEnvironment = Environment.dev;

  static Environment get currentEnvironment => _currentEnvironment;

  static Future<void> load({Environment environment = Environment.dev}) async {
    _currentEnvironment = environment;
    await dotenv.load(fileName: environment.fileName);
  }

  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';

  static int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;

  static bool get isDevelopment => _currentEnvironment == Environment.dev;
  static bool get isStaging => _currentEnvironment == Environment.staging;
  static bool get isProduction => _currentEnvironment == Environment.prod;
}
