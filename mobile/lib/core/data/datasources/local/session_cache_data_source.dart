import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/error/exceptions.dart';
import 'package:mobile/features/stats/data/models/session_stats_model.dart';
import 'package:mobile/features/silence/data/models/silence_session_model.dart';

class SessionCacheDataSource {
  final SharedPreferences _prefs;

  SessionCacheDataSource(this._prefs);

  Future<void> cacheSessionHistory(List<SilenceSessionModel> sessions) async {
    try {
      final jsonList = sessions.map((s) => s.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await _prefs.setString(AppConstants.sessionHistoryCacheKey, jsonString);
    } catch (e) {
      throw CacheException(message: 'Failed to cache session history: $e');
    }
  }

  Future<List<SilenceSessionModel>> getCachedSessionHistory() async {
    try {
      final jsonString = _prefs.getString(AppConstants.sessionHistoryCacheKey);
      if (jsonString == null) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map(
            (json) =>
                SilenceSessionModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw CacheException(message: 'Failed to get cached session history: $e');
    }
  }

  Future<void> clearSessionHistoryCache() async {
    try {
      await _prefs.remove(AppConstants.sessionHistoryCacheKey);
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear session history cache: $e',
      );
    }
  }

  Future<void> cacheSessionStats(SessionStatsModel stats) async {
    try {
      final jsonString = jsonEncode(stats.toJson());
      await _prefs.setString(AppConstants.sessionStatsCacheKey, jsonString);
    } catch (e) {
      throw CacheException(message: 'Failed to cache session stats: $e');
    }
  }

  Future<SessionStatsModel?> getCachedSessionStats() async {
    try {
      final jsonString = _prefs.getString(AppConstants.sessionStatsCacheKey);
      if (jsonString == null) {
        return null;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SessionStatsModel.fromJson(json);
    } catch (e) {
      throw CacheException(message: 'Failed to get cached session stats: $e');
    }
  }

  Future<void> clearSessionStatsCache() async {
    try {
      await _prefs.remove(AppConstants.sessionStatsCacheKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear session stats cache: $e');
    }
  }

  Future<void> clearAllCache() async {
    await clearSessionHistoryCache();
    await clearSessionStatsCache();
  }
}
