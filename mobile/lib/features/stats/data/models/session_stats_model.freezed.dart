// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionStatsModel {

@JsonKey(name: 'total_sessions') int get totalSessions;@JsonKey(name: 'total_duration_seconds') int get totalDurationSeconds;@JsonKey(name: 'average_duration_seconds') int get averageDurationSeconds;@JsonKey(name: 'longest_session_seconds') int? get longestSessionSeconds;@JsonKey(name: 'shortest_session_seconds') int? get shortestSessionSeconds;@JsonKey(name: 'most_common_context') ContextCountModel? get mostCommonContext;
/// Create a copy of SessionStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStatsModelCopyWith<SessionStatsModel> get copyWith => _$SessionStatsModelCopyWithImpl<SessionStatsModel>(this as SessionStatsModel, _$identity);

  /// Serializes this SessionStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStatsModel&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.averageDurationSeconds, averageDurationSeconds) || other.averageDurationSeconds == averageDurationSeconds)&&(identical(other.longestSessionSeconds, longestSessionSeconds) || other.longestSessionSeconds == longestSessionSeconds)&&(identical(other.shortestSessionSeconds, shortestSessionSeconds) || other.shortestSessionSeconds == shortestSessionSeconds)&&(identical(other.mostCommonContext, mostCommonContext) || other.mostCommonContext == mostCommonContext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSessions,totalDurationSeconds,averageDurationSeconds,longestSessionSeconds,shortestSessionSeconds,mostCommonContext);

@override
String toString() {
  return 'SessionStatsModel(totalSessions: $totalSessions, totalDurationSeconds: $totalDurationSeconds, averageDurationSeconds: $averageDurationSeconds, longestSessionSeconds: $longestSessionSeconds, shortestSessionSeconds: $shortestSessionSeconds, mostCommonContext: $mostCommonContext)';
}


}

/// @nodoc
abstract mixin class $SessionStatsModelCopyWith<$Res>  {
  factory $SessionStatsModelCopyWith(SessionStatsModel value, $Res Function(SessionStatsModel) _then) = _$SessionStatsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_sessions') int totalSessions,@JsonKey(name: 'total_duration_seconds') int totalDurationSeconds,@JsonKey(name: 'average_duration_seconds') int averageDurationSeconds,@JsonKey(name: 'longest_session_seconds') int? longestSessionSeconds,@JsonKey(name: 'shortest_session_seconds') int? shortestSessionSeconds,@JsonKey(name: 'most_common_context') ContextCountModel? mostCommonContext
});


$ContextCountModelCopyWith<$Res>? get mostCommonContext;

}
/// @nodoc
class _$SessionStatsModelCopyWithImpl<$Res>
    implements $SessionStatsModelCopyWith<$Res> {
  _$SessionStatsModelCopyWithImpl(this._self, this._then);

  final SessionStatsModel _self;
  final $Res Function(SessionStatsModel) _then;

/// Create a copy of SessionStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSessions = null,Object? totalDurationSeconds = null,Object? averageDurationSeconds = null,Object? longestSessionSeconds = freezed,Object? shortestSessionSeconds = freezed,Object? mostCommonContext = freezed,}) {
  return _then(_self.copyWith(
totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,averageDurationSeconds: null == averageDurationSeconds ? _self.averageDurationSeconds : averageDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,longestSessionSeconds: freezed == longestSessionSeconds ? _self.longestSessionSeconds : longestSessionSeconds // ignore: cast_nullable_to_non_nullable
as int?,shortestSessionSeconds: freezed == shortestSessionSeconds ? _self.shortestSessionSeconds : shortestSessionSeconds // ignore: cast_nullable_to_non_nullable
as int?,mostCommonContext: freezed == mostCommonContext ? _self.mostCommonContext : mostCommonContext // ignore: cast_nullable_to_non_nullable
as ContextCountModel?,
  ));
}
/// Create a copy of SessionStatsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCountModelCopyWith<$Res>? get mostCommonContext {
    if (_self.mostCommonContext == null) {
    return null;
  }

  return $ContextCountModelCopyWith<$Res>(_self.mostCommonContext!, (value) {
    return _then(_self.copyWith(mostCommonContext: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionStatsModel].
extension SessionStatsModelPatterns on SessionStatsModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionStatsModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _SessionStatsModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _SessionStatsModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_sessions')  int totalSessions, @JsonKey(name: 'total_duration_seconds')  int totalDurationSeconds, @JsonKey(name: 'average_duration_seconds')  int averageDurationSeconds, @JsonKey(name: 'longest_session_seconds')  int? longestSessionSeconds, @JsonKey(name: 'shortest_session_seconds')  int? shortestSessionSeconds, @JsonKey(name: 'most_common_context')  ContextCountModel? mostCommonContext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionStatsModel() when $default != null:
return $default(_that.totalSessions,_that.totalDurationSeconds,_that.averageDurationSeconds,_that.longestSessionSeconds,_that.shortestSessionSeconds,_that.mostCommonContext);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_sessions')  int totalSessions, @JsonKey(name: 'total_duration_seconds')  int totalDurationSeconds, @JsonKey(name: 'average_duration_seconds')  int averageDurationSeconds, @JsonKey(name: 'longest_session_seconds')  int? longestSessionSeconds, @JsonKey(name: 'shortest_session_seconds')  int? shortestSessionSeconds, @JsonKey(name: 'most_common_context')  ContextCountModel? mostCommonContext)  $default,) {final _that = this;
switch (_that) {
case _SessionStatsModel():
return $default(_that.totalSessions,_that.totalDurationSeconds,_that.averageDurationSeconds,_that.longestSessionSeconds,_that.shortestSessionSeconds,_that.mostCommonContext);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_sessions')  int totalSessions, @JsonKey(name: 'total_duration_seconds')  int totalDurationSeconds, @JsonKey(name: 'average_duration_seconds')  int averageDurationSeconds, @JsonKey(name: 'longest_session_seconds')  int? longestSessionSeconds, @JsonKey(name: 'shortest_session_seconds')  int? shortestSessionSeconds, @JsonKey(name: 'most_common_context')  ContextCountModel? mostCommonContext)?  $default,) {final _that = this;
switch (_that) {
case _SessionStatsModel() when $default != null:
return $default(_that.totalSessions,_that.totalDurationSeconds,_that.averageDurationSeconds,_that.longestSessionSeconds,_that.shortestSessionSeconds,_that.mostCommonContext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionStatsModel implements SessionStatsModel {
  const _SessionStatsModel({@JsonKey(name: 'total_sessions') required this.totalSessions, @JsonKey(name: 'total_duration_seconds') required this.totalDurationSeconds, @JsonKey(name: 'average_duration_seconds') required this.averageDurationSeconds, @JsonKey(name: 'longest_session_seconds') this.longestSessionSeconds, @JsonKey(name: 'shortest_session_seconds') this.shortestSessionSeconds, @JsonKey(name: 'most_common_context') this.mostCommonContext});
  factory _SessionStatsModel.fromJson(Map<String, dynamic> json) => _$SessionStatsModelFromJson(json);

@override@JsonKey(name: 'total_sessions') final  int totalSessions;
@override@JsonKey(name: 'total_duration_seconds') final  int totalDurationSeconds;
@override@JsonKey(name: 'average_duration_seconds') final  int averageDurationSeconds;
@override@JsonKey(name: 'longest_session_seconds') final  int? longestSessionSeconds;
@override@JsonKey(name: 'shortest_session_seconds') final  int? shortestSessionSeconds;
@override@JsonKey(name: 'most_common_context') final  ContextCountModel? mostCommonContext;

/// Create a copy of SessionStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionStatsModelCopyWith<_SessionStatsModel> get copyWith => __$SessionStatsModelCopyWithImpl<_SessionStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionStatsModel&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.averageDurationSeconds, averageDurationSeconds) || other.averageDurationSeconds == averageDurationSeconds)&&(identical(other.longestSessionSeconds, longestSessionSeconds) || other.longestSessionSeconds == longestSessionSeconds)&&(identical(other.shortestSessionSeconds, shortestSessionSeconds) || other.shortestSessionSeconds == shortestSessionSeconds)&&(identical(other.mostCommonContext, mostCommonContext) || other.mostCommonContext == mostCommonContext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSessions,totalDurationSeconds,averageDurationSeconds,longestSessionSeconds,shortestSessionSeconds,mostCommonContext);

@override
String toString() {
  return 'SessionStatsModel(totalSessions: $totalSessions, totalDurationSeconds: $totalDurationSeconds, averageDurationSeconds: $averageDurationSeconds, longestSessionSeconds: $longestSessionSeconds, shortestSessionSeconds: $shortestSessionSeconds, mostCommonContext: $mostCommonContext)';
}


}

/// @nodoc
abstract mixin class _$SessionStatsModelCopyWith<$Res> implements $SessionStatsModelCopyWith<$Res> {
  factory _$SessionStatsModelCopyWith(_SessionStatsModel value, $Res Function(_SessionStatsModel) _then) = __$SessionStatsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_sessions') int totalSessions,@JsonKey(name: 'total_duration_seconds') int totalDurationSeconds,@JsonKey(name: 'average_duration_seconds') int averageDurationSeconds,@JsonKey(name: 'longest_session_seconds') int? longestSessionSeconds,@JsonKey(name: 'shortest_session_seconds') int? shortestSessionSeconds,@JsonKey(name: 'most_common_context') ContextCountModel? mostCommonContext
});


@override $ContextCountModelCopyWith<$Res>? get mostCommonContext;

}
/// @nodoc
class __$SessionStatsModelCopyWithImpl<$Res>
    implements _$SessionStatsModelCopyWith<$Res> {
  __$SessionStatsModelCopyWithImpl(this._self, this._then);

  final _SessionStatsModel _self;
  final $Res Function(_SessionStatsModel) _then;

/// Create a copy of SessionStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSessions = null,Object? totalDurationSeconds = null,Object? averageDurationSeconds = null,Object? longestSessionSeconds = freezed,Object? shortestSessionSeconds = freezed,Object? mostCommonContext = freezed,}) {
  return _then(_SessionStatsModel(
totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,averageDurationSeconds: null == averageDurationSeconds ? _self.averageDurationSeconds : averageDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,longestSessionSeconds: freezed == longestSessionSeconds ? _self.longestSessionSeconds : longestSessionSeconds // ignore: cast_nullable_to_non_nullable
as int?,shortestSessionSeconds: freezed == shortestSessionSeconds ? _self.shortestSessionSeconds : shortestSessionSeconds // ignore: cast_nullable_to_non_nullable
as int?,mostCommonContext: freezed == mostCommonContext ? _self.mostCommonContext : mostCommonContext // ignore: cast_nullable_to_non_nullable
as ContextCountModel?,
  ));
}

/// Create a copy of SessionStatsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCountModelCopyWith<$Res>? get mostCommonContext {
    if (_self.mostCommonContext == null) {
    return null;
  }

  return $ContextCountModelCopyWith<$Res>(_self.mostCommonContext!, (value) {
    return _then(_self.copyWith(mostCommonContext: value));
  });
}
}

// dart format on
