class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;

  ServerException({required this.message, this.statusCode, this.errorCode});

  @override
  String toString() =>
      'ServerException: $message (status: $statusCode, code: $errorCode)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({this.message = 'Unauthorized'});

  @override
  String toString() => 'UnauthorizedException: $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, dynamic>? errors;

  ValidationException({required this.message, this.errors});

  @override
  String toString() => 'ValidationException: $message';
}
