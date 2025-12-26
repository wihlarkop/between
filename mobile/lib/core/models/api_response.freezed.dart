// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiResponse<T> {

 T get data; bool get success;@JsonKey(name: 'status_code') int get statusCode; String get timestamp; String? get message; Map<String, dynamic>? get meta;@JsonKey(name: 'error_code') String? get errorCode;
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<T, ApiResponse<T>> get copyWith => _$ApiResponseCopyWithImpl<T, ApiResponse<T>>(this as ApiResponse<T>, _$identity);

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponse<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.meta, meta)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),success,statusCode,timestamp,message,const DeepCollectionEquality().hash(meta),errorCode);

@override
String toString() {
  return 'ApiResponse<$T>(data: $data, success: $success, statusCode: $statusCode, timestamp: $timestamp, message: $message, meta: $meta, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<T,$Res>  {
  factory $ApiResponseCopyWith(ApiResponse<T> value, $Res Function(ApiResponse<T>) _then) = _$ApiResponseCopyWithImpl;
@useResult
$Res call({
 T data, bool success,@JsonKey(name: 'status_code') int statusCode, String timestamp, String? message, Map<String, dynamic>? meta,@JsonKey(name: 'error_code') String? errorCode
});




}
/// @nodoc
class _$ApiResponseCopyWithImpl<T,$Res>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse<T> _self;
  final $Res Function(ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? success = null,Object? statusCode = null,Object? timestamp = null,Object? message = freezed,Object? meta = freezed,Object? errorCode = freezed,}) {
  return _then(_self.copyWith(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiResponse].
extension ApiResponsePatterns<T> on ApiResponse<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _ApiResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T data,  bool success, @JsonKey(name: 'status_code')  int statusCode,  String timestamp,  String? message,  Map<String, dynamic>? meta, @JsonKey(name: 'error_code')  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.data,_that.success,_that.statusCode,_that.timestamp,_that.message,_that.meta,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T data,  bool success, @JsonKey(name: 'status_code')  int statusCode,  String timestamp,  String? message,  Map<String, dynamic>? meta, @JsonKey(name: 'error_code')  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _ApiResponse():
return $default(_that.data,_that.success,_that.statusCode,_that.timestamp,_that.message,_that.meta,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T data,  bool success, @JsonKey(name: 'status_code')  int statusCode,  String timestamp,  String? message,  Map<String, dynamic>? meta, @JsonKey(name: 'error_code')  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.data,_that.success,_that.statusCode,_that.timestamp,_that.message,_that.meta,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _ApiResponse<T> implements ApiResponse<T> {
  const _ApiResponse({required this.data, required this.success, @JsonKey(name: 'status_code') required this.statusCode, required this.timestamp, this.message, final  Map<String, dynamic>? meta, @JsonKey(name: 'error_code') this.errorCode}): _meta = meta;
  factory _ApiResponse.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ApiResponseFromJson(json,fromJsonT);

@override final  T data;
@override final  bool success;
@override@JsonKey(name: 'status_code') final  int statusCode;
@override final  String timestamp;
@override final  String? message;
 final  Map<String, dynamic>? _meta;
@override Map<String, dynamic>? get meta {
  final value = _meta;
  if (value == null) return null;
  if (_meta is EqualUnmodifiableMapView) return _meta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'error_code') final  String? errorCode;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponseCopyWith<T, _ApiResponse<T>> get copyWith => __$ApiResponseCopyWithImpl<T, _ApiResponse<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ApiResponseToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponse<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._meta, _meta)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),success,statusCode,timestamp,message,const DeepCollectionEquality().hash(_meta),errorCode);

@override
String toString() {
  return 'ApiResponse<$T>(data: $data, success: $success, statusCode: $statusCode, timestamp: $timestamp, message: $message, meta: $meta, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<T,$Res> implements $ApiResponseCopyWith<T, $Res> {
  factory _$ApiResponseCopyWith(_ApiResponse<T> value, $Res Function(_ApiResponse<T>) _then) = __$ApiResponseCopyWithImpl;
@override @useResult
$Res call({
 T data, bool success,@JsonKey(name: 'status_code') int statusCode, String timestamp, String? message, Map<String, dynamic>? meta,@JsonKey(name: 'error_code') String? errorCode
});




}
/// @nodoc
class __$ApiResponseCopyWithImpl<T,$Res>
    implements _$ApiResponseCopyWith<T, $Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse<T> _self;
  final $Res Function(_ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? success = null,Object? statusCode = null,Object? timestamp = null,Object? message = freezed,Object? meta = freezed,Object? errorCode = freezed,}) {
  return _then(_ApiResponse<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,meta: freezed == meta ? _self._meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
