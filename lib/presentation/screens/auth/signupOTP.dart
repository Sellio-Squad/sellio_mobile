import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/otp_card.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';
import '../../../core/design_system/themes/sellio_typography.dart';
import '../../../core/design_system/widgets/auth_background_wrapper.dart';


class ConfirmAccountScreen extends StatefulWidget {
  const ConfirmAccountScreen({super.key});

  @override
  State<ConfirmAccountScreen> createState() => _ConfirmAccountScreenState();
}

class _ConfirmAccountScreenState extends State<ConfirmAccountScreen> {
  final GlobalKey<OTPInputFieldState> _otpKey = GlobalKey<OTPInputFieldState>();
  String _otpValue = '';
  bool _isOtpComplete = false;
  int _resendCountdown = 0;
  Timer? _countdownTimer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _handleOTPComplete(String otp) {
    setState(() {
      _otpValue = otp;
      _isOtpComplete = true;
    });
  }

  void _startResendCountdown() {
    setState(() {
      _resendCountdown = 55;
    });

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _handleResendCode() {
    // Clear OTP fields
    _otpKey.currentState?.clear();
    setState(() {
      _otpValue = '';
      _isOtpComplete = false;
    });
    _startResendCountdown();

    // TODO: Call API to resend OTP
    // POST /auth/resend-otp
    // Payload: { phone_number: user.phoneNumber }
    // await authService.resendOTP();
    print('Resend OTP requested');
  }

  @override
  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Scaffold(
      body: AuthBackgroundWrapper(
        showLogo: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.local.confirm_your_account,
                style: textTheme.titleMedium.copyWith(color: colors.title),
              ),
              const SizedBox(height: 4),
              Text(
                context.local.enter_the_4digit,
                style: textTheme.bodyMedium.copyWith(color: colors.body),
              ),
              const SizedBox(height: 32),

              OTPInputField(
                key: _otpKey,
                length: 4,
                onChanged: (value) {
                  setState(() {
                    _otpValue = value;
                    _isOtpComplete = value.length == 4;
                  });
                },
                onCompleted: _handleOTPComplete,
              ),

              const SizedBox(height: 24),
              _buildResendSection(colors, textTheme),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.theme.colors.surfaceLow,
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isOtpComplete ? () { context.navigator.goToHome();} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                _isOtpComplete ? colors.primary : colors.disabled,
                disabledBackgroundColor: colors.disabled,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                context.local.confirm,
                style: textTheme.labelMedium.copyWith(
                  color: _isOtpComplete
                      ? colors.onPrimary
                      : colors.hint,
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }

  Widget _buildResendSection(dynamic colors, SellioTextTheme textTheme) {
    final canResend = _resendCountdown == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.local.dont_received_code,
          style: textTheme.labelMedium.copyWith(
            color: colors.body,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: canResend ? _handleResendCode : null,
          child: Text(
            canResend ? context.local.re_send : context.local.re_send_in_resend_countdown_Sec(_resendCountdown),
            style: textTheme.labelMedium.copyWith(
              color: canResend ? colors.primary : colors.body,
              decoration: canResend ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }
}