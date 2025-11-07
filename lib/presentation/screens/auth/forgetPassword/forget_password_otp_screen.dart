import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/app_management/route/routing.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/otp_card.dart';

import '../../../../core/design_system/themes/sellio_typography.dart';
import 'confirm_password_screen.dart';
import 'widget/lock_icon.dart';

class ForgetPasswordOTPScreen extends StatefulWidget {
  final ForgetPasswordOtpArgs args;

  const ForgetPasswordOTPScreen({
    super.key,
    required this.args,
  });

  @override
  State<ForgetPasswordOTPScreen> createState() =>
      _ForgetPasswordOTPScreenState();
}

class _ForgetPasswordOTPScreenState extends State<ForgetPasswordOTPScreen> {
  final GlobalKey<OTPInputFieldState> _otpKey = GlobalKey<OTPInputFieldState>();
  String _otpValue = '';
  bool _isOtpComplete = false;
  int _resendCountdown = 0;
  Timer? _countdownTimer;

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
    // await authService.resendOTP();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography.textTheme;

    return Scaffold(
      backgroundColor: colors.surfaceLow,
      appBar: AppBar(
        toolbarHeight: 68,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.surfaceLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.arrow_back, color: colors.title, size: 24),
              onPressed: () => context.navigator.pop(),
            ),
          ),
        ),
        title: Text(
          'Forget password',
          style: typography.titleMedium.copyWith(color: colors.title),
        ),
        centerTitle: false,
        titleSpacing: 8,
        backgroundColor: colors.surfaceLow,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Center(child: buildLockIcon(colors)),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 328,
                      child: Text(
                        'Enter code',
                        style: typography.titleMedium.copyWith(
                          color: colors.title,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 328,
                      child: Text(
                        'Please enter the 4-digit code sent to ${widget.args.phoneNumber}.',
                        style: typography.bodySmall.copyWith(
                          color: colors.body,
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
                    _buildResendSection(colors, typography),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 328,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isOtpComplete
                      ? () {
                          context.navigator.pushConfirmPassword(
                            ConfirmPasswordArgs(
                              phoneNumber: widget.args.phoneNumber,
                              otp: _otpValue,
                            ),
                          );
                        }
                      : null,
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
                      horizontal: 24,
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: typography.labelMedium.copyWith(
                      color: _isOtpComplete ? colors.onPrimary : colors.hint,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResendSection(dynamic colors, SellioTextTheme typography) {
    final canResend = _resendCountdown == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t received code?',
          style: typography.labelMedium.copyWith(color: colors.body),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: canResend ? _handleResendCode : null,
          child: Text(
            canResend ? 'Re-Send' : 'Re-Send in $_resendCountdown Sec',
            style: typography.labelMedium.copyWith(
              color: canResend ? colors.primary : colors.body,
              decoration: canResend ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }
}
