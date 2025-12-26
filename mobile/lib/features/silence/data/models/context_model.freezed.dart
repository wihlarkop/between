// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'context_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContextModel {

 int get code; String get label; String get module;
/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContextModelCopyWith<ContextModel> get copyWith => _$ContextModelCopyWithImpl<ContextModel>(this as ContextModel, _$identity);

  /// Serializes this ContextModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContextModel&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.module, module) || other.module == module));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,module);

@override
String toString() {
  return 'ContextModel(code: $code, label: $label, module: $module)';
}


}

/// @nodoc
abstract mixin class $ContextModelCopyWith<$Res>  {
  factory $ContextModelCopyWith(ContextModel value, $Res Function(ContextModel) _then) = _$ContextModelCopyWithImpl;
@useResult
$Res call({
 int code, String label, String module
});




}
/// @nodoc
class _$ContextModelCopyWithImpl<$Res>
    implements $ContextModelCopyWith<$Res> {
  _$ContextModelCopyWithImpl(this._self, this._then);

  final ContextModel _self;
  final $Res Function(ContextModel) _then;

/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? label = null,Object? module = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,module: null == module ? _self.module : module // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContextModel].
extension ContextModelPatterns on ContextModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContextModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContextModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContextModel value)  $default,){
final _that = this;
switch (_that) {
case _ContextModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContextModel value)?  $default,){
final _that = this;
switch (_that) {
case _ContextModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String label,  String module)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContextModel() when $default != null:
return $default(_that.code,_that.label,_that.module);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String label,  String module)  $default,) {final _that = this;
switch (_that) {
case _ContextModel():
return $default(_that.code,_that.label,_that.module);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String label,  String module)?  $default,) {final _that = this;
switch (_that) {
case _ContextModel() when $default != null:
return $default(_that.code,_that.label,_that.module);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContextModel implements ContextModel {
  const _ContextModel({required this.code, required this.label, required this.module});
  factory _ContextModel.fromJson(Map<String, dynamic> json) => _$ContextModelFromJson(json);

@override final  int code;
@override final  String label;
@override final  String module;

/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContextModelCopyWith<_ContextModel> get copyWith => __$ContextModelCopyWithImpl<_ContextModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContextModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContextModel&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.module, module) || other.module == module));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,module);

@override
String toString() {
  return 'ContextModel(code: $code, label: $label, module: $module)';
}


}

/// @nodoc
abstract mixin class _$ContextModelCopyWith<$Res> implements $ContextModelCopyWith<$Res> {
  factory _$ContextModelCopyWith(_ContextModel value, $Res Function(_ContextModel) _then) = __$ContextModelCopyWithImpl;
@override @useResult
$Res call({
 int code, String label, String module
});




}
/// @nodoc
class __$ContextModelCopyWithImpl<$Res>
    implements _$ContextModelCopyWith<$Res> {
  __$ContextModelCopyWithImpl(this._self, this._then);

  final _ContextModel _self;
  final $Res Function(_ContextModel) _then;

/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? label = null,Object? module = null,}) {
  return _then(_ContextModel(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,module: null == module ? _self.module : module // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ContextListResponse {

 List<ContextModel> get contexts;
/// Create a copy of ContextListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContextListResponseCopyWith<ContextListResponse> get copyWith => _$ContextListResponseCopyWithImpl<ContextListResponse>(this as ContextListResponse, _$identity);

  /// Serializes this ContextListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContextListResponse&&const DeepCollectionEquality().equals(other.contexts, contexts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(contexts));

@override
String toString() {
  return 'ContextListResponse(contexts: $contexts)';
}


}

/// @nodoc
abstract mixin class $ContextListResponseCopyWith<$Res>  {
  factory $ContextListResponseCopyWith(ContextListResponse value, $Res Function(ContextListResponse) _then) = _$ContextListResponseCopyWithImpl;
@useResult
$Res call({
 List<ContextModel> contexts
});




}
/// @nodoc
class _$ContextListResponseCopyWithImpl<$Res>
    implements $ContextListResponseCopyWith<$Res> {
  _$ContextListResponseCopyWithImpl(this._self, this._then);

  final ContextListResponse _self;
  final $Res Function(ContextListResponse) _then;

/// Create a copy of ContextListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contexts = null,}) {
  return _then(_self.copyWith(
contexts: null == contexts ? _self.contexts : contexts // ignore: cast_nullable_to_non_nullable
as List<ContextModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ContextListResponse].
extension ContextListResponsePatterns on ContextListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContextListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContextListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContextListResponse value)  $default,){
final _that = this;
switch (_that) {
case _ContextListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContextListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ContextListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ContextModel> contexts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContextListResponse() when $default != null:
return $default(_that.contexts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ContextModel> contexts)  $default,) {final _that = this;
switch (_that) {
case _ContextListResponse():
return $default(_that.contexts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ContextModel> contexts)?  $default,) {final _that = this;
switch (_that) {
case _ContextListResponse() when $default != null:
return $default(_that.contexts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContextListResponse implements ContextListResponse {
  const _ContextListResponse({required final  List<ContextModel> contexts}): _contexts = contexts;
  factory _ContextListResponse.fromJson(Map<String, dynamic> json) => _$ContextListResponseFromJson(json);

 final  List<ContextModel> _contexts;
@override List<ContextModel> get contexts {
  if (_contexts is EqualUnmodifiableListView) return _contexts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contexts);
}


/// Create a copy of ContextListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContextListResponseCopyWith<_ContextListResponse> get copyWith => __$ContextListResponseCopyWithImpl<_ContextListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContextListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContextListResponse&&const DeepCollectionEquality().equals(other._contexts, _contexts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_contexts));

@override
String toString() {
  return 'ContextListResponse(contexts: $contexts)';
}


}

/// @nodoc
abstract mixin class _$ContextListResponseCopyWith<$Res> implements $ContextListResponseCopyWith<$Res> {
  factory _$ContextListResponseCopyWith(_ContextListResponse value, $Res Function(_ContextListResponse) _then) = __$ContextListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ContextModel> contexts
});




}
/// @nodoc
class __$ContextListResponseCopyWithImpl<$Res>
    implements _$ContextListResponseCopyWith<$Res> {
  __$ContextListResponseCopyWithImpl(this._self, this._then);

  final _ContextListResponse _self;
  final $Res Function(_ContextListResponse) _then;

/// Create a copy of ContextListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contexts = null,}) {
  return _then(_ContextListResponse(
contexts: null == contexts ? _self._contexts : contexts // ignore: cast_nullable_to_non_nullable
as List<ContextModel>,
  ));
}


}

// dart format on
