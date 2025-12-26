import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/decision/domain/entities/decision.dart';
import 'package:mobile/features/decision/domain/entities/decision_stats.dart';
import 'package:mobile/features/decision/domain/repositories/decision_repository.dart';
import 'package:mobile/features/decision/data/datasources/decision_api_service.dart';
import 'package:mobile/features/decision/data/models/decision_models.dart';

class DecisionRepositoryImpl implements DecisionRepository {
  final DecisionApiService _apiService;

  DecisionRepositoryImpl({required DecisionApiService apiService})
      : _apiService = apiService;

  @override
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
  }) async {
    try {
      final request = CreateDecisionRequest(
        title: title,
        decidedAt: decidedAt?.toUtc().toIso8601String(),
        reason: reason,
        expectation: expectation,
        completedAt: completedAt?.toUtc().toIso8601String(),
        actualResult: actualResult,
        learnings: learnings,
        contextCode: contextCode,
        tags: tags,
      );

      final response = await _apiService.createDecision(request);

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to create decision',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      final decision = _mapModelToEntity(response.data);
      Logger.log('Decision created: ${decision.id}', tag: 'DecisionRepo');
      return Right(decision);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Error creating decision', tag: 'DecisionRepo', error: e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Decision>>> getDecisions({
    int? page,
    int? limit,
    String? status,
    int? contextCode,
    List<String>? tags,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final response = await _apiService.getDecisions(
        page: page,
        limit: limit,
        status: status,
        contextCode: contextCode,
        tags: tags?.join(','),
        fromDate: fromDate,
        toDate: toDate,
      );

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to get decisions',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      final decisions = response.data.decisions
          .map((model) => _mapModelToEntity(model))
          .toList();

      Logger.log('Fetched ${decisions.length} decisions', tag: 'DecisionRepo');
      return Right(decisions);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Error getting decisions', tag: 'DecisionRepo', error: e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Decision>> getDecisionById(String id) async {
    try {
      final response = await _apiService.getDecisionById(id);

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to get decision',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      final decision = _mapModelToEntity(response.data);
      Logger.log('Fetched decision: ${decision.id}', tag: 'DecisionRepo');
      return Right(decision);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Error getting decision', tag: 'DecisionRepo', error: e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      final request = UpdateDecisionRequest(
        title: title,
        decidedAt: decidedAt?.toUtc().toIso8601String(),
        reason: reason,
        expectation: expectation,
        completedAt: completedAt?.toUtc().toIso8601String(),
        actualResult: actualResult,
        learnings: learnings,
        contextCode: contextCode,
        tags: tags,
      );

      final response = await _apiService.updateDecision(id, request);

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to update decision',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      final decision = _mapModelToEntity(response.data);
      Logger.log('Decision updated: ${decision.id}', tag: 'DecisionRepo');
      return Right(decision);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Error updating decision', tag: 'DecisionRepo', error: e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Decision>> markAsDecided(String id) async {
    return updateDecision(
      id: id,
      decidedAt: DateTime.now(),
    );
  }

  @override
  Future<Either<Failure, Decision>> completeDecision({
    required String id,
    String? actualResult,
    String? learnings,
  }) async {
    return updateDecision(
      id: id,
      completedAt: DateTime.now(),
      actualResult: actualResult,
      learnings: learnings,
    );
  }

  @override
  Future<Either<Failure, void>> deleteDecision(String id) async {
    try {
      final response = await _apiService.deleteDecision(id);

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to delete decision',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      Logger.log('Decision deleted: $id', tag: 'DecisionRepo');
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Error deleting decision', tag: 'DecisionRepo', error: e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DecisionStats>> getStats() async {
    try {
      final response = await _apiService.getStats();

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to get stats',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      final stats = _mapStatsModelToEntity(response.data);
      Logger.log('Fetched decision stats', tag: 'DecisionRepo');
      return Right(stats);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error('Error getting stats', tag: 'DecisionRepo', error: e);
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Helper methods
  Decision _mapModelToEntity(DecisionModel model) {
    return Decision(
      id: model.id,
      userId: model.userId ?? '',
      title: model.title,
      decidedAt: model.decidedAt != null ? DateTime.parse(model.decidedAt!) : null,
      completedAt:
          model.completedAt != null ? DateTime.parse(model.completedAt!) : null,
      reason: model.reason,
      expectation: model.expectation,
      actualResult: model.actualResult,
      learnings: model.learnings,
      contextCode: model.contextCode,
      contextLabel: model.contextLabel,
      tags: model.tags,
      createdAt: DateTime.parse(model.createdAt),
      statusString: model.status,
    );
  }

  DecisionStats _mapStatsModelToEntity(DecisionStatsModel model) {
    return DecisionStats(
      totalDecisions: model.totalDecisions,
      pendingDecisions: model.pendingDecisions,
      completedDecisions: model.completedDecisions,
      decisionsThisWeek: model.decisionsThisWeek,
      decisionsThisMonth: model.decisionsThisMonth,
      avgTimeToCompletionDays: model.avgTimeToCompletionDays,
      mostCommonContext: model.mostCommonContext != null
          ? ContextCount(
              contextCode: model.mostCommonContext!.contextCode,
              contextLabel: model.mostCommonContext!.contextLabel,
              count: model.mostCommonContext!.count,
            )
          : null,
      byMonth: model.byMonth
          .map((m) => MonthCount(month: m.month, count: m.count))
          .toList(),
      byContext: model.byContext
          .map((c) => ContextCount(
                contextCode: c.contextCode,
                contextLabel: c.contextLabel,
                count: c.count,
              ))
          .toList(),
    );
  }

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(message: 'Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkFailure(message: 'No internet connection');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        String message = 'Request failed';

        if (e.response?.data is Map<String, dynamic>) {
          message = e.response?.data['message'] ?? message;
        } else if (e.response?.data is String) {
          message = e.response?.data;
        }

        if (statusCode == 401) {
          return UnauthorizedFailure(message: message);
        } else if (statusCode == 400) {
          return ValidationFailure(
            message: message,
            errors: e.response?.data is Map<String, dynamic>
                ? e.response?.data['errors']
                : null,
          );
        } else if (statusCode == 404) {
          return NotFoundFailure(message: message);
        }
        return ServerFailure(message: message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const UnknownFailure(message: 'Request cancelled');
      default:
        return UnknownFailure(message: e.message ?? 'Unknown error occurred');
    }
  }
}
