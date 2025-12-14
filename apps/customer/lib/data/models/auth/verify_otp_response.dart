import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_response.freezed.dart';
part 'verify_otp_response.g.dart';

@freezed
class VerifyOtpResponse with _$VerifyOtpResponse {
  const factory VerifyOtpResponse({
    required String accessToken,
    required String refreshToken,
  }) = _VerifyOtpResponse;

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);
}