// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContextCountModel _$ContextCountModelFromJson(Map<String, dynamic> json) =>
    _ContextCountModel(
      code: (json['code'] as num).toInt(),
      label: json['label'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$ContextCountModelToJson(_ContextCountModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'count': instance.count,
    };
