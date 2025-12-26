// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'silence_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SilenceSessionModel {

 String get id;@JsonKey(name: 'user_id') String? get userId;@JsonKey(name: 'started_at') String get startedAt;@JsonKey(name: 'ended_at') String? get endedAt;@JsonKey(name: 'duration_seconds') int? get durationSeconds;@JsonKey(name: 'context_code') int? get contextCode;@JsonKey(name: 'context_label') String? get contextLabel;@JsonKey(name: 'context_note') String? get contextNote;@JsonKey(name: 'termination_reason') String? get terminationReason;
/// Create a copy of SilenceSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SilenceSessionModelCopyWith<SilenceSessionModel> get copyWith => _$SilenceSessionModelCopyWithImpl<SilenceSessionModel>(this as SilenceSessionModel, _$identity);

  /// Serializes this SilenceSessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SilenceSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&(identical(other.contextNote, contextNote) || other.contextNote == contextNote)&&(identical(other.terminationReason, terminationReason) || other.terminationReason == terminationReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,startedAt,endedAt,durationSeconds,contextCode,contextLabel,contextNote,terminationReason);

@override
String toString() {
  return 'SilenceSessionModel(id: $id, userId: $userId, startedAt: $startedAt, endedAt: $endedAt, durationSeconds: $durationSeconds, contextCode: $contextCode, contextLabel: $contextLabel, contextNote: $contextNote, terminationReason: $terminationReason)';
}


}

/// @nodoc
abstract mixin class $SilenceSessionModelCopyWith<$Res>  {
  factory $SilenceSessionModelCopyWith(SilenceSessionModel value, $Res Function(SilenceSessionModel) _then) = _$SilenceSessionModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'started_at') String startedAt,@JsonKey(name: 'ended_at') String? endedAt,@JsonKey(name: 'duration_seconds') int? durationSeconds,@JsonKey(name: 'context_code') int? contextCode,@JsonKey(name: 'context_label') String? contextLabel,@JsonKey(name: 'context_note') String? contextNote,@JsonKey(name: 'termination_reason') String? terminationReason
});




}
/// @nodoc
class _$SilenceSessionModelCopyWithImpl<$Res>
    implements $SilenceSessionModelCopyWith<$Res> {
  _$SilenceSessionModelCopyWithImpl(this._self, this._then);

  final SilenceSessionModel _self;
  final $Res Function(SilenceSessionModel) _then;

/// Create a copy of SilenceSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? durationSeconds = freezed,Object? contextCode = freezed,Object? contextLabel = freezed,Object? contextNote = freezed,Object? terminationReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,contextLabel: freezed == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String?,contextNote: freezed == contextNote ? _self.contextNote : contextNote // ignore: cast_nullable_to_non_nullable
as String?,terminationReason: freezed == terminationReason ? _self.terminationReason : terminationReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SilenceSessionModel].
extension SilenceSessionModelPatterns on SilenceSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SilenceSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SilenceSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SilenceSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _SilenceSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SilenceSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _SilenceSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'duration_seconds')  int? durationSeconds, @JsonKey(name: 'context_code')  int? contextCode, @JsonKey(name: 'context_label')  String? contextLabel, @JsonKey(name: 'context_note')  String? contextNote, @JsonKey(name: 'termination_reason')  String? terminationReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SilenceSessionModel() when $default != null:
return $default(_that.id,_that.userId,_that.startedAt,_that.endedAt,_that.durationSeconds,_that.contextCode,_that.contextLabel,_that.contextNote,_that.terminationReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'duration_seconds')  int? durationSeconds, @JsonKey(name: 'context_code')  int? contextCode, @JsonKey(name: 'context_label')  String? contextLabel, @JsonKey(name: 'context_note')  String? contextNote, @JsonKey(name: 'termination_reason')  String? terminationReason)  $default,) {final _that = this;
switch (_that) {
case _SilenceSessionModel():
return $default(_that.id,_that.userId,_that.startedAt,_that.endedAt,_that.durationSeconds,_that.contextCode,_that.contextLabel,_that.contextNote,_that.terminationReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'duration_seconds')  int? durationSeconds, @JsonKey(name: 'context_code')  int? contextCode, @JsonKey(name: 'context_label')  String? contextLabel, @JsonKey(name: 'context_note')  String? contextNote, @JsonKey(name: 'termination_reason')  String? terminationReason)?  $default,) {final _that = this;
switch (_that) {
case _SilenceSessionModel() when $default != null:
return $default(_that.id,_that.userId,_that.startedAt,_that.endedAt,_that.durationSeconds,_that.contextCode,_that.contextLabel,_that.contextNote,_that.terminationReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SilenceSessionModel implements SilenceSessionModel {
  const _SilenceSessionModel({required this.id, @JsonKey(name: 'user_id') this.userId, @JsonKey(name: 'started_at') required this.startedAt, @JsonKey(name: 'ended_at') this.endedAt, @JsonKey(name: 'duration_seconds') this.durationSeconds, @JsonKey(name: 'context_code') this.contextCode, @JsonKey(name: 'context_label') this.contextLabel, @JsonKey(name: 'context_note') this.contextNote, @JsonKey(name: 'termination_reason') this.terminationReason});
  factory _SilenceSessionModel.fromJson(Map<String, dynamic> json) => _$SilenceSessionModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String? userId;
@override@JsonKey(name: 'started_at') final  String startedAt;
@override@JsonKey(name: 'ended_at') final  String? endedAt;
@override@JsonKey(name: 'duration_seconds') final  int? durationSeconds;
@override@JsonKey(name: 'context_code') final  int? contextCode;
@override@JsonKey(name: 'context_label') final  String? contextLabel;
@override@JsonKey(name: 'context_note') final  String? contextNote;
@override@JsonKey(name: 'termination_reason') final  String? terminationReason;

/// Create a copy of SilenceSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SilenceSessionModelCopyWith<_SilenceSessionModel> get copyWith => __$SilenceSessionModelCopyWithImpl<_SilenceSessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SilenceSessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SilenceSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&(identical(other.contextNote, contextNote) || other.contextNote == contextNote)&&(identical(other.terminationReason, terminationReason) || other.terminationReason == terminationReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,startedAt,endedAt,durationSeconds,contextCode,contextLabel,contextNote,terminationReason);

@override
String toString() {
  return 'SilenceSessionModel(id: $id, userId: $userId, startedAt: $startedAt, endedAt: $endedAt, durationSeconds: $durationSeconds, contextCode: $contextCode, contextLabel: $contextLabel, contextNote: $contextNote, terminationReason: $terminationReason)';
}


}

/// @nodoc
abstract mixin class _$SilenceSessionModelCopyWith<$Res> implements $SilenceSessionModelCopyWith<$Res> {
  factory _$SilenceSessionModelCopyWith(_SilenceSessionModel value, $Res Function(_SilenceSessionModel) _then) = __$SilenceSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'started_at') String startedAt,@JsonKey(name: 'ended_at') String? endedAt,@JsonKey(name: 'duration_seconds') int? durationSeconds,@JsonKey(name: 'context_code') int? contextCode,@JsonKey(name: 'context_label') String? contextLabel,@JsonKey(name: 'context_note') String? contextNote,@JsonKey(name: 'termination_reason') String? terminationReason
});




}
/// @nodoc
class __$SilenceSessionModelCopyWithImpl<$Res>
    implements _$SilenceSessionModelCopyWith<$Res> {
  __$SilenceSessionModelCopyWithImpl(this._self, this._then);

  final _SilenceSessionModel _self;
  final $Res Function(_SilenceSessionModel) _then;

/// Create a copy of SilenceSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? durationSeconds = freezed,Object? contextCode = freezed,Object? contextLabel = freezed,Object? contextNote = freezed,Object? terminationReason = freezed,}) {
  return _then(_SilenceSessionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,contextLabel: freezed == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String?,contextNote: freezed == contextNote ? _self.contextNote : contextNote // ignore: cast_nullable_to_non_nullable
as String?,terminationReason: freezed == terminationReason ? _self.terminationReason : terminationReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SessionListResponse {

 List<SilenceSessionModel> get sessions; int? get total; int? get limit; int? get offset;
/// Create a copy of SessionListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionListResponseCopyWith<SessionListResponse> get copyWith => _$SessionListResponseCopyWithImpl<SessionListResponse>(this as SessionListResponse, _$identity);

  /// Serializes this SessionListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionListResponse&&const DeepCollectionEquality().equals(other.sessions, sessions)&&(identical(other.total, total) || other.total == total)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sessions),total,limit,offset);

@override
String toString() {
  return 'SessionListResponse(sessions: $sessions, total: $total, limit: $limit, offset: $offset)';
}


}

/// @nodoc
abstract mixin class $SessionListResponseCopyWith<$Res>  {
  factory $SessionListResponseCopyWith(SessionListResponse value, $Res Function(SessionListResponse) _then) = _$SessionListResponseCopyWithImpl;
@useResult
$Res call({
 List<SilenceSessionModel> sessions, int? total, int? limit, int? offset
});




}
/// @nodoc
class _$SessionListResponseCopyWithImpl<$Res>
    implements $SessionListResponseCopyWith<$Res> {
  _$SessionListResponseCopyWithImpl(this._self, this._then);

  final SessionListResponse _self;
  final $Res Function(SessionListResponse) _then;

/// Create a copy of SessionListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessions = null,Object? total = freezed,Object? limit = freezed,Object? offset = freezed,}) {
  return _then(_self.copyWith(
sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SilenceSessionModel>,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionListResponse].
extension SessionListResponsePatterns on SessionListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionListResponse value)  $default,){
final _that = this;
switch (_that) {
case _SessionListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SessionListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SilenceSessionModel> sessions,  int? total,  int? limit,  int? offset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionListResponse() when $default != null:
return $default(_that.sessions,_that.total,_that.limit,_that.offset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SilenceSessionModel> sessions,  int? total,  int? limit,  int? offset)  $default,) {final _that = this;
switch (_that) {
case _SessionListResponse():
return $default(_that.sessions,_that.total,_that.limit,_that.offset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SilenceSessionModel> sessions,  int? total,  int? limit,  int? offset)?  $default,) {final _that = this;
switch (_that) {
case _SessionListResponse() when $default != null:
return $default(_that.sessions,_that.total,_that.limit,_that.offset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionListResponse implements SessionListResponse {
  const _SessionListResponse({required final  List<SilenceSessionModel> sessions, this.total, this.limit, this.offset}): _sessions = sessions;
  factory _SessionListResponse.fromJson(Map<String, dynamic> json) => _$SessionListResponseFromJson(json);

 final  List<SilenceSessionModel> _sessions;
@override List<SilenceSessionModel> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

@override final  int? total;
@override final  int? limit;
@override final  int? offset;

/// Create a copy of SessionListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionListResponseCopyWith<_SessionListResponse> get copyWith => __$SessionListResponseCopyWithImpl<_SessionListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionListResponse&&const DeepCollectionEquality().equals(other._sessions, _sessions)&&(identical(other.total, total) || other.total == total)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sessions),total,limit,offset);

@override
String toString() {
  return 'SessionListResponse(sessions: $sessions, total: $total, limit: $limit, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$SessionListResponseCopyWith<$Res> implements $SessionListResponseCopyWith<$Res> {
  factory _$SessionListResponseCopyWith(_SessionListResponse value, $Res Function(_SessionListResponse) _then) = __$SessionListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<SilenceSessionModel> sessions, int? total, int? limit, int? offset
});




}
/// @nodoc
class __$SessionListResponseCopyWithImpl<$Res>
    implements _$SessionListResponseCopyWith<$Res> {
  __$SessionListResponseCopyWithImpl(this._self, this._then);

  final _SessionListResponse _self;
  final $Res Function(_SessionListResponse) _then;

/// Create a copy of SessionListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessions = null,Object? total = freezed,Object? limit = freezed,Object? offset = freezed,}) {
  return _then(_SessionListResponse(
sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SilenceSessionModel>,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$AttachContextRequest {

@JsonKey(name: 'context_code') int get contextCode;@JsonKey(name: 'context_note') String? get contextNote;
/// Create a copy of AttachContextRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttachContextRequestCopyWith<AttachContextRequest> get copyWith => _$AttachContextRequestCopyWithImpl<AttachContextRequest>(this as AttachContextRequest, _$identity);

  /// Serializes this AttachContextRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttachContextRequest&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextNote, contextNote) || other.contextNote == contextNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contextCode,contextNote);

@override
String toString() {
  return 'AttachContextRequest(contextCode: $contextCode, contextNote: $contextNote)';
}


}

/// @nodoc
abstract mixin class $AttachContextRequestCopyWith<$Res>  {
  factory $AttachContextRequestCopyWith(AttachContextRequest value, $Res Function(AttachContextRequest) _then) = _$AttachContextRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'context_code') int contextCode,@JsonKey(name: 'context_note') String? contextNote
});




}
/// @nodoc
class _$AttachContextRequestCopyWithImpl<$Res>
    implements $AttachContextRequestCopyWith<$Res> {
  _$AttachContextRequestCopyWithImpl(this._self, this._then);

  final AttachContextRequest _self;
  final $Res Function(AttachContextRequest) _then;

/// Create a copy of AttachContextRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contextCode = null,Object? contextNote = freezed,}) {
  return _then(_self.copyWith(
contextCode: null == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int,contextNote: freezed == contextNote ? _self.contextNote : contextNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttachContextRequest].
extension AttachContextRequestPatterns on AttachContextRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttachContextRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttachContextRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttachContextRequest value)  $default,){
final _that = this;
switch (_that) {
case _AttachContextRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttachContextRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AttachContextRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'context_code')  int contextCode, @JsonKey(name: 'context_note')  String? contextNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttachContextRequest() when $default != null:
return $default(_that.contextCode,_that.contextNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'context_code')  int contextCode, @JsonKey(name: 'context_note')  String? contextNote)  $default,) {final _that = this;
switch (_that) {
case _AttachContextRequest():
return $default(_that.contextCode,_that.contextNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'context_code')  int contextCode, @JsonKey(name: 'context_note')  String? contextNote)?  $default,) {final _that = this;
switch (_that) {
case _AttachContextRequest() when $default != null:
return $default(_that.contextCode,_that.contextNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttachContextRequest implements AttachContextRequest {
  const _AttachContextRequest({@JsonKey(name: 'context_code') required this.contextCode, @JsonKey(name: 'context_note') this.contextNote});
  factory _AttachContextRequest.fromJson(Map<String, dynamic> json) => _$AttachContextRequestFromJson(json);

@override@JsonKey(name: 'context_code') final  int contextCode;
@override@JsonKey(name: 'context_note') final  String? contextNote;

/// Create a copy of AttachContextRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachContextRequestCopyWith<_AttachContextRequest> get copyWith => __$AttachContextRequestCopyWithImpl<_AttachContextRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttachContextRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttachContextRequest&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextNote, contextNote) || other.contextNote == contextNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contextCode,contextNote);

@override
String toString() {
  return 'AttachContextRequest(contextCode: $contextCode, contextNote: $contextNote)';
}


}

/// @nodoc
abstract mixin class _$AttachContextRequestCopyWith<$Res> implements $AttachContextRequestCopyWith<$Res> {
  factory _$AttachContextRequestCopyWith(_AttachContextRequest value, $Res Function(_AttachContextRequest) _then) = __$AttachContextRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'context_code') int contextCode,@JsonKey(name: 'context_note') String? contextNote
});




}
/// @nodoc
class __$AttachContextRequestCopyWithImpl<$Res>
    implements _$AttachContextRequestCopyWith<$Res> {
  __$AttachContextRequestCopyWithImpl(this._self, this._then);

  final _AttachContextRequest _self;
  final $Res Function(_AttachContextRequest) _then;

/// Create a copy of AttachContextRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contextCode = null,Object? contextNote = freezed,}) {
  return _then(_AttachContextRequest(
contextCode: null == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int,contextNote: freezed == contextNote ? _self.contextNote : contextNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AttachContextResponseModel {

@JsonKey(name: 'context_code') int get contextCode;@JsonKey(name: 'context_label') String get contextLabel;@JsonKey(name: 'context_note') String? get contextNote;
/// Create a copy of AttachContextResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttachContextResponseModelCopyWith<AttachContextResponseModel> get copyWith => _$AttachContextResponseModelCopyWithImpl<AttachContextResponseModel>(this as AttachContextResponseModel, _$identity);

  /// Serializes this AttachContextResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttachContextResponseModel&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&(identical(other.contextNote, contextNote) || other.contextNote == contextNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contextCode,contextLabel,contextNote);

@override
String toString() {
  return 'AttachContextResponseModel(contextCode: $contextCode, contextLabel: $contextLabel, contextNote: $contextNote)';
}


}

/// @nodoc
abstract mixin class $AttachContextResponseModelCopyWith<$Res>  {
  factory $AttachContextResponseModelCopyWith(AttachContextResponseModel value, $Res Function(AttachContextResponseModel) _then) = _$AttachContextResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'context_code') int contextCode,@JsonKey(name: 'context_label') String contextLabel,@JsonKey(name: 'context_note') String? contextNote
});




}
/// @nodoc
class _$AttachContextResponseModelCopyWithImpl<$Res>
    implements $AttachContextResponseModelCopyWith<$Res> {
  _$AttachContextResponseModelCopyWithImpl(this._self, this._then);

  final AttachContextResponseModel _self;
  final $Res Function(AttachContextResponseModel) _then;

/// Create a copy of AttachContextResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contextCode = null,Object? contextLabel = null,Object? contextNote = freezed,}) {
  return _then(_self.copyWith(
contextCode: null == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int,contextLabel: null == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String,contextNote: freezed == contextNote ? _self.contextNote : contextNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttachContextResponseModel].
extension AttachContextResponseModelPatterns on AttachContextResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttachContextResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttachContextResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttachContextResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _AttachContextResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttachContextResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttachContextResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'context_code')  int contextCode, @JsonKey(name: 'context_label')  String contextLabel, @JsonKey(name: 'context_note')  String? contextNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttachContextResponseModel() when $default != null:
return $default(_that.contextCode,_that.contextLabel,_that.contextNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'context_code')  int contextCode, @JsonKey(name: 'context_label')  String contextLabel, @JsonKey(name: 'context_note')  String? contextNote)  $default,) {final _that = this;
switch (_that) {
case _AttachContextResponseModel():
return $default(_that.contextCode,_that.contextLabel,_that.contextNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'context_code')  int contextCode, @JsonKey(name: 'context_label')  String contextLabel, @JsonKey(name: 'context_note')  String? contextNote)?  $default,) {final _that = this;
switch (_that) {
case _AttachContextResponseModel() when $default != null:
return $default(_that.contextCode,_that.contextLabel,_that.contextNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttachContextResponseModel implements AttachContextResponseModel {
  const _AttachContextResponseModel({@JsonKey(name: 'context_code') required this.contextCode, @JsonKey(name: 'context_label') required this.contextLabel, @JsonKey(name: 'context_note') this.contextNote});
  factory _AttachContextResponseModel.fromJson(Map<String, dynamic> json) => _$AttachContextResponseModelFromJson(json);

@override@JsonKey(name: 'context_code') final  int contextCode;
@override@JsonKey(name: 'context_label') final  String contextLabel;
@override@JsonKey(name: 'context_note') final  String? contextNote;

/// Create a copy of AttachContextResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachContextResponseModelCopyWith<_AttachContextResponseModel> get copyWith => __$AttachContextResponseModelCopyWithImpl<_AttachContextResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttachContextResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttachContextResponseModel&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&(identical(other.contextNote, contextNote) || other.contextNote == contextNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contextCode,contextLabel,contextNote);

@override
String toString() {
  return 'AttachContextResponseModel(contextCode: $contextCode, contextLabel: $contextLabel, contextNote: $contextNote)';
}


}

/// @nodoc
abstract mixin class _$AttachContextResponseModelCopyWith<$Res> implements $AttachContextResponseModelCopyWith<$Res> {
  factory _$AttachContextResponseModelCopyWith(_AttachContextResponseModel value, $Res Function(_AttachContextResponseModel) _then) = __$AttachContextResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'context_code') int contextCode,@JsonKey(name: 'context_label') String contextLabel,@JsonKey(name: 'context_note') String? contextNote
});




}
/// @nodoc
class __$AttachContextResponseModelCopyWithImpl<$Res>
    implements _$AttachContextResponseModelCopyWith<$Res> {
  __$AttachContextResponseModelCopyWithImpl(this._self, this._then);

  final _AttachContextResponseModel _self;
  final $Res Function(_AttachContextResponseModel) _then;

/// Create a copy of AttachContextResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contextCode = null,Object? contextLabel = null,Object? contextNote = freezed,}) {
  return _then(_AttachContextResponseModel(
contextCode: null == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int,contextLabel: null == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String,contextNote: freezed == contextNote ? _self.contextNote : contextNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
