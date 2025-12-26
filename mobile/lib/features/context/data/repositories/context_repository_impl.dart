import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/context/data/datasources/context_remote_datasource.dart';
import 'package:mobile/features/context/domain/entities/context.dart';
import 'package:mobile/features/context/domain/repositories/context_repository.dart';

/// Implementation of context repository
class ContextRepositoryImpl implements ContextRepository {
  final ContextRemoteDataSource _remoteDataSource;

  ContextRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Context>>> getContexts({String? module}) async {
    try {
      final response = await _remoteDataSource.getContexts(module: module);

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to get contexts',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      final contexts = response.data.contexts
          .map((model) => Context(
                code: model.code,
                label: model.label,
                module: model.module,
              ))
          .toList();

      return Right(contexts);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'Network error occurred',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyContextCode(
    int code, {
    String? module,
  }) async {
    try {
      final result = await getContexts(module: module);

      return result.fold(
        (failure) => Left(failure),
        (contexts) {
          final exists = contexts.any((context) => context.code == code);
          return Right(exists);
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
