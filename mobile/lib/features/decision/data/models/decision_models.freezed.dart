// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DecisionModel {

 String get id;@JsonKey(name: 'user_id') String? get userId; String get title;@JsonKey(name: 'decided_at') String? get decidedAt; String? get reason; String? get expectation;@JsonKey(name: 'completed_at') String? get completedAt;@JsonKey(name: 'actual_result') String? get actualResult; String? get learnings;@JsonKey(name: 'context_code') int? get contextCode;@JsonKey(name: 'context_label') String? get contextLabel; List<String>? get tags;@JsonKey(name: 'created_at') String get createdAt; String get status;
/// Create a copy of DecisionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionModelCopyWith<DecisionModel> get copyWith => _$DecisionModelCopyWithImpl<DecisionModel>(this as DecisionModel, _$identity);

  /// Serializes this DecisionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.expectation, expectation) || other.expectation == expectation)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.actualResult, actualResult) || other.actualResult == actualResult)&&(identical(other.learnings, learnings) || other.learnings == learnings)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,decidedAt,reason,expectation,completedAt,actualResult,learnings,contextCode,contextLabel,const DeepCollectionEquality().hash(tags),createdAt,status);

@override
String toString() {
  return 'DecisionModel(id: $id, userId: $userId, title: $title, decidedAt: $decidedAt, reason: $reason, expectation: $expectation, completedAt: $completedAt, actualResult: $actualResult, learnings: $learnings, contextCode: $contextCode, contextLabel: $contextLabel, tags: $tags, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $DecisionModelCopyWith<$Res>  {
  factory $DecisionModelCopyWith(DecisionModel value, $Res Function(DecisionModel) _then) = _$DecisionModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String? userId, String title,@JsonKey(name: 'decided_at') String? decidedAt, String? reason, String? expectation,@JsonKey(name: 'completed_at') String? completedAt,@JsonKey(name: 'actual_result') String? actualResult, String? learnings,@JsonKey(name: 'context_code') int? contextCode,@JsonKey(name: 'context_label') String? contextLabel, List<String>? tags,@JsonKey(name: 'created_at') String createdAt, String status
});




}
/// @nodoc
class _$DecisionModelCopyWithImpl<$Res>
    implements $DecisionModelCopyWith<$Res> {
  _$DecisionModelCopyWithImpl(this._self, this._then);

  final DecisionModel _self;
  final $Res Function(DecisionModel) _then;

/// Create a copy of DecisionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? title = null,Object? decidedAt = freezed,Object? reason = freezed,Object? expectation = freezed,Object? completedAt = freezed,Object? actualResult = freezed,Object? learnings = freezed,Object? contextCode = freezed,Object? contextLabel = freezed,Object? tags = freezed,Object? createdAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,expectation: freezed == expectation ? _self.expectation : expectation // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,actualResult: freezed == actualResult ? _self.actualResult : actualResult // ignore: cast_nullable_to_non_nullable
as String?,learnings: freezed == learnings ? _self.learnings : learnings // ignore: cast_nullable_to_non_nullable
as String?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,contextLabel: freezed == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DecisionModel].
extension DecisionModelPatterns on DecisionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecisionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecisionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecisionModel value)  $default,){
final _that = this;
switch (_that) {
case _DecisionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecisionModel value)?  $default,){
final _that = this;
switch (_that) {
case _DecisionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String? userId,  String title, @JsonKey(name: 'decided_at')  String? decidedAt,  String? reason,  String? expectation, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'actual_result')  String? actualResult,  String? learnings, @JsonKey(name: 'context_code')  int? contextCode, @JsonKey(name: 'context_label')  String? contextLabel,  List<String>? tags, @JsonKey(name: 'created_at')  String createdAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionModel() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.decidedAt,_that.reason,_that.expectation,_that.completedAt,_that.actualResult,_that.learnings,_that.contextCode,_that.contextLabel,_that.tags,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String? userId,  String title, @JsonKey(name: 'decided_at')  String? decidedAt,  String? reason,  String? expectation, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'actual_result')  String? actualResult,  String? learnings, @JsonKey(name: 'context_code')  int? contextCode, @JsonKey(name: 'context_label')  String? contextLabel,  List<String>? tags, @JsonKey(name: 'created_at')  String createdAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _DecisionModel():
return $default(_that.id,_that.userId,_that.title,_that.decidedAt,_that.reason,_that.expectation,_that.completedAt,_that.actualResult,_that.learnings,_that.contextCode,_that.contextLabel,_that.tags,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String? userId,  String title, @JsonKey(name: 'decided_at')  String? decidedAt,  String? reason,  String? expectation, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'actual_result')  String? actualResult,  String? learnings, @JsonKey(name: 'context_code')  int? contextCode, @JsonKey(name: 'context_label')  String? contextLabel,  List<String>? tags, @JsonKey(name: 'created_at')  String createdAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _DecisionModel() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.decidedAt,_that.reason,_that.expectation,_that.completedAt,_that.actualResult,_that.learnings,_that.contextCode,_that.contextLabel,_that.tags,_that.createdAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DecisionModel implements DecisionModel {
  const _DecisionModel({required this.id, @JsonKey(name: 'user_id') this.userId, required this.title, @JsonKey(name: 'decided_at') this.decidedAt, this.reason, this.expectation, @JsonKey(name: 'completed_at') this.completedAt, @JsonKey(name: 'actual_result') this.actualResult, this.learnings, @JsonKey(name: 'context_code') this.contextCode, @JsonKey(name: 'context_label') this.contextLabel, final  List<String>? tags, @JsonKey(name: 'created_at') required this.createdAt, required this.status}): _tags = tags;
  factory _DecisionModel.fromJson(Map<String, dynamic> json) => _$DecisionModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String? userId;
@override final  String title;
@override@JsonKey(name: 'decided_at') final  String? decidedAt;
@override final  String? reason;
@override final  String? expectation;
@override@JsonKey(name: 'completed_at') final  String? completedAt;
@override@JsonKey(name: 'actual_result') final  String? actualResult;
@override final  String? learnings;
@override@JsonKey(name: 'context_code') final  int? contextCode;
@override@JsonKey(name: 'context_label') final  String? contextLabel;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'created_at') final  String createdAt;
@override final  String status;

/// Create a copy of DecisionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionModelCopyWith<_DecisionModel> get copyWith => __$DecisionModelCopyWithImpl<_DecisionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DecisionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.expectation, expectation) || other.expectation == expectation)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.actualResult, actualResult) || other.actualResult == actualResult)&&(identical(other.learnings, learnings) || other.learnings == learnings)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,decidedAt,reason,expectation,completedAt,actualResult,learnings,contextCode,contextLabel,const DeepCollectionEquality().hash(_tags),createdAt,status);

@override
String toString() {
  return 'DecisionModel(id: $id, userId: $userId, title: $title, decidedAt: $decidedAt, reason: $reason, expectation: $expectation, completedAt: $completedAt, actualResult: $actualResult, learnings: $learnings, contextCode: $contextCode, contextLabel: $contextLabel, tags: $tags, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DecisionModelCopyWith<$Res> implements $DecisionModelCopyWith<$Res> {
  factory _$DecisionModelCopyWith(_DecisionModel value, $Res Function(_DecisionModel) _then) = __$DecisionModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String? userId, String title,@JsonKey(name: 'decided_at') String? decidedAt, String? reason, String? expectation,@JsonKey(name: 'completed_at') String? completedAt,@JsonKey(name: 'actual_result') String? actualResult, String? learnings,@JsonKey(name: 'context_code') int? contextCode,@JsonKey(name: 'context_label') String? contextLabel, List<String>? tags,@JsonKey(name: 'created_at') String createdAt, String status
});




}
/// @nodoc
class __$DecisionModelCopyWithImpl<$Res>
    implements _$DecisionModelCopyWith<$Res> {
  __$DecisionModelCopyWithImpl(this._self, this._then);

  final _DecisionModel _self;
  final $Res Function(_DecisionModel) _then;

/// Create a copy of DecisionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? title = null,Object? decidedAt = freezed,Object? reason = freezed,Object? expectation = freezed,Object? completedAt = freezed,Object? actualResult = freezed,Object? learnings = freezed,Object? contextCode = freezed,Object? contextLabel = freezed,Object? tags = freezed,Object? createdAt = null,Object? status = null,}) {
  return _then(_DecisionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,expectation: freezed == expectation ? _self.expectation : expectation // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,actualResult: freezed == actualResult ? _self.actualResult : actualResult // ignore: cast_nullable_to_non_nullable
as String?,learnings: freezed == learnings ? _self.learnings : learnings // ignore: cast_nullable_to_non_nullable
as String?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,contextLabel: freezed == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DecisionListResponse {

 List<DecisionModel> get decisions;
/// Create a copy of DecisionListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionListResponseCopyWith<DecisionListResponse> get copyWith => _$DecisionListResponseCopyWithImpl<DecisionListResponse>(this as DecisionListResponse, _$identity);

  /// Serializes this DecisionListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionListResponse&&const DeepCollectionEquality().equals(other.decisions, decisions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(decisions));

@override
String toString() {
  return 'DecisionListResponse(decisions: $decisions)';
}


}

/// @nodoc
abstract mixin class $DecisionListResponseCopyWith<$Res>  {
  factory $DecisionListResponseCopyWith(DecisionListResponse value, $Res Function(DecisionListResponse) _then) = _$DecisionListResponseCopyWithImpl;
@useResult
$Res call({
 List<DecisionModel> decisions
});




}
/// @nodoc
class _$DecisionListResponseCopyWithImpl<$Res>
    implements $DecisionListResponseCopyWith<$Res> {
  _$DecisionListResponseCopyWithImpl(this._self, this._then);

  final DecisionListResponse _self;
  final $Res Function(DecisionListResponse) _then;

/// Create a copy of DecisionListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? decisions = null,}) {
  return _then(_self.copyWith(
decisions: null == decisions ? _self.decisions : decisions // ignore: cast_nullable_to_non_nullable
as List<DecisionModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [DecisionListResponse].
extension DecisionListResponsePatterns on DecisionListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecisionListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecisionListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecisionListResponse value)  $default,){
final _that = this;
switch (_that) {
case _DecisionListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecisionListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DecisionListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DecisionModel> decisions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionListResponse() when $default != null:
return $default(_that.decisions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DecisionModel> decisions)  $default,) {final _that = this;
switch (_that) {
case _DecisionListResponse():
return $default(_that.decisions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DecisionModel> decisions)?  $default,) {final _that = this;
switch (_that) {
case _DecisionListResponse() when $default != null:
return $default(_that.decisions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DecisionListResponse implements DecisionListResponse {
  const _DecisionListResponse({required final  List<DecisionModel> decisions}): _decisions = decisions;
  factory _DecisionListResponse.fromJson(Map<String, dynamic> json) => _$DecisionListResponseFromJson(json);

 final  List<DecisionModel> _decisions;
@override List<DecisionModel> get decisions {
  if (_decisions is EqualUnmodifiableListView) return _decisions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_decisions);
}


/// Create a copy of DecisionListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionListResponseCopyWith<_DecisionListResponse> get copyWith => __$DecisionListResponseCopyWithImpl<_DecisionListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DecisionListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionListResponse&&const DeepCollectionEquality().equals(other._decisions, _decisions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_decisions));

@override
String toString() {
  return 'DecisionListResponse(decisions: $decisions)';
}


}

/// @nodoc
abstract mixin class _$DecisionListResponseCopyWith<$Res> implements $DecisionListResponseCopyWith<$Res> {
  factory _$DecisionListResponseCopyWith(_DecisionListResponse value, $Res Function(_DecisionListResponse) _then) = __$DecisionListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<DecisionModel> decisions
});




}
/// @nodoc
class __$DecisionListResponseCopyWithImpl<$Res>
    implements _$DecisionListResponseCopyWith<$Res> {
  __$DecisionListResponseCopyWithImpl(this._self, this._then);

  final _DecisionListResponse _self;
  final $Res Function(_DecisionListResponse) _then;

/// Create a copy of DecisionListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? decisions = null,}) {
  return _then(_DecisionListResponse(
decisions: null == decisions ? _self._decisions : decisions // ignore: cast_nullable_to_non_nullable
as List<DecisionModel>,
  ));
}


}


/// @nodoc
mixin _$CreateDecisionRequest {

 String get title;@JsonKey(name: 'decided_at') String? get decidedAt; String? get reason; String? get expectation;@JsonKey(name: 'completed_at') String? get completedAt;@JsonKey(name: 'actual_result') String? get actualResult; String? get learnings;@JsonKey(name: 'context_code') int? get contextCode; List<String>? get tags;
/// Create a copy of CreateDecisionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateDecisionRequestCopyWith<CreateDecisionRequest> get copyWith => _$CreateDecisionRequestCopyWithImpl<CreateDecisionRequest>(this as CreateDecisionRequest, _$identity);

  /// Serializes this CreateDecisionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateDecisionRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.expectation, expectation) || other.expectation == expectation)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.actualResult, actualResult) || other.actualResult == actualResult)&&(identical(other.learnings, learnings) || other.learnings == learnings)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,decidedAt,reason,expectation,completedAt,actualResult,learnings,contextCode,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'CreateDecisionRequest(title: $title, decidedAt: $decidedAt, reason: $reason, expectation: $expectation, completedAt: $completedAt, actualResult: $actualResult, learnings: $learnings, contextCode: $contextCode, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $CreateDecisionRequestCopyWith<$Res>  {
  factory $CreateDecisionRequestCopyWith(CreateDecisionRequest value, $Res Function(CreateDecisionRequest) _then) = _$CreateDecisionRequestCopyWithImpl;
@useResult
$Res call({
 String title,@JsonKey(name: 'decided_at') String? decidedAt, String? reason, String? expectation,@JsonKey(name: 'completed_at') String? completedAt,@JsonKey(name: 'actual_result') String? actualResult, String? learnings,@JsonKey(name: 'context_code') int? contextCode, List<String>? tags
});




}
/// @nodoc
class _$CreateDecisionRequestCopyWithImpl<$Res>
    implements $CreateDecisionRequestCopyWith<$Res> {
  _$CreateDecisionRequestCopyWithImpl(this._self, this._then);

  final CreateDecisionRequest _self;
  final $Res Function(CreateDecisionRequest) _then;

/// Create a copy of CreateDecisionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? decidedAt = freezed,Object? reason = freezed,Object? expectation = freezed,Object? completedAt = freezed,Object? actualResult = freezed,Object? learnings = freezed,Object? contextCode = freezed,Object? tags = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,expectation: freezed == expectation ? _self.expectation : expectation // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,actualResult: freezed == actualResult ? _self.actualResult : actualResult // ignore: cast_nullable_to_non_nullable
as String?,learnings: freezed == learnings ? _self.learnings : learnings // ignore: cast_nullable_to_non_nullable
as String?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateDecisionRequest].
extension CreateDecisionRequestPatterns on CreateDecisionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateDecisionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateDecisionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateDecisionRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateDecisionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateDecisionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateDecisionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'decided_at')  String? decidedAt,  String? reason,  String? expectation, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'actual_result')  String? actualResult,  String? learnings, @JsonKey(name: 'context_code')  int? contextCode,  List<String>? tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateDecisionRequest() when $default != null:
return $default(_that.title,_that.decidedAt,_that.reason,_that.expectation,_that.completedAt,_that.actualResult,_that.learnings,_that.contextCode,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'decided_at')  String? decidedAt,  String? reason,  String? expectation, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'actual_result')  String? actualResult,  String? learnings, @JsonKey(name: 'context_code')  int? contextCode,  List<String>? tags)  $default,) {final _that = this;
switch (_that) {
case _CreateDecisionRequest():
return $default(_that.title,_that.decidedAt,_that.reason,_that.expectation,_that.completedAt,_that.actualResult,_that.learnings,_that.contextCode,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title, @JsonKey(name: 'decided_at')  String? decidedAt,  String? reason,  String? expectation, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'actual_result')  String? actualResult,  String? learnings, @JsonKey(name: 'context_code')  int? contextCode,  List<String>? tags)?  $default,) {final _that = this;
switch (_that) {
case _CreateDecisionRequest() when $default != null:
return $default(_that.title,_that.decidedAt,_that.reason,_that.expectation,_that.completedAt,_that.actualResult,_that.learnings,_that.contextCode,_that.tags);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CreateDecisionRequest implements CreateDecisionRequest {
  const _CreateDecisionRequest({required this.title, @JsonKey(name: 'decided_at') this.decidedAt, this.reason, this.expectation, @JsonKey(name: 'completed_at') this.completedAt, @JsonKey(name: 'actual_result') this.actualResult, this.learnings, @JsonKey(name: 'context_code') this.contextCode, final  List<String>? tags}): _tags = tags;
  factory _CreateDecisionRequest.fromJson(Map<String, dynamic> json) => _$CreateDecisionRequestFromJson(json);

@override final  String title;
@override@JsonKey(name: 'decided_at') final  String? decidedAt;
@override final  String? reason;
@override final  String? expectation;
@override@JsonKey(name: 'completed_at') final  String? completedAt;
@override@JsonKey(name: 'actual_result') final  String? actualResult;
@override final  String? learnings;
@override@JsonKey(name: 'context_code') final  int? contextCode;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CreateDecisionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateDecisionRequestCopyWith<_CreateDecisionRequest> get copyWith => __$CreateDecisionRequestCopyWithImpl<_CreateDecisionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateDecisionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateDecisionRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.expectation, expectation) || other.expectation == expectation)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.actualResult, actualResult) || other.actualResult == actualResult)&&(identical(other.learnings, learnings) || other.learnings == learnings)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,decidedAt,reason,expectation,completedAt,actualResult,learnings,contextCode,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'CreateDecisionRequest(title: $title, decidedAt: $decidedAt, reason: $reason, expectation: $expectation, completedAt: $completedAt, actualResult: $actualResult, learnings: $learnings, contextCode: $contextCode, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$CreateDecisionRequestCopyWith<$Res> implements $CreateDecisionRequestCopyWith<$Res> {
  factory _$CreateDecisionRequestCopyWith(_CreateDecisionRequest value, $Res Function(_CreateDecisionRequest) _then) = __$CreateDecisionRequestCopyWithImpl;
@override @useResult
$Res call({
 String title,@JsonKey(name: 'decided_at') String? decidedAt, String? reason, String? expectation,@JsonKey(name: 'completed_at') String? completedAt,@JsonKey(name: 'actual_result') String? actualResult, String? learnings,@JsonKey(name: 'context_code') int? contextCode, List<String>? tags
});




}
/// @nodoc
class __$CreateDecisionRequestCopyWithImpl<$Res>
    implements _$CreateDecisionRequestCopyWith<$Res> {
  __$CreateDecisionRequestCopyWithImpl(this._self, this._then);

  final _CreateDecisionRequest _self;
  final $Res Function(_CreateDecisionRequest) _then;

/// Create a copy of CreateDecisionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? decidedAt = freezed,Object? reason = freezed,Object? expectation = freezed,Object? completedAt = freezed,Object? actualResult = freezed,Object? learnings = freezed,Object? contextCode = freezed,Object? tags = freezed,}) {
  return _then(_CreateDecisionRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,expectation: freezed == expectation ? _self.expectation : expectation // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,actualResult: freezed == actualResult ? _self.actualResult : actualResult // ignore: cast_nullable_to_non_nullable
as String?,learnings: freezed == learnings ? _self.learnings : learnings // ignore: cast_nullable_to_non_nullable
as String?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$UpdateDecisionRequest {

 String? get title;@JsonKey(name: 'decided_at') String? get decidedAt; String? get reason; String? get expectation;@JsonKey(name: 'completed_at') String? get completedAt;@JsonKey(name: 'actual_result') String? get actualResult; String? get learnings;@JsonKey(name: 'context_code') int? get contextCode; List<String>? get tags;
/// Create a copy of UpdateDecisionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateDecisionRequestCopyWith<UpdateDecisionRequest> get copyWith => _$UpdateDecisionRequestCopyWithImpl<UpdateDecisionRequest>(this as UpdateDecisionRequest, _$identity);

  /// Serializes this UpdateDecisionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateDecisionRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.expectation, expectation) || other.expectation == expectation)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.actualResult, actualResult) || other.actualResult == actualResult)&&(identical(other.learnings, learnings) || other.learnings == learnings)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,decidedAt,reason,expectation,completedAt,actualResult,learnings,contextCode,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'UpdateDecisionRequest(title: $title, decidedAt: $decidedAt, reason: $reason, expectation: $expectation, completedAt: $completedAt, actualResult: $actualResult, learnings: $learnings, contextCode: $contextCode, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $UpdateDecisionRequestCopyWith<$Res>  {
  factory $UpdateDecisionRequestCopyWith(UpdateDecisionRequest value, $Res Function(UpdateDecisionRequest) _then) = _$UpdateDecisionRequestCopyWithImpl;
@useResult
$Res call({
 String? title,@JsonKey(name: 'decided_at') String? decidedAt, String? reason, String? expectation,@JsonKey(name: 'completed_at') String? completedAt,@JsonKey(name: 'actual_result') String? actualResult, String? learnings,@JsonKey(name: 'context_code') int? contextCode, List<String>? tags
});




}
/// @nodoc
class _$UpdateDecisionRequestCopyWithImpl<$Res>
    implements $UpdateDecisionRequestCopyWith<$Res> {
  _$UpdateDecisionRequestCopyWithImpl(this._self, this._then);

  final UpdateDecisionRequest _self;
  final $Res Function(UpdateDecisionRequest) _then;

/// Create a copy of UpdateDecisionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? decidedAt = freezed,Object? reason = freezed,Object? expectation = freezed,Object? completedAt = freezed,Object? actualResult = freezed,Object? learnings = freezed,Object? contextCode = freezed,Object? tags = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,expectation: freezed == expectation ? _self.expectation : expectation // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,actualResult: freezed == actualResult ? _self.actualResult : actualResult // ignore: cast_nullable_to_non_nullable
as String?,learnings: freezed == learnings ? _self.learnings : learnings // ignore: cast_nullable_to_non_nullable
as String?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateDecisionRequest].
extension UpdateDecisionRequestPatterns on UpdateDecisionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateDecisionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateDecisionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateDecisionRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateDecisionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateDecisionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateDecisionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title, @JsonKey(name: 'decided_at')  String? decidedAt,  String? reason,  String? expectation, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'actual_result')  String? actualResult,  String? learnings, @JsonKey(name: 'context_code')  int? contextCode,  List<String>? tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateDecisionRequest() when $default != null:
return $default(_that.title,_that.decidedAt,_that.reason,_that.expectation,_that.completedAt,_that.actualResult,_that.learnings,_that.contextCode,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title, @JsonKey(name: 'decided_at')  String? decidedAt,  String? reason,  String? expectation, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'actual_result')  String? actualResult,  String? learnings, @JsonKey(name: 'context_code')  int? contextCode,  List<String>? tags)  $default,) {final _that = this;
switch (_that) {
case _UpdateDecisionRequest():
return $default(_that.title,_that.decidedAt,_that.reason,_that.expectation,_that.completedAt,_that.actualResult,_that.learnings,_that.contextCode,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title, @JsonKey(name: 'decided_at')  String? decidedAt,  String? reason,  String? expectation, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'actual_result')  String? actualResult,  String? learnings, @JsonKey(name: 'context_code')  int? contextCode,  List<String>? tags)?  $default,) {final _that = this;
switch (_that) {
case _UpdateDecisionRequest() when $default != null:
return $default(_that.title,_that.decidedAt,_that.reason,_that.expectation,_that.completedAt,_that.actualResult,_that.learnings,_that.contextCode,_that.tags);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _UpdateDecisionRequest implements UpdateDecisionRequest {
  const _UpdateDecisionRequest({this.title, @JsonKey(name: 'decided_at') this.decidedAt, this.reason, this.expectation, @JsonKey(name: 'completed_at') this.completedAt, @JsonKey(name: 'actual_result') this.actualResult, this.learnings, @JsonKey(name: 'context_code') this.contextCode, final  List<String>? tags}): _tags = tags;
  factory _UpdateDecisionRequest.fromJson(Map<String, dynamic> json) => _$UpdateDecisionRequestFromJson(json);

@override final  String? title;
@override@JsonKey(name: 'decided_at') final  String? decidedAt;
@override final  String? reason;
@override final  String? expectation;
@override@JsonKey(name: 'completed_at') final  String? completedAt;
@override@JsonKey(name: 'actual_result') final  String? actualResult;
@override final  String? learnings;
@override@JsonKey(name: 'context_code') final  int? contextCode;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UpdateDecisionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDecisionRequestCopyWith<_UpdateDecisionRequest> get copyWith => __$UpdateDecisionRequestCopyWithImpl<_UpdateDecisionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateDecisionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateDecisionRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.expectation, expectation) || other.expectation == expectation)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.actualResult, actualResult) || other.actualResult == actualResult)&&(identical(other.learnings, learnings) || other.learnings == learnings)&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,decidedAt,reason,expectation,completedAt,actualResult,learnings,contextCode,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'UpdateDecisionRequest(title: $title, decidedAt: $decidedAt, reason: $reason, expectation: $expectation, completedAt: $completedAt, actualResult: $actualResult, learnings: $learnings, contextCode: $contextCode, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$UpdateDecisionRequestCopyWith<$Res> implements $UpdateDecisionRequestCopyWith<$Res> {
  factory _$UpdateDecisionRequestCopyWith(_UpdateDecisionRequest value, $Res Function(_UpdateDecisionRequest) _then) = __$UpdateDecisionRequestCopyWithImpl;
@override @useResult
$Res call({
 String? title,@JsonKey(name: 'decided_at') String? decidedAt, String? reason, String? expectation,@JsonKey(name: 'completed_at') String? completedAt,@JsonKey(name: 'actual_result') String? actualResult, String? learnings,@JsonKey(name: 'context_code') int? contextCode, List<String>? tags
});




}
/// @nodoc
class __$UpdateDecisionRequestCopyWithImpl<$Res>
    implements _$UpdateDecisionRequestCopyWith<$Res> {
  __$UpdateDecisionRequestCopyWithImpl(this._self, this._then);

  final _UpdateDecisionRequest _self;
  final $Res Function(_UpdateDecisionRequest) _then;

/// Create a copy of UpdateDecisionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? decidedAt = freezed,Object? reason = freezed,Object? expectation = freezed,Object? completedAt = freezed,Object? actualResult = freezed,Object? learnings = freezed,Object? contextCode = freezed,Object? tags = freezed,}) {
  return _then(_UpdateDecisionRequest(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,expectation: freezed == expectation ? _self.expectation : expectation // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,actualResult: freezed == actualResult ? _self.actualResult : actualResult // ignore: cast_nullable_to_non_nullable
as String?,learnings: freezed == learnings ? _self.learnings : learnings // ignore: cast_nullable_to_non_nullable
as String?,contextCode: freezed == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$DecisionStatsModel {

@JsonKey(name: 'total_decisions') int get totalDecisions;@JsonKey(name: 'pending_decisions') int get pendingDecisions;@JsonKey(name: 'completed_decisions') int get completedDecisions;@JsonKey(name: 'decisions_this_week') int get decisionsThisWeek;@JsonKey(name: 'decisions_this_month') int get decisionsThisMonth;@JsonKey(name: 'avg_time_to_completion_days') double? get avgTimeToCompletionDays;@JsonKey(name: 'most_common_context') ContextCountModel? get mostCommonContext;@JsonKey(name: 'by_month') List<MonthCountModel> get byMonth;@JsonKey(name: 'by_context') List<ContextCountModel> get byContext;
/// Create a copy of DecisionStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionStatsModelCopyWith<DecisionStatsModel> get copyWith => _$DecisionStatsModelCopyWithImpl<DecisionStatsModel>(this as DecisionStatsModel, _$identity);

  /// Serializes this DecisionStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionStatsModel&&(identical(other.totalDecisions, totalDecisions) || other.totalDecisions == totalDecisions)&&(identical(other.pendingDecisions, pendingDecisions) || other.pendingDecisions == pendingDecisions)&&(identical(other.completedDecisions, completedDecisions) || other.completedDecisions == completedDecisions)&&(identical(other.decisionsThisWeek, decisionsThisWeek) || other.decisionsThisWeek == decisionsThisWeek)&&(identical(other.decisionsThisMonth, decisionsThisMonth) || other.decisionsThisMonth == decisionsThisMonth)&&(identical(other.avgTimeToCompletionDays, avgTimeToCompletionDays) || other.avgTimeToCompletionDays == avgTimeToCompletionDays)&&(identical(other.mostCommonContext, mostCommonContext) || other.mostCommonContext == mostCommonContext)&&const DeepCollectionEquality().equals(other.byMonth, byMonth)&&const DeepCollectionEquality().equals(other.byContext, byContext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDecisions,pendingDecisions,completedDecisions,decisionsThisWeek,decisionsThisMonth,avgTimeToCompletionDays,mostCommonContext,const DeepCollectionEquality().hash(byMonth),const DeepCollectionEquality().hash(byContext));

@override
String toString() {
  return 'DecisionStatsModel(totalDecisions: $totalDecisions, pendingDecisions: $pendingDecisions, completedDecisions: $completedDecisions, decisionsThisWeek: $decisionsThisWeek, decisionsThisMonth: $decisionsThisMonth, avgTimeToCompletionDays: $avgTimeToCompletionDays, mostCommonContext: $mostCommonContext, byMonth: $byMonth, byContext: $byContext)';
}


}

/// @nodoc
abstract mixin class $DecisionStatsModelCopyWith<$Res>  {
  factory $DecisionStatsModelCopyWith(DecisionStatsModel value, $Res Function(DecisionStatsModel) _then) = _$DecisionStatsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_decisions') int totalDecisions,@JsonKey(name: 'pending_decisions') int pendingDecisions,@JsonKey(name: 'completed_decisions') int completedDecisions,@JsonKey(name: 'decisions_this_week') int decisionsThisWeek,@JsonKey(name: 'decisions_this_month') int decisionsThisMonth,@JsonKey(name: 'avg_time_to_completion_days') double? avgTimeToCompletionDays,@JsonKey(name: 'most_common_context') ContextCountModel? mostCommonContext,@JsonKey(name: 'by_month') List<MonthCountModel> byMonth,@JsonKey(name: 'by_context') List<ContextCountModel> byContext
});


$ContextCountModelCopyWith<$Res>? get mostCommonContext;

}
/// @nodoc
class _$DecisionStatsModelCopyWithImpl<$Res>
    implements $DecisionStatsModelCopyWith<$Res> {
  _$DecisionStatsModelCopyWithImpl(this._self, this._then);

  final DecisionStatsModel _self;
  final $Res Function(DecisionStatsModel) _then;

/// Create a copy of DecisionStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalDecisions = null,Object? pendingDecisions = null,Object? completedDecisions = null,Object? decisionsThisWeek = null,Object? decisionsThisMonth = null,Object? avgTimeToCompletionDays = freezed,Object? mostCommonContext = freezed,Object? byMonth = null,Object? byContext = null,}) {
  return _then(_self.copyWith(
totalDecisions: null == totalDecisions ? _self.totalDecisions : totalDecisions // ignore: cast_nullable_to_non_nullable
as int,pendingDecisions: null == pendingDecisions ? _self.pendingDecisions : pendingDecisions // ignore: cast_nullable_to_non_nullable
as int,completedDecisions: null == completedDecisions ? _self.completedDecisions : completedDecisions // ignore: cast_nullable_to_non_nullable
as int,decisionsThisWeek: null == decisionsThisWeek ? _self.decisionsThisWeek : decisionsThisWeek // ignore: cast_nullable_to_non_nullable
as int,decisionsThisMonth: null == decisionsThisMonth ? _self.decisionsThisMonth : decisionsThisMonth // ignore: cast_nullable_to_non_nullable
as int,avgTimeToCompletionDays: freezed == avgTimeToCompletionDays ? _self.avgTimeToCompletionDays : avgTimeToCompletionDays // ignore: cast_nullable_to_non_nullable
as double?,mostCommonContext: freezed == mostCommonContext ? _self.mostCommonContext : mostCommonContext // ignore: cast_nullable_to_non_nullable
as ContextCountModel?,byMonth: null == byMonth ? _self.byMonth : byMonth // ignore: cast_nullable_to_non_nullable
as List<MonthCountModel>,byContext: null == byContext ? _self.byContext : byContext // ignore: cast_nullable_to_non_nullable
as List<ContextCountModel>,
  ));
}
/// Create a copy of DecisionStatsModel
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


/// Adds pattern-matching-related methods to [DecisionStatsModel].
extension DecisionStatsModelPatterns on DecisionStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DecisionStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DecisionStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DecisionStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _DecisionStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DecisionStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _DecisionStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_decisions')  int totalDecisions, @JsonKey(name: 'pending_decisions')  int pendingDecisions, @JsonKey(name: 'completed_decisions')  int completedDecisions, @JsonKey(name: 'decisions_this_week')  int decisionsThisWeek, @JsonKey(name: 'decisions_this_month')  int decisionsThisMonth, @JsonKey(name: 'avg_time_to_completion_days')  double? avgTimeToCompletionDays, @JsonKey(name: 'most_common_context')  ContextCountModel? mostCommonContext, @JsonKey(name: 'by_month')  List<MonthCountModel> byMonth, @JsonKey(name: 'by_context')  List<ContextCountModel> byContext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DecisionStatsModel() when $default != null:
return $default(_that.totalDecisions,_that.pendingDecisions,_that.completedDecisions,_that.decisionsThisWeek,_that.decisionsThisMonth,_that.avgTimeToCompletionDays,_that.mostCommonContext,_that.byMonth,_that.byContext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_decisions')  int totalDecisions, @JsonKey(name: 'pending_decisions')  int pendingDecisions, @JsonKey(name: 'completed_decisions')  int completedDecisions, @JsonKey(name: 'decisions_this_week')  int decisionsThisWeek, @JsonKey(name: 'decisions_this_month')  int decisionsThisMonth, @JsonKey(name: 'avg_time_to_completion_days')  double? avgTimeToCompletionDays, @JsonKey(name: 'most_common_context')  ContextCountModel? mostCommonContext, @JsonKey(name: 'by_month')  List<MonthCountModel> byMonth, @JsonKey(name: 'by_context')  List<ContextCountModel> byContext)  $default,) {final _that = this;
switch (_that) {
case _DecisionStatsModel():
return $default(_that.totalDecisions,_that.pendingDecisions,_that.completedDecisions,_that.decisionsThisWeek,_that.decisionsThisMonth,_that.avgTimeToCompletionDays,_that.mostCommonContext,_that.byMonth,_that.byContext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_decisions')  int totalDecisions, @JsonKey(name: 'pending_decisions')  int pendingDecisions, @JsonKey(name: 'completed_decisions')  int completedDecisions, @JsonKey(name: 'decisions_this_week')  int decisionsThisWeek, @JsonKey(name: 'decisions_this_month')  int decisionsThisMonth, @JsonKey(name: 'avg_time_to_completion_days')  double? avgTimeToCompletionDays, @JsonKey(name: 'most_common_context')  ContextCountModel? mostCommonContext, @JsonKey(name: 'by_month')  List<MonthCountModel> byMonth, @JsonKey(name: 'by_context')  List<ContextCountModel> byContext)?  $default,) {final _that = this;
switch (_that) {
case _DecisionStatsModel() when $default != null:
return $default(_that.totalDecisions,_that.pendingDecisions,_that.completedDecisions,_that.decisionsThisWeek,_that.decisionsThisMonth,_that.avgTimeToCompletionDays,_that.mostCommonContext,_that.byMonth,_that.byContext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DecisionStatsModel implements DecisionStatsModel {
  const _DecisionStatsModel({@JsonKey(name: 'total_decisions') required this.totalDecisions, @JsonKey(name: 'pending_decisions') required this.pendingDecisions, @JsonKey(name: 'completed_decisions') required this.completedDecisions, @JsonKey(name: 'decisions_this_week') required this.decisionsThisWeek, @JsonKey(name: 'decisions_this_month') required this.decisionsThisMonth, @JsonKey(name: 'avg_time_to_completion_days') this.avgTimeToCompletionDays, @JsonKey(name: 'most_common_context') this.mostCommonContext, @JsonKey(name: 'by_month') final  List<MonthCountModel> byMonth = const [], @JsonKey(name: 'by_context') final  List<ContextCountModel> byContext = const []}): _byMonth = byMonth,_byContext = byContext;
  factory _DecisionStatsModel.fromJson(Map<String, dynamic> json) => _$DecisionStatsModelFromJson(json);

@override@JsonKey(name: 'total_decisions') final  int totalDecisions;
@override@JsonKey(name: 'pending_decisions') final  int pendingDecisions;
@override@JsonKey(name: 'completed_decisions') final  int completedDecisions;
@override@JsonKey(name: 'decisions_this_week') final  int decisionsThisWeek;
@override@JsonKey(name: 'decisions_this_month') final  int decisionsThisMonth;
@override@JsonKey(name: 'avg_time_to_completion_days') final  double? avgTimeToCompletionDays;
@override@JsonKey(name: 'most_common_context') final  ContextCountModel? mostCommonContext;
 final  List<MonthCountModel> _byMonth;
@override@JsonKey(name: 'by_month') List<MonthCountModel> get byMonth {
  if (_byMonth is EqualUnmodifiableListView) return _byMonth;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byMonth);
}

 final  List<ContextCountModel> _byContext;
@override@JsonKey(name: 'by_context') List<ContextCountModel> get byContext {
  if (_byContext is EqualUnmodifiableListView) return _byContext;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byContext);
}


/// Create a copy of DecisionStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionStatsModelCopyWith<_DecisionStatsModel> get copyWith => __$DecisionStatsModelCopyWithImpl<_DecisionStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DecisionStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionStatsModel&&(identical(other.totalDecisions, totalDecisions) || other.totalDecisions == totalDecisions)&&(identical(other.pendingDecisions, pendingDecisions) || other.pendingDecisions == pendingDecisions)&&(identical(other.completedDecisions, completedDecisions) || other.completedDecisions == completedDecisions)&&(identical(other.decisionsThisWeek, decisionsThisWeek) || other.decisionsThisWeek == decisionsThisWeek)&&(identical(other.decisionsThisMonth, decisionsThisMonth) || other.decisionsThisMonth == decisionsThisMonth)&&(identical(other.avgTimeToCompletionDays, avgTimeToCompletionDays) || other.avgTimeToCompletionDays == avgTimeToCompletionDays)&&(identical(other.mostCommonContext, mostCommonContext) || other.mostCommonContext == mostCommonContext)&&const DeepCollectionEquality().equals(other._byMonth, _byMonth)&&const DeepCollectionEquality().equals(other._byContext, _byContext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDecisions,pendingDecisions,completedDecisions,decisionsThisWeek,decisionsThisMonth,avgTimeToCompletionDays,mostCommonContext,const DeepCollectionEquality().hash(_byMonth),const DeepCollectionEquality().hash(_byContext));

@override
String toString() {
  return 'DecisionStatsModel(totalDecisions: $totalDecisions, pendingDecisions: $pendingDecisions, completedDecisions: $completedDecisions, decisionsThisWeek: $decisionsThisWeek, decisionsThisMonth: $decisionsThisMonth, avgTimeToCompletionDays: $avgTimeToCompletionDays, mostCommonContext: $mostCommonContext, byMonth: $byMonth, byContext: $byContext)';
}


}

/// @nodoc
abstract mixin class _$DecisionStatsModelCopyWith<$Res> implements $DecisionStatsModelCopyWith<$Res> {
  factory _$DecisionStatsModelCopyWith(_DecisionStatsModel value, $Res Function(_DecisionStatsModel) _then) = __$DecisionStatsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_decisions') int totalDecisions,@JsonKey(name: 'pending_decisions') int pendingDecisions,@JsonKey(name: 'completed_decisions') int completedDecisions,@JsonKey(name: 'decisions_this_week') int decisionsThisWeek,@JsonKey(name: 'decisions_this_month') int decisionsThisMonth,@JsonKey(name: 'avg_time_to_completion_days') double? avgTimeToCompletionDays,@JsonKey(name: 'most_common_context') ContextCountModel? mostCommonContext,@JsonKey(name: 'by_month') List<MonthCountModel> byMonth,@JsonKey(name: 'by_context') List<ContextCountModel> byContext
});


@override $ContextCountModelCopyWith<$Res>? get mostCommonContext;

}
/// @nodoc
class __$DecisionStatsModelCopyWithImpl<$Res>
    implements _$DecisionStatsModelCopyWith<$Res> {
  __$DecisionStatsModelCopyWithImpl(this._self, this._then);

  final _DecisionStatsModel _self;
  final $Res Function(_DecisionStatsModel) _then;

/// Create a copy of DecisionStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalDecisions = null,Object? pendingDecisions = null,Object? completedDecisions = null,Object? decisionsThisWeek = null,Object? decisionsThisMonth = null,Object? avgTimeToCompletionDays = freezed,Object? mostCommonContext = freezed,Object? byMonth = null,Object? byContext = null,}) {
  return _then(_DecisionStatsModel(
totalDecisions: null == totalDecisions ? _self.totalDecisions : totalDecisions // ignore: cast_nullable_to_non_nullable
as int,pendingDecisions: null == pendingDecisions ? _self.pendingDecisions : pendingDecisions // ignore: cast_nullable_to_non_nullable
as int,completedDecisions: null == completedDecisions ? _self.completedDecisions : completedDecisions // ignore: cast_nullable_to_non_nullable
as int,decisionsThisWeek: null == decisionsThisWeek ? _self.decisionsThisWeek : decisionsThisWeek // ignore: cast_nullable_to_non_nullable
as int,decisionsThisMonth: null == decisionsThisMonth ? _self.decisionsThisMonth : decisionsThisMonth // ignore: cast_nullable_to_non_nullable
as int,avgTimeToCompletionDays: freezed == avgTimeToCompletionDays ? _self.avgTimeToCompletionDays : avgTimeToCompletionDays // ignore: cast_nullable_to_non_nullable
as double?,mostCommonContext: freezed == mostCommonContext ? _self.mostCommonContext : mostCommonContext // ignore: cast_nullable_to_non_nullable
as ContextCountModel?,byMonth: null == byMonth ? _self._byMonth : byMonth // ignore: cast_nullable_to_non_nullable
as List<MonthCountModel>,byContext: null == byContext ? _self._byContext : byContext // ignore: cast_nullable_to_non_nullable
as List<ContextCountModel>,
  ));
}

/// Create a copy of DecisionStatsModel
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


/// @nodoc
mixin _$ContextCountModel {

@JsonKey(name: 'context_code') int get contextCode;@JsonKey(name: 'context_label') String get contextLabel; int get count;
/// Create a copy of ContextCountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContextCountModelCopyWith<ContextCountModel> get copyWith => _$ContextCountModelCopyWithImpl<ContextCountModel>(this as ContextCountModel, _$identity);

  /// Serializes this ContextCountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContextCountModel&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contextCode,contextLabel,count);

@override
String toString() {
  return 'ContextCountModel(contextCode: $contextCode, contextLabel: $contextLabel, count: $count)';
}


}

/// @nodoc
abstract mixin class $ContextCountModelCopyWith<$Res>  {
  factory $ContextCountModelCopyWith(ContextCountModel value, $Res Function(ContextCountModel) _then) = _$ContextCountModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'context_code') int contextCode,@JsonKey(name: 'context_label') String contextLabel, int count
});




}
/// @nodoc
class _$ContextCountModelCopyWithImpl<$Res>
    implements $ContextCountModelCopyWith<$Res> {
  _$ContextCountModelCopyWithImpl(this._self, this._then);

  final ContextCountModel _self;
  final $Res Function(ContextCountModel) _then;

/// Create a copy of ContextCountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contextCode = null,Object? contextLabel = null,Object? count = null,}) {
  return _then(_self.copyWith(
contextCode: null == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int,contextLabel: null == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ContextCountModel].
extension ContextCountModelPatterns on ContextCountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContextCountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContextCountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContextCountModel value)  $default,){
final _that = this;
switch (_that) {
case _ContextCountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContextCountModel value)?  $default,){
final _that = this;
switch (_that) {
case _ContextCountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'context_code')  int contextCode, @JsonKey(name: 'context_label')  String contextLabel,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContextCountModel() when $default != null:
return $default(_that.contextCode,_that.contextLabel,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'context_code')  int contextCode, @JsonKey(name: 'context_label')  String contextLabel,  int count)  $default,) {final _that = this;
switch (_that) {
case _ContextCountModel():
return $default(_that.contextCode,_that.contextLabel,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'context_code')  int contextCode, @JsonKey(name: 'context_label')  String contextLabel,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ContextCountModel() when $default != null:
return $default(_that.contextCode,_that.contextLabel,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContextCountModel implements ContextCountModel {
  const _ContextCountModel({@JsonKey(name: 'context_code') required this.contextCode, @JsonKey(name: 'context_label') required this.contextLabel, required this.count});
  factory _ContextCountModel.fromJson(Map<String, dynamic> json) => _$ContextCountModelFromJson(json);

@override@JsonKey(name: 'context_code') final  int contextCode;
@override@JsonKey(name: 'context_label') final  String contextLabel;
@override final  int count;

/// Create a copy of ContextCountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContextCountModelCopyWith<_ContextCountModel> get copyWith => __$ContextCountModelCopyWithImpl<_ContextCountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContextCountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContextCountModel&&(identical(other.contextCode, contextCode) || other.contextCode == contextCode)&&(identical(other.contextLabel, contextLabel) || other.contextLabel == contextLabel)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contextCode,contextLabel,count);

@override
String toString() {
  return 'ContextCountModel(contextCode: $contextCode, contextLabel: $contextLabel, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ContextCountModelCopyWith<$Res> implements $ContextCountModelCopyWith<$Res> {
  factory _$ContextCountModelCopyWith(_ContextCountModel value, $Res Function(_ContextCountModel) _then) = __$ContextCountModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'context_code') int contextCode,@JsonKey(name: 'context_label') String contextLabel, int count
});




}
/// @nodoc
class __$ContextCountModelCopyWithImpl<$Res>
    implements _$ContextCountModelCopyWith<$Res> {
  __$ContextCountModelCopyWithImpl(this._self, this._then);

  final _ContextCountModel _self;
  final $Res Function(_ContextCountModel) _then;

/// Create a copy of ContextCountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contextCode = null,Object? contextLabel = null,Object? count = null,}) {
  return _then(_ContextCountModel(
contextCode: null == contextCode ? _self.contextCode : contextCode // ignore: cast_nullable_to_non_nullable
as int,contextLabel: null == contextLabel ? _self.contextLabel : contextLabel // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MonthCountModel {

 String get month; int get count;
/// Create a copy of MonthCountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthCountModelCopyWith<MonthCountModel> get copyWith => _$MonthCountModelCopyWithImpl<MonthCountModel>(this as MonthCountModel, _$identity);

  /// Serializes this MonthCountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthCountModel&&(identical(other.month, month) || other.month == month)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,count);

@override
String toString() {
  return 'MonthCountModel(month: $month, count: $count)';
}


}

/// @nodoc
abstract mixin class $MonthCountModelCopyWith<$Res>  {
  factory $MonthCountModelCopyWith(MonthCountModel value, $Res Function(MonthCountModel) _then) = _$MonthCountModelCopyWithImpl;
@useResult
$Res call({
 String month, int count
});




}
/// @nodoc
class _$MonthCountModelCopyWithImpl<$Res>
    implements $MonthCountModelCopyWith<$Res> {
  _$MonthCountModelCopyWithImpl(this._self, this._then);

  final MonthCountModel _self;
  final $Res Function(MonthCountModel) _then;

/// Create a copy of MonthCountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? count = null,}) {
  return _then(_self.copyWith(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthCountModel].
extension MonthCountModelPatterns on MonthCountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthCountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthCountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthCountModel value)  $default,){
final _that = this;
switch (_that) {
case _MonthCountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthCountModel value)?  $default,){
final _that = this;
switch (_that) {
case _MonthCountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthCountModel() when $default != null:
return $default(_that.month,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  int count)  $default,) {final _that = this;
switch (_that) {
case _MonthCountModel():
return $default(_that.month,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  int count)?  $default,) {final _that = this;
switch (_that) {
case _MonthCountModel() when $default != null:
return $default(_that.month,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthCountModel implements MonthCountModel {
  const _MonthCountModel({required this.month, required this.count});
  factory _MonthCountModel.fromJson(Map<String, dynamic> json) => _$MonthCountModelFromJson(json);

@override final  String month;
@override final  int count;

/// Create a copy of MonthCountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthCountModelCopyWith<_MonthCountModel> get copyWith => __$MonthCountModelCopyWithImpl<_MonthCountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthCountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthCountModel&&(identical(other.month, month) || other.month == month)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,count);

@override
String toString() {
  return 'MonthCountModel(month: $month, count: $count)';
}


}

/// @nodoc
abstract mixin class _$MonthCountModelCopyWith<$Res> implements $MonthCountModelCopyWith<$Res> {
  factory _$MonthCountModelCopyWith(_MonthCountModel value, $Res Function(_MonthCountModel) _then) = __$MonthCountModelCopyWithImpl;
@override @useResult
$Res call({
 String month, int count
});




}
/// @nodoc
class __$MonthCountModelCopyWithImpl<$Res>
    implements _$MonthCountModelCopyWith<$Res> {
  __$MonthCountModelCopyWithImpl(this._self, this._then);

  final _MonthCountModel _self;
  final $Res Function(_MonthCountModel) _then;

/// Create a copy of MonthCountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? count = null,}) {
  return _then(_MonthCountModel(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
