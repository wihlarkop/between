import 'package:freezed_annotation/freezed_annotation.dart';

part 'silence_session_model.freezed.dart';
part 'silence_session_model.g.dart';

@freezed
abstract class SilenceSessionModel with _$SilenceSessionModel {
  const factory SilenceSessionModel({
    required String id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'started_at') required String startedAt,
    @JsonKey(name: 'ended_at') String? endedAt,
    @JsonKey(name: 'duration_seconds') int? durationSeconds,
    @JsonKey(name: 'context_code') int? contextCode,
    @JsonKey(name: 'context_label') String? contextLabel,
    @JsonKey(name: 'context_note') String? contextNote,
    @JsonKey(name: 'termination_reason') String? terminationReason,
  }) = _SilenceSessionModel;

  factory SilenceSessionModel.fromJson(Map<String, dynamic> json) =>
      _$SilenceSessionModelFromJson(json);
}

@freezed
abstract class SessionListResponse with _$SessionListResponse {
  const factory SessionListResponse({
    required List<SilenceSessionModel> sessions,
    int? total,
    int? limit,
    int? offset,
  }) = _SessionListResponse;

  factory SessionListResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionListResponseFromJson(json);
}

@freezed
abstract class AttachContextRequest with _$AttachContextRequest {
  const factory AttachContextRequest({
    @JsonKey(name: 'context_code') required int contextCode,
    @JsonKey(name: 'context_note') String? contextNote,
  }) = _AttachContextRequest;

  factory AttachContextRequest.fromJson(Map<String, dynamic> json) =>
      _$AttachContextRequestFromJson(json);
}

@freezed
abstract class AttachContextResponseModel with _$AttachContextResponseModel {
  const factory AttachContextResponseModel({
    @JsonKey(name: 'context_code') required int contextCode,
    @JsonKey(name: 'context_label') required String contextLabel,
    @JsonKey(name: 'context_note') String? contextNote,
  }) = _AttachContextResponseModel;

  factory AttachContextResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AttachContextResponseModelFromJson(json);
}
