enum Environment { dev, staging, prod }

extension EnvironmentExtension on Environment {
  String get fileName {
    switch (this) {
      case Environment.dev:
        return 'assets/.env.dev';
      case Environment.staging:
        return 'assets/.env.staging';
      case Environment.prod:
        return 'assets/.env.prod';
    }
  }

  String get name {
    switch (this) {
      case Environment.dev:
        return 'Development';
      case Environment.staging:
        return 'Staging';
      case Environment.prod:
        return 'Production';
    }
  }
}
