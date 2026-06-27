import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_reset_request.freezed.dart';
part 'forgot_password_reset_request.g.dart';

@freezed
class ForgotPasswordResetRequest with _$ForgotPasswordResetRequest {
  const factory ForgotPasswordResetRequest({
    required String sessionId,
    required String newPassword,
    required String confirmPassword,
  }) = _ForgotPasswordResetRequest;

  factory ForgotPasswordResetRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResetRequestFromJson(json);
}
