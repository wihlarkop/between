import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/stats/domain/entities/session_stats.dart';
import 'package:mobile/features/silence/domain/entities/silence_session.dart';
import 'package:mobile/features/silence/domain/repositories/silence_repository.dart';
import 'package:mobile/core/data/datasources/local/session_cache_data_source.dart';
import 'package:mobile/features/silence/data/datasources/silence_remote_datasource.dart';
import 'package:mobile/features/stats/data/models/session_stats_model.dart';
import 'package:mobile/features/silence/data/models/silence_session_model.dart';

class SilenceRepositoryImpl implements SilenceRepository {
  final SilenceApiService _apiService;
  final SessionCacheDataSource _cacheDataSource;

  SilenceRepositoryImpl({
    required SilenceApiService apiService,
    required SessionCacheDataSource cacheDataSource,
  }) : _apiService = apiService,
       _cacheDataSource = cacheDataSource;

  @override
  Future<Either<Failure, SilenceSession>> startSession() async {
    try {
      final response = await _apiService.startSession();

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to start session',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      final session = _mapSessionModelToEntity(response.data);
      Logger.log('Session started: ${session.id}', tag: 'SilenceRepo');
      return Right(session);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error(
        'Unexpected error starting session',
        tag: 'SilenceRepo',
        error: e,
      );
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SilenceSession>> endSession({
    String? terminationReason,
  }) async {
    try {
      final response = await _apiService.endSession(
        terminationReason: terminationReason,
      );

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to end session',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      final session = _mapSessionModelToEntity(response.data);
      Logger.log(
        'Session ended: ${session.id}, duration: ${session.durationSeconds}s',
        tag: 'SilenceRepo',
      );

      // Refresh cache after ending session
      _refreshSessionCache();

      return Right(session);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error(
        'Unexpected error ending session',
        tag: 'SilenceRepo',
        error: e,
      );
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> attachContext({
    required String sessionId,
    required int contextCode,
    String? contextNote,
  }) async {
    try {
      final request = AttachContextRequest(
        contextCode: contextCode,
        contextNote: contextNote,
      );

      final response = await _apiService.attachContext(sessionId, request);

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to attach context',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      Logger.log('Context attached to session: $sessionId', tag: 'SilenceRepo');

      // Refresh cache after attaching context
      _refreshSessionCache();

      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error(
        'Unexpected error attaching context',
        tag: 'SilenceRepo',
        error: e,
      );
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SilenceSession>>> getSessionHistory({
    int? limit,
    int? offset,
  }) async {
    try {
      final response = await _apiService.getSessions(
        limit: limit,
        offset: offset,
      );

      if (!response.success) {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to get session history',
            statusCode: response.statusCode,
            errorCode: response.errorCode,
          ),
        );
      }

      final sessions = response.data.sessions
          .map((model) => _mapSessionModelToEntity(model))
          .toList();

      // Cache the sessions
      await _cacheDataSource.cacheSessionHistory(response.data.sessions);

      Logger.log('Fetched ${sessions.length} sessions', tag: 'SilenceRepo');
      return Right(sessions);
    } on DioException catch (e) {
      Logger.warning(
        'Failed to fetch sessions from API, trying cache',
        tag: 'SilenceRepo',
      );
      // Try to return cached data on network error
      final cachedSessions = await getCachedSessionHistory();
      if (cachedSessions.isNotEmpty) {
        return Right(cachedSessions);
      }
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error(
        'Unexpected error getting session history',
        tag: 'SilenceRepo',
        error: e,
      );
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SessionStats>> getStats() async {
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

      // Cache the stats
      await _cacheDataSource.cacheSessionStats(response.data);

      Logger.log('Fetched session stats', tag: 'SilenceRepo');
      return Right(stats);
    } on DioException catch (e) {
      Logger.warning(
        'Failed to fetch stats from API, trying cache',
        tag: 'SilenceRepo',
      );
      // Try to return cached data on network error
      final cachedStats = await getCachedStats();
      if (cachedStats != null) {
        return Right(cachedStats);
      }
      return Left(_handleDioException(e));
    } catch (e) {
      Logger.error(
        'Unexpected error getting stats',
        tag: 'SilenceRepo',
        error: e,
      );
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<List<SilenceSession>> getCachedSessionHistory() async {
    try {
      final cachedModels = await _cacheDataSource.getCachedSessionHistory();
      return cachedModels
          .map((model) => _mapSessionModelToEntity(model))
          .toList();
    } catch (e) {
      Logger.error(
        'Error getting cached session history',
        tag: 'SilenceRepo',
        error: e,
      );
      return [];
    }
  }

  @override
  Future<SessionStats?> getCachedStats() async {
    try {
      final cachedModel = await _cacheDataSource.getCachedSessionStats();
      if (cachedModel == null) return null;
      return _mapStatsModelToEntity(cachedModel);
    } catch (e) {
      Logger.error('Error getting cached stats', tag: 'SilenceRepo', error: e);
      return null;
    }
  }

  // Helper methods
  void _refreshSessionCache() {
    // Asynchronously refresh the cache without blocking
    getSessionHistory().then((result) {
      result.fold(
        (failure) => Logger.warning(
          'Failed to refresh cache: ${failure.message}',
          tag: 'SilenceRepo',
        ),
        (sessions) => Logger.log(
          'Cache refreshed with ${sessions.length} sessions',
          tag: 'SilenceRepo',
        ),
      );
    });
  }

  SilenceSession _mapSessionModelToEntity(SilenceSessionModel model) {
    return SilenceSession(
      id: model.id,
      userId: model.userId ?? '',
      startedAt: DateTime.parse(model.startedAt),
      endedAt: model.endedAt != null ? DateTime.parse(model.endedAt!) : null,
      durationSeconds: model.durationSeconds,
      contextCode: model.contextCode,
      contextLabel: model.contextLabel,
      contextNote: model.contextNote,
      terminationReason: model.terminationReason,
      createdAt: DateTime.parse(model.startedAt),
    );
  }

  SessionStats _mapStatsModelToEntity(SessionStatsModel model) {
    return SessionStats(
      totalSessions: model.totalSessions,
      totalSilenceSeconds: model.totalDurationSeconds,
      averageDurationSeconds: model.averageDurationSeconds.toDouble(),
      longestSessionSeconds: model.longestSessionSeconds,
      shortestSessionSeconds: model.shortestSessionSeconds,
      mostCommonContext: model.mostCommonContext?.label,
      mostCommonHour: null,
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
        }
        return ServerFailure(message: message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const UnknownFailure(message: 'Request cancelled');
      default:
        return UnknownFailure(message: e.message ?? 'Unknown error occurred');
    }
  }
}
