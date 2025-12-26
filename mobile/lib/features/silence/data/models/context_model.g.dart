// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContextModel _$ContextModelFromJson(Map<String, dynamic> json) =>
    _ContextModel(
      code: (json['code'] as num).toInt(),
      label: json['label'] as String,
      module: json['module'] as String,
    );

Map<String, dynamic> _$ContextModelToJson(_ContextModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'module': instance.module,
    };

_ContextListResponse _$ContextListResponseFromJson(Map<String, dynamic> json) =>
    _ContextListResponse(
      contexts: (json['contexts'] as List<dynamic>)
          .map((e) => ContextModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContextListResponseToJson(
  _ContextListResponse instance,
) => <String, dynamic>{'contexts': instance.contexts};
