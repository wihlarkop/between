class ApiConstants {
  // Base
  static const String apiPrefix = '/api';

  // Auth endpoints
  static const String authPrefix = '$apiPrefix/auth';
  static const String register = '$authPrefix/register';
  static const String login = '$authPrefix/login';
  static const String refreshToken = '$authPrefix/refresh-token';

  // Profile endpoints
  static const String profilePrefix = '$apiPrefix/profile';
  static const String updateProfile = profilePrefix;
  static const String me = '$profilePrefix/me';

  // Silence endpoints
  static const String silencePrefix = '$apiPrefix/silence';
  static const String startSession = '$silencePrefix/start';
  static const String endSession = '$silencePrefix/end';
  static const String sessions = '$silencePrefix/sessions';
  static const String sessionContext = '$silencePrefix/sessions/{id}/context';
  static const String stats = '$silencePrefix/stats';

  // Context endpoints (shared across modules)
  static const String contexts = '$apiPrefix/contexts';

  // Decision endpoints
  static const String decisionPrefix = '$apiPrefix/decisions';
  static const String decisions = decisionPrefix;
  static const String decisionById = '$decisionPrefix/{id}';
  static const String decisionStats = '$decisionPrefix/stats';

  // Health endpoint
  static const String health = '/health';

  // Headers
  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String contentTypeJson = 'application/json';
}
