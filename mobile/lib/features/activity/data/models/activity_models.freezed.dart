// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityItem {

 String get id; String get module;@JsonKey(name: 'module_session_id') String get moduleSessionId;@JsonKey(name: 'started_at') DateTime get startedAt;@JsonKey(name: 'started_at_local') String get startedAtLocal;@JsonKey(name: 'ended_at') DateTime? get endedAt;@JsonKey(name: 'ended_at_local') String? get endedAtLocal;@JsonKey(name: 'duration_seconds') int? get durationSeconds;@JsonKey(name: 'context_code') int? get contextCode;@JsonKey(name: 'context_label') String? get contextLabel; Map<String, dynamic>? get metadata;
/// Create a copy of ActivityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityItemCopyWith<ActivityItem> get copyWith => _$ActivityItemCopyWithImpl<ActivityItem>(this as ActivityItem, _$identity);

  /// Serializes this ActivityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityItem&&(identical(other.id, id) || other.id == id)&&(identical(other.module, module) || other.module == module)&&(identical(other.moduleSessionId, moduleSessionId) || other.moduleSessionId == moduleSessionId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.startedAtLocal, startedAtLocal) || other.startedAtLocal == startedAtLocal)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.endedAtLocal, endedAtLocal) || other.endedAtLocal == endedAtLocal)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,module,moduleSessionId,startedAt,startedAtLocal,endedAt,endedAtLocal,durationSeconds,contextCode,contextLabel,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'ActivityItem(id: $id, module: $module, moduleSessionId: $moduleSessionId, startedAt: $startedAt, startedAtLocal: $startedAtLocal, endedAt: $endedAt, endedAtLocal: $endedAtLocal, durationSeconds: $durationSeconds, contextCode: $contextCode, contextLabel: $contextLabel, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ActivityItemCopyWith<$Res>  {
  factory $ActivityItemCopyWith(ActivityItem value, $Res Function(ActivityItem) _then) = _$ActivityItemCopyWithImpl;
@useResult
$Res call({
 String id, String module,@JsonKey(name: 'module_session_id') String moduleSessionId,@JsonKey(name: 'started_at') DateTime startedAt,@JsonKey(name: 'started_at_local') String startedAtLocal,@JsonKey(name: 'ended_at') DateTime? endedAt,@JsonKey(name: 'ended_at_local') String? endedAtLocal,@JsonKey(name: 'duration_seconds') int? durationSeconds,@JsonKey(name: 'context_code') int? contextCode,@JsonKey(name: 'context_label') String? contextLabel, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$ActivityItemCopyWithImpl<$Res>
    implements $ActivityItemCopyWith<$Res> {
  _$ActivityItemCopyWithImpl(this._self, this._then);

  final ActivityItem _self;
  final $Res Function(ActivityItem) _then;

/// Create a copy of ActivityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? module = null,Object? moduleSessionId = null,Object? startedAt = null,Object? startedAtLocal = null,Object? endedAt = freezed,Object? endedAtLocal = freezed,Object? durationSeconds = freezed,Object? contextCode = freezed,Object? contextLabel = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,module: null == module ? _self.module : module // ignore: cast_nullable_to_non_nullable
as String,moduleSessionId: null == moduleSessionId ? _self.moduleSessionId : moduleSessionId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,startedAtLocal: null == startedAtLocal ? _self.startedAtLocal : startedAtLocal // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAtLocal: freezed == endedAtLocal ? _self.endedAtLocal : endedAtLocal // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,contextLabel: freezed == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityItem].
extension ActivityItemPatterns on ActivityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityItem value)  $default,){
final _that = this;
switch (_that) {
case _ActivityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityItem value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String module, @JsonKey(name: 'module_session_id')  String moduleSessionId, @JsonKey(name: 'started_at')  DateTime startedAt, @JsonKey(name: 'started_at_local')  String startedAtLocal, @JsonKey(name: 'ended_at')  DateTime? endedAt, @JsonKey(name: 'ended_at_local')  String? endedAtLocal, @JsonKey(name: 'duration_seconds')  int? durationSeconds, @JsonKey(name: 'context_code')  int? contextCode, @JsonKey(name: 'context_label')  String? contextLabel,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityItem() when $default != null:
return $default(_that.id,_that.module,_that.moduleSessionId,_that.startedAt,_that.startedAtLocal,_that.endedAt,_that.endedAtLocal,_that.durationSeconds,_that.contextCode,_that.contextLabel,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String module, @JsonKey(name: 'module_session_id')  String moduleSessionId, @JsonKey(name: 'started_at')  DateTime startedAt, @JsonKey(name: 'started_at_local')  String startedAtLocal, @JsonKey(name: 'ended_at')  DateTime? endedAt, @JsonKey(name: 'ended_at_local')  String? endedAtLocal, @JsonKey(name: 'duration_seconds')  int? durationSeconds, @JsonKey(name: 'context_code')  int? contextCode, @JsonKey(name: 'context_label')  String? contextLabel,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _ActivityItem():
return $default(_that.id,_that.module,_that.moduleSessionId,_that.startedAt,_that.startedAtLocal,_that.endedAt,_that.endedAtLocal,_that.durationSeconds,_that.contextCode,_that.contextLabel,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String module, @JsonKey(name: 'module_session_id')  String moduleSessionId, @JsonKey(name: 'started_at')  DateTime startedAt, @JsonKey(name: 'started_at_local')  String startedAtLocal, @JsonKey(name: 'ended_at')  DateTime? endedAt, @JsonKey(name: 'ended_at_local')  String? endedAtLocal, @JsonKey(name: 'duration_seconds')  int? durationSeconds, @JsonKey(name: 'context_code')  int? contextCode, @JsonKey(name: 'context_label')  String? contextLabel,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _ActivityItem() when $default != null:
return $default(_that.id,_that.module,_that.moduleSessionId,_that.startedAt,_that.startedAtLocal,_that.endedAt,_that.endedAtLocal,_that.durationSeconds,_that.contextCode,_that.contextLabel,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityItem implements ActivityItem {
  const _ActivityItem({required this.id, required this.module, @JsonKey(name: 'module_session_id') required this.moduleSessionId, @JsonKey(name: 'started_at') required this.startedAt, @JsonKey(name: 'started_at_local') required this.startedAtLocal, @JsonKey(name: 'ended_at') this.endedAt, @JsonKey(name: 'ended_at_local') this.endedAtLocal, @JsonKey(name: 'duration_seconds') this.durationSeconds, @JsonKey(name: 'context_code') this.contextCode, @JsonKey(name: 'context_label') this.contextLabel, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _ActivityItem.fromJson(Map<String, dynamic> json) => _$ActivityItemFromJson(json);

@override final  String id;
@override final  String module;
@override@JsonKey(name: 'module_session_id') final  String moduleSessionId;
@override@JsonKey(name: 'started_at') final  DateTime startedAt;
@override@JsonKey(name: 'started_at_local') final  String startedAtLocal;
@override@JsonKey(name: 'ended_at') final  DateTime? endedAt;
@override@JsonKey(name: 'ended_at_local') final  String? endedAtLocal;
@override@JsonKey(name: 'duration_seconds') final  int? durationSeconds;
@override@JsonKey(name: 'context_code') final  int? contextCode;
@override@JsonKey(name: 'context_label') final  String? contextLabel;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ActivityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityItemCopyWith<_ActivityItem> get copyWith => __$ActivityItemCopyWithImpl<_ActivityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityItem&&(identical(other.id, id) || other.id == id)&&(identical(other.module, module) || other.module == module)&&(identical(other.moduleSessionId, moduleSessionId) || other.moduleSessionId == moduleSessionId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.startedAtLocal, startedAtLocal) || other.startedAtLocal == startedAtLocal)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.endedAtLocal, endedAtLocal) || other.endedAtLocal == endedAtLocal)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,module,moduleSessionId,startedAt,startedAtLocal,endedAt,endedAtLocal,durationSeconds,contextCode,contextLabel,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'ActivityItem(id: $id, module: $module, moduleSessionId: $moduleSessionId, startedAt: $startedAt, startedAtLocal: $startedAtLocal, endedAt: $endedAt, endedAtLocal: $endedAtLocal, durationSeconds: $durationSeconds, contextCode: $contextCode, contextLabel: $contextLabel, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ActivityItemCopyWith<$Res> implements $ActivityItemCopyWith<$Res> {
  factory _$ActivityItemCopyWith(_ActivityItem value, $Res Function(_ActivityItem) _then) = __$ActivityItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String module,@JsonKey(name: 'module_session_id') String moduleSessionId,@JsonKey(name: 'started_at') DateTime startedAt,@JsonKey(name: 'started_at_local') String startedAtLocal,@JsonKey(name: 'ended_at') DateTime? endedAt,@JsonKey(name: 'ended_at_local') String? endedAtLocal,@JsonKey(name: 'duration_seconds') int? durationSeconds,@JsonKey(name: 'context_code') int? contextCode,@JsonKey(name: 'context_label') String? contextLabel, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$ActivityItemCopyWithImpl<$Res>
    implements _$ActivityItemCopyWith<$Res> {
  __$ActivityItemCopyWithImpl(this._self, this._then);

  final _ActivityItem _self;
  final $Res Function(_ActivityItem) _then;

/// Create a copy of ActivityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? module = null,Object? moduleSessionId = null,Object? startedAt = null,Object? startedAtLocal = null,Object? endedAt = freezed,Object? endedAtLocal = freezed,Object? durationSeconds = freezed,Object? contextCode = freezed,Object? contextLabel = freezed,Object? metadata = freezed,}) {
  return _then(_ActivityItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,module: null == module ? _self.module : module // ignore: cast_nullable_to_non_nullable
as String,moduleSessionId: null == moduleSessionId ? _self.moduleSessionId : moduleSessionId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,startedAtLocal: null == startedAtLocal ? _self.startedAtLocal : startedAtLocal // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAtLocal: freezed == endedAtLocal ? _self.endedAtLocal : endedAtLocal // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,contextLabel: freezed == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$ActivityListResponse {

 List<ActivityItem> get activities;
/// Create a copy of ActivityListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityListResponseCopyWith<ActivityListResponse> get copyWith => _$ActivityListResponseCopyWithImpl<ActivityListResponse>(this as ActivityListResponse, _$identity);

  /// Serializes this ActivityListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityListResponse&&const DeepCollectionEquality().equals(other.activities, activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(activities));

@override
String toString() {
  return 'ActivityListResponse(activities: $activities)';
}


}

/// @nodoc
abstract mixin class $ActivityListResponseCopyWith<$Res>  {
  factory $ActivityListResponseCopyWith(ActivityListResponse value, $Res Function(ActivityListResponse) _then) = _$ActivityListResponseCopyWithImpl;
@useResult
$Res call({
 List<ActivityItem> activities
});




}
/// @nodoc
class _$ActivityListResponseCopyWithImpl<$Res>
    implements $ActivityListResponseCopyWith<$Res> {
  _$ActivityListResponseCopyWithImpl(this._self, this._then);

  final ActivityListResponse _self;
  final $Res Function(ActivityListResponse) _then;

/// Create a copy of ActivityListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activities = null,}) {
  return _then(_self.copyWith(
activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<ActivityItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityListResponse].
extension ActivityListResponsePatterns on ActivityListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityListResponse value)  $default,){
final _that = this;
switch (_that) {
case _ActivityListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ActivityItem> activities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityListResponse() when $default != null:
return $default(_that.activities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ActivityItem> activities)  $default,) {final _that = this;
switch (_that) {
case _ActivityListResponse():
return $default(_that.activities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ActivityItem> activities)?  $default,) {final _that = this;
switch (_that) {
case _ActivityListResponse() when $default != null:
return $default(_that.activities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityListResponse implements ActivityListResponse {
  const _ActivityListResponse({required final  List<ActivityItem> activities}): _activities = activities;
  factory _ActivityListResponse.fromJson(Map<String, dynamic> json) => _$ActivityListResponseFromJson(json);

 final  List<ActivityItem> _activities;
@override List<ActivityItem> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}


/// Create a copy of ActivityListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityListResponseCopyWith<_ActivityListResponse> get copyWith => __$ActivityListResponseCopyWithImpl<_ActivityListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityListResponse&&const DeepCollectionEquality().equals(other._activities, _activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_activities));

@override
String toString() {
  return 'ActivityListResponse(activities: $activities)';
}


}

/// @nodoc
abstract mixin class _$ActivityListResponseCopyWith<$Res> implements $ActivityListResponseCopyWith<$Res> {
  factory _$ActivityListResponseCopyWith(_ActivityListResponse value, $Res Function(_ActivityListResponse) _then) = __$ActivityListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ActivityItem> activities
});




}
/// @nodoc
class __$ActivityListResponseCopyWithImpl<$Res>
    implements _$ActivityListResponseCopyWith<$Res> {
  __$ActivityListResponseCopyWithImpl(this._self, this._then);

  final _ActivityListResponse _self;
  final $Res Function(_ActivityListResponse) _then;

/// Create a copy of ActivityListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activities = null,}) {
  return _then(_ActivityListResponse(
activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<ActivityItem>,
  ));
}


}


/// @nodoc
mixin _$ModuleCount {

 String get module; int get count;
/// Create a copy of ModuleCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleCountCopyWith<ModuleCount> get copyWith => _$ModuleCountCopyWithImpl<ModuleCount>(this as ModuleCount, _$identity);

  /// Serializes this ModuleCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleCount&&(identical(other.module, module) || other.module == module)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,module,count);

@override
String toString() {
  return 'ModuleCount(module: $module, count: $count)';
}


}

/// @nodoc
abstract mixin class $ModuleCountCopyWith<$Res>  {
  factory $ModuleCountCopyWith(ModuleCount value, $Res Function(ModuleCount) _then) = _$ModuleCountCopyWithImpl;
@useResult
$Res call({
 String module, int count
});




}
/// @nodoc
class _$ModuleCountCopyWithImpl<$Res>
    implements $ModuleCountCopyWith<$Res> {
  _$ModuleCountCopyWithImpl(this._self, this._then);

  final ModuleCount _self;
  final $Res Function(ModuleCount) _then;

/// Create a copy of ModuleCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? module = null,Object? count = null,}) {
  return _then(_self.copyWith(
module: null == module ? _self.module : module // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ModuleCount].
extension ModuleCountPatterns on ModuleCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleCount value)  $default,){
final _that = this;
switch (_that) {
case _ModuleCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleCount value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String module,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleCount() when $default != null:
return $default(_that.module,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String module,  int count)  $default,) {final _that = this;
switch (_that) {
case _ModuleCount():
return $default(_that.module,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String module,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ModuleCount() when $default != null:
return $default(_that.module,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModuleCount implements ModuleCount {
  const _ModuleCount({required this.module, required this.count});
  factory _ModuleCount.fromJson(Map<String, dynamic> json) => _$ModuleCountFromJson(json);

@override final  String module;
@override final  int count;

/// Create a copy of ModuleCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleCountCopyWith<_ModuleCount> get copyWith => __$ModuleCountCopyWithImpl<_ModuleCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModuleCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleCount&&(identical(other.module, module) || other.module == module)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,module,count);

@override
String toString() {
  return 'ModuleCount(module: $module, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ModuleCountCopyWith<$Res> implements $ModuleCountCopyWith<$Res> {
  factory _$ModuleCountCopyWith(_ModuleCount value, $Res Function(_ModuleCount) _then) = __$ModuleCountCopyWithImpl;
@override @useResult
$Res call({
 String module, int count
});




}
/// @nodoc
class __$ModuleCountCopyWithImpl<$Res>
    implements _$ModuleCountCopyWith<$Res> {
  __$ModuleCountCopyWithImpl(this._self, this._then);

  final _ModuleCount _self;
  final $Res Function(_ModuleCount) _then;

/// Create a copy of ModuleCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? module = null,Object? count = null,}) {
  return _then(_ModuleCount(
module: null == module ? _self.module : module // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ContextCount {

 int get code; String get label; int get count;
/// Create a copy of ContextCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContextCountCopyWith<ContextCount> get copyWith => _$ContextCountCopyWithImpl<ContextCount>(this as ContextCount, _$identity);

  /// Serializes this ContextCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContextCount&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,count);

@override
String toString() {
  return 'ContextCount(code: $code, label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class $ContextCountCopyWith<$Res>  {
  factory $ContextCountCopyWith(ContextCount value, $Res Function(ContextCount) _then) = _$ContextCountCopyWithImpl;
@useResult
$Res call({
 int code, String label, int count
});




}
/// @nodoc
class _$ContextCountCopyWithImpl<$Res>
    implements $ContextCountCopyWith<$Res> {
  _$ContextCountCopyWithImpl(this._self, this._then);

  final ContextCount _self;
  final $Res Function(ContextCount) _then;

/// Create a copy of ContextCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? label = null,Object? count = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ContextCount].
extension ContextCountPatterns on ContextCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContextCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContextCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContextCount value)  $default,){
final _that = this;
switch (_that) {
case _ContextCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContextCount value)?  $default,){
final _that = this;
switch (_that) {
case _ContextCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String label,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContextCount() when $default != null:
return $default(_that.code,_that.label,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String label,  int count)  $default,) {final _that = this;
switch (_that) {
case _ContextCount():
return $default(_that.code,_that.label,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String label,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ContextCount() when $default != null:
return $default(_that.code,_that.label,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContextCount implements ContextCount {
  const _ContextCount({required this.code, required this.label, required this.count});
  factory _ContextCount.fromJson(Map<String, dynamic> json) => _$ContextCountFromJson(json);

@override final  int code;
@override final  String label;
@override final  int count;

/// Create a copy of ContextCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContextCountCopyWith<_ContextCount> get copyWith => __$ContextCountCopyWithImpl<_ContextCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContextCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContextCount&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,count);

@override
String toString() {
  return 'ContextCount(code: $code, label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ContextCountCopyWith<$Res> implements $ContextCountCopyWith<$Res> {
  factory _$ContextCountCopyWith(_ContextCount value, $Res Function(_ContextCount) _then) = __$ContextCountCopyWithImpl;
@override @useResult
$Res call({
 int code, String label, int count
});




}
/// @nodoc
class __$ContextCountCopyWithImpl<$Res>
    implements _$ContextCountCopyWith<$Res> {
  __$ContextCountCopyWithImpl(this._self, this._then);

  final _ContextCount _self;
  final $Res Function(_ContextCount) _then;

/// Create a copy of ContextCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? label = null,Object? count = null,}) {
  return _then(_ContextCount(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ActivityStatsResponse {

@JsonKey(name: 'total_activities') int get totalActivities;@JsonKey(name: 'total_duration_seconds') int get totalDurationSeconds;@JsonKey(name: 'average_duration_seconds') int get averageDurationSeconds;@JsonKey(name: 'longest_activity_seconds') int get longestActivitySeconds;@JsonKey(name: 'shortest_activity_seconds') int get shortestActivitySeconds;@JsonKey(name: 'activities_by_module') List<ModuleCount> get activitiesByModule;@JsonKey(name: 'most_common_context') ContextCount? get mostCommonContext;
/// Create a copy of ActivityStatsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityStatsResponseCopyWith<ActivityStatsResponse> get copyWith => _$ActivityStatsResponseCopyWithImpl<ActivityStatsResponse>(this as ActivityStatsResponse, _$identity);

  /// Serializes this ActivityStatsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityStatsResponse&&(identical(other.totalActivities, totalActivities) || other.totalActivities == totalActivities)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.averageDurationSeconds, averageDurationSeconds) || other.averageDurationSeconds == averageDurationSeconds)&&(identical(other.longestActivitySeconds, longestActivitySeconds) || other.longestActivitySeconds == longestActivitySeconds)&&(identical(other.shortestActivitySeconds, shortestActivitySeconds) || other.shortestActivitySeconds == shortestActivitySeconds)&&const DeepCollectionEquality().equals(other.activitiesByModule, activitiesByModule)&&(identical(other.mostCommonContext, mostCommonContext) || other.mostCommonContext == mostCommonContext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalActivities,totalDurationSeconds,averageDurationSeconds,longestActivitySeconds,shortestActivitySeconds,const DeepCollectionEquality().hash(activitiesByModule),mostCommonContext);

@override
String toString() {
  return 'ActivityStatsResponse(totalActivities: $totalActivities, totalDurationSeconds: $totalDurationSeconds, averageDurationSeconds: $averageDurationSeconds, longestActivitySeconds: $longestActivitySeconds, shortestActivitySeconds: $shortestActivitySeconds, activitiesByModule: $activitiesByModule, mostCommonContext: $mostCommonContext)';
}


}

/// @nodoc
abstract mixin class $ActivityStatsResponseCopyWith<$Res>  {
  factory $ActivityStatsResponseCopyWith(ActivityStatsResponse value, $Res Function(ActivityStatsResponse) _then) = _$ActivityStatsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_activities') int totalActivities,@JsonKey(name: 'total_duration_seconds') int totalDurationSeconds,@JsonKey(name: 'average_duration_seconds') int averageDurationSeconds,@JsonKey(name: 'longest_activity_seconds') int longestActivitySeconds,@JsonKey(name: 'shortest_activity_seconds') int shortestActivitySeconds,@JsonKey(name: 'activities_by_module') List<ModuleCount> activitiesByModule,@JsonKey(name: 'most_common_context') ContextCount? mostCommonContext
});


$ContextCountCopyWith<$Res>? get mostCommonContext;

}
/// @nodoc
class _$ActivityStatsResponseCopyWithImpl<$Res>
    implements $ActivityStatsResponseCopyWith<$Res> {
  _$ActivityStatsResponseCopyWithImpl(this._self, this._then);

  final ActivityStatsResponse _self;
  final $Res Function(ActivityStatsResponse) _then;

/// Create a copy of ActivityStatsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalActivities = null,Object? totalDurationSeconds = null,Object? averageDurationSeconds = null,Object? longestActivitySeconds = null,Object? shortestActivitySeconds = null,Object? activitiesByModule = null,Object? mostCommonContext = freezed,}) {
  return _then(_self.copyWith(
totalActivities: null == totalActivities ? _self.totalActivities : totalActivities // ignore: cast_nullable_to_non_nullable
as int,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,averageDurationSeconds: null == averageDurationSeconds ? _self.averageDurationSeconds : averageDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,longestActivitySeconds: null == longestActivitySeconds ? _self.longestActivitySeconds : longestActivitySeconds // ignore: cast_nullable_to_non_nullable
as int,shortestActivitySeconds: null == shortestActivitySeconds ? _self.shortestActivitySeconds : shortestActivitySeconds // ignore: cast_nullable_to_non_nullable
as int,activitiesByModule: null == activitiesByModule ? _self.activitiesByModule : activitiesByModule // ignore: cast_nullable_to_non_nullable
as List<ModuleCount>,mostCommonContext: freezed == mostCommonContext ? _self.mostCommonContext : mostCommonContext // ignore: cast_nullable_to_non_nullable
as ContextCount?,
  ));
}
/// Create a copy of ActivityStatsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCountCopyWith<$Res>? get mostCommonContext {
    if (_self.mostCommonContext == null) {
    return null;
  }

  return $ContextCountCopyWith<$Res>(_self.mostCommonContext!, (value) {
    return _then(_self.copyWith(mostCommonContext: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActivityStatsResponse].
extension ActivityStatsResponsePatterns on ActivityStatsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityStatsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityStatsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityStatsResponse value)  $default,){
final _that = this;
switch (_that) {
case _ActivityStatsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityStatsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityStatsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_activities')  int totalActivities, @JsonKey(name: 'total_duration_seconds')  int totalDurationSeconds, @JsonKey(name: 'average_duration_seconds')  int averageDurationSeconds, @JsonKey(name: 'longest_activity_seconds')  int longestActivitySeconds, @JsonKey(name: 'shortest_activity_seconds')  int shortestActivitySeconds, @JsonKey(name: 'activities_by_module')  List<ModuleCount> activitiesByModule, @JsonKey(name: 'most_common_context')  ContextCount? mostCommonContext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityStatsResponse() when $default != null:
return $default(_that.totalActivities,_that.totalDurationSeconds,_that.averageDurationSeconds,_that.longestActivitySeconds,_that.shortestActivitySeconds,_that.activitiesByModule,_that.mostCommonContext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_activities')  int totalActivities, @JsonKey(name: 'total_duration_seconds')  int totalDurationSeconds, @JsonKey(name: 'average_duration_seconds')  int averageDurationSeconds, @JsonKey(name: 'longest_activity_seconds')  int longestActivitySeconds, @JsonKey(name: 'shortest_activity_seconds')  int shortestActivitySeconds, @JsonKey(name: 'activities_by_module')  List<ModuleCount> activitiesByModule, @JsonKey(name: 'most_common_context')  ContextCount? mostCommonContext)  $default,) {final _that = this;
switch (_that) {
case _ActivityStatsResponse():
return $default(_that.totalActivities,_that.totalDurationSeconds,_that.averageDurationSeconds,_that.longestActivitySeconds,_that.shortestActivitySeconds,_that.activitiesByModule,_that.mostCommonContext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_activities')  int totalActivities, @JsonKey(name: 'total_duration_seconds')  int totalDurationSeconds, @JsonKey(name: 'average_duration_seconds')  int averageDurationSeconds, @JsonKey(name: 'longest_activity_seconds')  int longestActivitySeconds, @JsonKey(name: 'shortest_activity_seconds')  int shortestActivitySeconds, @JsonKey(name: 'activities_by_module')  List<ModuleCount> activitiesByModule, @JsonKey(name: 'most_common_context')  ContextCount? mostCommonContext)?  $default,) {final _that = this;
switch (_that) {
case _ActivityStatsResponse() when $default != null:
return $default(_that.totalActivities,_that.totalDurationSeconds,_that.averageDurationSeconds,_that.longestActivitySeconds,_that.shortestActivitySeconds,_that.activitiesByModule,_that.mostCommonContext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityStatsResponse implements ActivityStatsResponse {
  const _ActivityStatsResponse({@JsonKey(name: 'total_activities') required this.totalActivities, @JsonKey(name: 'total_duration_seconds') required this.totalDurationSeconds, @JsonKey(name: 'average_duration_seconds') required this.averageDurationSeconds, @JsonKey(name: 'longest_activity_seconds') required this.longestActivitySeconds, @JsonKey(name: 'shortest_activity_seconds') required this.shortestActivitySeconds, @JsonKey(name: 'activities_by_module') required final  List<ModuleCount> activitiesByModule, @JsonKey(name: 'most_common_context') this.mostCommonContext}): _activitiesByModule = activitiesByModule;
  factory _ActivityStatsResponse.fromJson(Map<String, dynamic> json) => _$ActivityStatsResponseFromJson(json);

@override@JsonKey(name: 'total_activities') final  int totalActivities;
@override@JsonKey(name: 'total_duration_seconds') final  int totalDurationSeconds;
@override@JsonKey(name: 'average_duration_seconds') final  int averageDurationSeconds;
@override@JsonKey(name: 'longest_activity_seconds') final  int longestActivitySeconds;
@override@JsonKey(name: 'shortest_activity_seconds') final  int shortestActivitySeconds;
 final  List<ModuleCount> _activitiesByModule;
@override@JsonKey(name: 'activities_by_module') List<ModuleCount> get activitiesByModule {
  if (_activitiesByModule is EqualUnmodifiableListView) return _activitiesByModule;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activitiesByModule);
}

@override@JsonKey(name: 'most_common_context') final  ContextCount? mostCommonContext;

/// Create a copy of ActivityStatsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityStatsResponseCopyWith<_ActivityStatsResponse> get copyWith => __$ActivityStatsResponseCopyWithImpl<_ActivityStatsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityStatsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityStatsResponse&&(identical(other.totalActivities, totalActivities) || other.totalActivities == totalActivities)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&(identical(other.averageDurationSeconds, averageDurationSeconds) || other.averageDurationSeconds == averageDurationSeconds)&&(identical(other.longestActivitySeconds, longestActivitySeconds) || other.longestActivitySeconds == longestActivitySeconds)&&(identical(other.shortestActivitySeconds, shortestActivitySeconds) || other.shortestActivitySeconds == shortestActivitySeconds)&&const DeepCollectionEquality().equals(other._activitiesByModule, _activitiesByModule)&&(identical(other.mostCommonContext, mostCommonContext) || other.mostCommonContext == mostCommonContext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalActivities,totalDurationSeconds,averageDurationSeconds,longestActivitySeconds,shortestActivitySeconds,const DeepCollectionEquality().hash(_activitiesByModule),mostCommonContext);

@override
String toString() {
  return 'ActivityStatsResponse(totalActivities: $totalActivities, totalDurationSeconds: $totalDurationSeconds, averageDurationSeconds: $averageDurationSeconds, longestActivitySeconds: $longestActivitySeconds, shortestActivitySeconds: $shortestActivitySeconds, activitiesByModule: $activitiesByModule, mostCommonContext: $mostCommonContext)';
}


}

/// @nodoc
abstract mixin class _$ActivityStatsResponseCopyWith<$Res> implements $ActivityStatsResponseCopyWith<$Res> {
  factory _$ActivityStatsResponseCopyWith(_ActivityStatsResponse value, $Res Function(_ActivityStatsResponse) _then) = __$ActivityStatsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_activities') int totalActivities,@JsonKey(name: 'total_duration_seconds') int totalDurationSeconds,@JsonKey(name: 'average_duration_seconds') int averageDurationSeconds,@JsonKey(name: 'longest_activity_seconds') int longestActivitySeconds,@JsonKey(name: 'shortest_activity_seconds') int shortestActivitySeconds,@JsonKey(name: 'activities_by_module') List<ModuleCount> activitiesByModule,@JsonKey(name: 'most_common_context') ContextCount? mostCommonContext
});


@override $ContextCountCopyWith<$Res>? get mostCommonContext;

}
/// @nodoc
class __$ActivityStatsResponseCopyWithImpl<$Res>
    implements _$ActivityStatsResponseCopyWith<$Res> {
  __$ActivityStatsResponseCopyWithImpl(this._self, this._then);

  final _ActivityStatsResponse _self;
  final $Res Function(_ActivityStatsResponse) _then;

/// Create a copy of ActivityStatsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalActivities = null,Object? totalDurationSeconds = null,Object? averageDurationSeconds = null,Object? longestActivitySeconds = null,Object? shortestActivitySeconds = null,Object? activitiesByModule = null,Object? mostCommonContext = freezed,}) {
  return _then(_ActivityStatsResponse(
totalActivities: null == totalActivities ? _self.totalActivities : totalActivities // ignore: cast_nullable_to_non_nullable
as int,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,averageDurationSeconds: null == averageDurationSeconds ? _self.averageDurationSeconds : averageDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,longestActivitySeconds: null == longestActivitySeconds ? _self.longestActivitySeconds : longestActivitySeconds // ignore: cast_nullable_to_non_nullable
as int,shortestActivitySeconds: null == shortestActivitySeconds ? _self.shortestActivitySeconds : shortestActivitySeconds // ignore: cast_nullable_to_non_nullable
as int,activitiesByModule: null == activitiesByModule ? _self._activitiesByModule : activitiesByModule // ignore: cast_nullable_to_non_nullable
as List<ModuleCount>,mostCommonContext: freezed == mostCommonContext ? _self.mostCommonContext : mostCommonContext // ignore: cast_nullable_to_non_nullable
as ContextCount?,
  ));
}

/// Create a copy of ActivityStatsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextCountCopyWith<$Res>? get mostCommonContext {
    if (_self.mostCommonContext == null) {
    return null;
  }

  return $ContextCountCopyWith<$Res>(_self.mostCommonContext!, (value) {
    return _then(_self.copyWith(mostCommonContext: value));
  });
}
}

// dart format on
