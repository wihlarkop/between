import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_request.freezed.dart';
part 'profile_request.g.dart';

@freezed
abstract class UpdateProfileRequest with _$UpdateProfileRequest {
  const UpdateProfileRequest._();

  const factory UpdateProfileRequest({
    @JsonKey(includeIfNull: false) String? fullname,
    @JsonKey(includeIfNull: false) String? timezone,
    @JsonKey(includeIfNull: false) String? password,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}
