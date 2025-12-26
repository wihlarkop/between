import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/error/exceptions.dart';

class ActiveSessionData {
  final String sessionId;
  final DateTime startTime;

  ActiveSessionData({required this.sessionId, required this.startTime});

  Map<String, dynamic> toJson() => {
    'session_id': sessionId,
    'start_time': startTime.toIso8601String(),
  };

  factory ActiveSessionData.fromJson(Map<String, dynamic> json) {
    return ActiveSessionData(
      sessionId: json['session_id'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
    );
  }
}

class ActiveSessionDataSource {
  final SharedPreferences _prefs;

  ActiveSessionDataSource(this._prefs);

  Future<void> saveActiveSession(String sessionId, DateTime startTime) async {
    try {
      final data = ActiveSessionData(
        sessionId: sessionId,
        startTime: startTime,
      );
      final jsonString = jsonEncode(data.toJson());
      await _prefs.setString(AppConstants.activeSessionKey, jsonString);
    } catch (e) {
      throw CacheException(message: 'Failed to save active session: $e');
    }
  }

  Future<ActiveSessionData?> getActiveSession() async {
    try {
      final jsonString = _prefs.getString(AppConstants.activeSessionKey);
      if (jsonString == null) {
        return null;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return ActiveSessionData.fromJson(json);
    } catch (e) {
      throw CacheException(message: 'Failed to get active session: $e');
    }
  }

  Future<void> clearActiveSession() async {
    try {
      await _prefs.remove(AppConstants.activeSessionKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear active session: $e');
    }
  }

  Future<bool> hasActiveSession() async {
    final session = await getActiveSession();
    return session != null;
  }
}
