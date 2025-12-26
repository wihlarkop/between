import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/context/domain/entities/context.dart';

/// Repository interface for context operations
abstract class ContextRepository {
  /// Get all contexts, optionally filtered by module
  /// [module] - Filter by module (e.g., 'silence', 'decision', or null for all)
  Future<Either<Failure, List<Context>>> getContexts({String? module});

  /// Verify if a context code is valid for a specific module
  Future<Either<Failure, bool>> verifyContextCode(int code, {String? module});
}
