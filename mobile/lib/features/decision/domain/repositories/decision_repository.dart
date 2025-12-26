import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/decision/domain/entities/decision.dart';
import 'package:mobile/features/decision/domain/entities/decision_stats.dart';

/// Repository interface for Decision operations
abstract class DecisionRepository {
  /// Create a new decision
  Future<Either<Failure, Decision>> createDecision({
    required String title,
    DateTime? decidedAt,
    String? reason,
    String? expectation,
    DateTime? completedAt,
    String? actualResult,
    String? learnings,
    int? contextCode,
    List<String>? tags,
  });

  /// Get all decisions for the current user with optional filters
  Future<Either<Failure, List<Decision>>> getDecisions({
    int? page,
    int? limit,
    String? status,
    int? contextCode,
    List<String>? tags,
    DateTime? fromDate,
    DateTime? toDate,
  });

  /// Get a specific decision by ID
  Future<Either<Failure, Decision>> getDecisionById(String id);

  /// Update a decision
  Future<Either<Failure, Decision>> updateDecision({
    required String id,
    String? title,
    DateTime? decidedAt,
    String? reason,
    String? expectation,
    DateTime? completedAt,
    String? actualResult,
    String? learnings,
    int? contextCode,
    List<String>? tags,
  });

  /// Mark a decision as decided (set decidedAt to now)
  Future<Either<Failure, Decision>> markAsDecided(String id);

  /// Complete a decision with actual result and learnings
  Future<Either<Failure, Decision>> completeDecision({
    required String id,
    String? actualResult,
    String? learnings,
  });

  /// Delete a decision
  Future<Either<Failure, void>> deleteDecision(String id);

  /// Get decision statistics
  Future<Either<Failure, DecisionStats>> getStats();
}
