import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/otp_card.dart';
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
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 28 / 18,
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
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 24 / 16,
                  color: colors.body,
                  letterSpacing: 0,
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
          _buildResendSection(colors),

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
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 22 / 14,
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

  Widget _buildResendSection(dynamic colors) {
    final canResend = _resendCountdown == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t received code?',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 22 / 14,
            color: colors.body,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: canResend ? _handleResendCode : null,
          child: Text(
            canResend ? 'Re-Send' : 'Re-Send in $_resendCountdown Sec',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 22 / 14,
              color: canResend ? colors.primary : colors.body,
              decoration: canResend ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }
}