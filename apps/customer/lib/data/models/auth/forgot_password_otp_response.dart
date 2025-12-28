import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_otp_response.freezed.dart';
part 'forgot_password_otp_response.g.dart';

@freezed
class ForgotPasswordOtpResponse with _$ForgotPasswordOtpResponse {
  const factory ForgotPasswordOtpResponse({
    required String sessionId,
  }) = _ForgotPasswordOtpResponse;

  factory ForgotPasswordOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordOtpResponseFromJson(json);
}
