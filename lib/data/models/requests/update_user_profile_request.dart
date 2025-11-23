import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_profile_request.freezed.dart';
part 'update_user_profile_request.g.dart';

@freezed
class UpdateUserProfileRequest with _$UpdateUserProfileRequest {
  const factory UpdateUserProfileRequest({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? city,
    String? country,
    String? avatarUrl,
  }) = _UpdateUserProfileRequest;

  factory UpdateUserProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileRequestFromJson(json);
}
