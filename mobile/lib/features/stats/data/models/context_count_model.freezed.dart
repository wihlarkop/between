// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'context_count_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContextCountModel {

 int get code; String get label; int get count;
/// Create a copy of ContextCountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContextCountModelCopyWith<ContextCountModel> get copyWith => _$ContextCountModelCopyWithImpl<ContextCountModel>(this as ContextCountModel, _$identity);

  /// Serializes this ContextCountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContextCountModel&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,count);

@override
String toString() {
  return 'ContextCountModel(code: $code, label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class $ContextCountModelCopyWith<$Res>  {
  factory $ContextCountModelCopyWith(ContextCountModel value, $Res Function(ContextCountModel) _then) = _$ContextCountModelCopyWithImpl;
@useResult
$Res call({
 int code, String label, int count
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
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? label = null,Object? count = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String label,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContextCountModel() when $default != null:
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
case _ContextCountModel():
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
case _ContextCountModel() when $default != null:
return $default(_that.code,_that.label,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContextCountModel implements ContextCountModel {
  const _ContextCountModel({required this.code, required this.label, required this.count});
  factory _ContextCountModel.fromJson(Map<String, dynamic> json) => _$ContextCountModelFromJson(json);

@override final  int code;
@override final  String label;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContextCountModel&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,label,count);

@override
String toString() {
  return 'ContextCountModel(code: $code, label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ContextCountModelCopyWith<$Res> implements $ContextCountModelCopyWith<$Res> {
  factory _$ContextCountModelCopyWith(_ContextCountModel value, $Res Function(_ContextCountModel) _then) = __$ContextCountModelCopyWithImpl;
@override @useResult
$Res call({
 int code, String label, int count
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
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? label = null,Object? count = null,}) {
  return _then(_ContextCountModel(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
