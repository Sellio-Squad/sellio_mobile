import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/otp_card.dart';
import 'dart:async';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Code resent successfully!'),
        backgroundColor: context.theme.colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
    _startResendCountdown();

    // TODO: Call API to resend OTP
    // await authService.resendOTP();
  }

  Future<void> _handleConfirm() async {
    if (!_isOtpComplete) return;

    // TODO: Call API to verify OTP
    // final result = await authService.verifyOTP(_otpValue);

    // Mock verification
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Scaffold(
      backgroundColor: colors.surfaceLow,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.title),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Forget password',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: colors.title,
          ),
        ),
        backgroundColor: colors.surfaceLow,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 40),
                  child: Column(
                    children: [
                      _buildLockIcon(colors),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 328,
                        child: Text(
                          'Enter code',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 28 / 18,
                            color: colors.title,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 328,
                        child: Text(
                          'Please enter the 4-digit code sent to your phone number.',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 22 / 14,
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
                      _buildResendSection(colors),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 328,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isOtpComplete ? _handleConfirm : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isOtpComplete ? colors.primary : colors.disabled,
                    disabledBackgroundColor: colors.disabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 22 / 14,
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

  Widget _buildLockIcon(dynamic colors) {
    return SizedBox(
      width: 88,
      height: 88,
      child: SvgPicture.asset(
        'assets/svg/ic_circle_lock_remove.svg',
        width: 88,
        height: 88,
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