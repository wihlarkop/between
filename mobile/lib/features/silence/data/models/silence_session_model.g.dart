// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'silence_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SilenceSessionModel _$SilenceSessionModelFromJson(Map<String, dynamic> json) =>
    _SilenceSessionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      startedAt: json['started_at'] as String,
      endedAt: json['ended_at'] as String?,
      durationSeconds: (json['duration_seconds'] as num?)?.toInt(),
      contextCode: (json['context_code'] as num?)?.toInt(),
      contextLabel: json['context_label'] as String?,
      contextNote: json['context_note'] as String?,
      terminationReason: json['termination_reason'] as String?,
    );

Map<String, dynamic> _$SilenceSessionModelToJson(
  _SilenceSessionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'started_at': instance.startedAt,
  'ended_at': instance.endedAt,
  'duration_seconds': instance.durationSeconds,
  'context_code': instance.contextCode,
  'context_label': instance.contextLabel,
  'context_note': instance.contextNote,
  'termination_reason': instance.terminationReason,
};

_SessionListResponse _$SessionListResponseFromJson(Map<String, dynamic> json) =>
    _SessionListResponse(
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SilenceSessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SessionListResponseToJson(
  _SessionListResponse instance,
) => <String, dynamic>{
  'sessions': instance.sessions,
  'total': instance.total,
  'limit': instance.limit,
  'offset': instance.offset,
};

_AttachContextRequest _$AttachContextRequestFromJson(
  Map<String, dynamic> json,
) => _AttachContextRequest(
  contextCode: (json['context_code'] as num).toInt(),
  contextNote: json['context_note'] as String?,
);

Map<String, dynamic> _$AttachContextRequestToJson(
  _AttachContextRequest instance,
) => <String, dynamic>{
  'context_code': instance.contextCode,
  'context_note': instance.contextNote,
};

_AttachContextResponseModel _$AttachContextResponseModelFromJson(
  Map<String, dynamic> json,
) => _AttachContextResponseModel(
  contextCode: (json['context_code'] as num).toInt(),
  contextLabel: json['context_label'] as String,
  contextNote: json['context_note'] as String?,
);

Map<String, dynamic> _$AttachContextResponseModelToJson(
  _AttachContextResponseModel instance,
) => <String, dynamic>{
  'context_code': instance.contextCode,
  'context_label': instance.contextLabel,
  'context_note': instance.contextNote,
};
