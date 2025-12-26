// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateProfileRequest(
  fullname: json['fullname'] as String?,
  timezone: json['timezone'] as String?,
  password: json['password'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  _UpdateProfileRequest instance,
) => <String, dynamic>{
  'fullname': ?instance.fullname,
  'timezone': ?instance.timezone,
  'password': ?instance.password,
};
