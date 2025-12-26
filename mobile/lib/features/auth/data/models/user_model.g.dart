// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  fullname: json['fullname'] as String,
  email: json['email'] as String,
  timezone: json['timezone'] as String,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'timezone': instance.timezone,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
