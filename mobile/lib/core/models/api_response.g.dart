// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _ApiResponse<T>(
  data: fromJsonT(json['data']),
  success: json['success'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  timestamp: json['timestamp'] as String,
  message: json['message'] as String?,
  meta: json['meta'] as Map<String, dynamic>?,
  errorCode: json['error_code'] as String?,
);

Map<String, dynamic> _$ApiResponseToJson<T>(
  _ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': toJsonT(instance.data),
  'success': instance.success,
  'status_code': instance.statusCode,
  'timestamp': instance.timestamp,
  'message': instance.message,
  'meta': instance.meta,
  'error_code': instance.errorCode,
};
