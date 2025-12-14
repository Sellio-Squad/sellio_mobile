import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_otp_response.freezed.dart';
part 'resend_otp_response.g.dart';

@freezed
class ResendOtpResponse with _$ResendOtpResponse {
  const factory ResendOtpResponse({
    required String sessionId,
  }) = _ResendOtpResponse;

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpResponseFromJson(json);
}