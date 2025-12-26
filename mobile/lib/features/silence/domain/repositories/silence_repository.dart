import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/silence/domain/entities/silence_session.dart';
import 'package:mobile/features/stats/domain/entities/session_stats.dart';

abstract class SilenceRepository {
  /// Start a new silence session
  Future<Either<Failure, SilenceSession>> startSession();

  /// End the current active silence session
  Future<Either<Failure, SilenceSession>> endSession({
    String? terminationReason,
  });

  /// Attach context to a completed session
  Future<Either<Failure, void>> attachContext({
    required String sessionId,
    required int contextCode,
    String? contextNote,
  });

  /// Get session history with pagination
  Future<Either<Failure, List<SilenceSession>>> getSessionHistory({
    int? limit,
    int? offset,
  });

  /// Get session statistics
  Future<Either<Failure, SessionStats>> getStats();

  /// Get cached session history (offline)
  Future<List<SilenceSession>> getCachedSessionHistory();

  /// Get cached stats (offline)
  Future<SessionStats?> getCachedStats();
}
