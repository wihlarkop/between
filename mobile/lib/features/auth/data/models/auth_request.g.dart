// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'email': instance.email,
      'password': instance.password,
      'timezone': instance.timezone,
    };

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_RefreshTokenRequest _$RefreshTokenRequestFromJson(Map<String, dynamic> json) =>
    _RefreshTokenRequest(refreshToken: json['refresh_token'] as String);

Map<String, dynamic> _$RefreshTokenRequestToJson(
  _RefreshTokenRequest instance,
) => <String, dynamic>{'refresh_token': instance.refreshToken};
