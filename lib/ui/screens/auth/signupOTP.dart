import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/otp_card.dart';
import '../../../core/design_system/themes/sellio_typography.dart';
import '../../../core/design_system/widgets/AuthBackgroundWrapper.dart';


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
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return AuthBackgroundWrapper(
      showLogo: true,
      child: Column(
        children: [
          SizedBox(
            width: 328,
            height: 48,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Confirm your account',
                style: textTheme.titleMedium.copyWith(
                  color: colors.title,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: SizedBox(
              width: 328,
              height: 50,
              child: Text(
                'Please enter the 4-digit code sent to your phone number.',
                style: textTheme.bodyMedium.copyWith(
                  color: colors.body,
                ),
              ),
            ),
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
            onCompleted: (value) {
              _handleOTPComplete(value);
            },
          ),

          const SizedBox(height: 24),
          _buildResendSection(colors, textTheme),

          const SizedBox(height: 345),
          SizedBox(
            width: 350,
            height: 48,
            child: ElevatedButton(
              onPressed: _isOtpComplete ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOtpComplete
                    ? colors.primary
                    : colors.disabled,
                disabledBackgroundColor: colors.disabled,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
              ),
              child: Text(
                'Confirm',
                style: textTheme.labelMedium.copyWith(
                  color: _isOtpComplete
                      ? colors.onPrimary
                      : colors.hint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResendSection(dynamic colors, SellioTextTheme textTheme) {
    final canResend = _resendCountdown == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t received code?',
          style: textTheme.labelMedium.copyWith(
            color: colors.body,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: canResend ? _handleResendCode : null,
          child: Text(
            canResend ? 'Re-Send' : 'Re-Send in $_resendCountdown Sec',
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