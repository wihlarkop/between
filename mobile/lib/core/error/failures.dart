import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  final String? errorCode;

  const ServerFailure({
    required super.message,
    this.statusCode,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, statusCode, errorCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Failed to load cached data'});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'Unauthorized access'});
}

class ValidationFailure extends Failure {
  final Map<String, dynamic>? errors;

  const ValidationFailure({required super.message, this.errors});

  @override
  List<Object?> get props => [message, errors];
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unknown error occurred'});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Resource not found'});
}
