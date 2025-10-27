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

  Future<void> _handleConfirm() async {
    if (!_isOtpComplete || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Call API to verify OTP and create account
      // POST /auth/verify-otp
      // Payload: { phone_number: user.phoneNumber, otp: _otpValue }
      // Response: { success: true, token: 'jwt_token', user: {...} }

      // Mock verification
      await Future.delayed(const Duration(seconds: 1));

      // TODO: On success:
      // 1. Save auth token
      // 2. Save user data
      // 3. Navigate to main app home screen
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => const HomeScreen()),
      // );

      print('OTP Verified: $_otpValue');
      print('Account created successfully');
    } catch (error) {
      // TODO: Show error message to user
      print('OTP verification failed: $error');

      // Show error dialog or snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid code. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return AuthBackgroundWrapper(
      showLogo: true,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
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
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
            child: SizedBox(
              width: 328,
              height: 30,
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

          const SizedBox(height: 288),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 328,
              height: 48,
              child: ElevatedButton(
                onPressed: (_isOtpComplete && !_isLoading) ? _handleConfirm : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: (_isOtpComplete && !_isLoading)
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
                child: _isLoading
                    ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colors.onPrimary,
                    ),
                  ),
                )
                    : Text(
                  'Confirm',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 22 / 14,
                    color: (_isOtpComplete && !_isLoading)
                        ? colors.onPrimary
                        : colors.hint,
                  ),
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