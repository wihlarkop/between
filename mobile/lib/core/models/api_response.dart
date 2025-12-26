import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required T data,
    required bool success,
    @JsonKey(name: 'status_code') required int statusCode,
    required String timestamp,
    String? message,
    Map<String, dynamic>? meta,
    @JsonKey(name: 'error_code') String? errorCode,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
