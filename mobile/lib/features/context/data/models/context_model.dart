import 'package:freezed_annotation/freezed_annotation.dart';

part 'context_model.freezed.dart';
part 'context_model.g.dart';

@freezed
abstract class ContextModel with _$ContextModel {
  const factory ContextModel({
    required int code,
    required String label,
    required String module,
  }) = _ContextModel;

  factory ContextModel.fromJson(Map<String, dynamic> json) =>
      _$ContextModelFromJson(json);
}

@freezed
abstract class ContextListResponse with _$ContextListResponse {
  const factory ContextListResponse({required List<ContextModel> contexts}) =
      _ContextListResponse;

  factory ContextListResponse.fromJson(Map<String, dynamic> json) =>
      _$ContextListResponseFromJson(json);
}
