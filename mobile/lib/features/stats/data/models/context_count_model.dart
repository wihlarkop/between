import 'package:freezed_annotation/freezed_annotation.dart';

part 'context_count_model.freezed.dart';
part 'context_count_model.g.dart';

@freezed
abstract class ContextCountModel with _$ContextCountModel {
  const factory ContextCountModel({
    required int code,
    required String label,
    required int count,
  }) = _ContextCountModel;

  factory ContextCountModel.fromJson(Map<String, dynamic> json) =>
      _$ContextCountModelFromJson(json);
}
