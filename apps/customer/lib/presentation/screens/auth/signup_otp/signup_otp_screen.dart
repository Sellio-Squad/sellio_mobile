import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import '../shared/mixins/otp_countdown_mixin.dart';
import '../shared/widgets/otp_resend_section.dart';

class ConfirmAccountScreen extends StatefulWidget {
  final String phoneNumber;

  const ConfirmAccountScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<ConfirmAccountScreen> createState() => _ConfirmAccountScreenState();
}

class _ConfirmAccountScreenState extends State<ConfirmAccountScreen>
    with OtpCountdownMixin {
  final GlobalKey<OTPInputFieldState> _otpKey = GlobalKey<OTPInputFieldState>();
  String _otpValue = '';
  bool _isOtpComplete = false;

  @override
  void initState() {
    super.initState();
    startResendCountdown();
  }

  void _handleOTPChanged(String value) {
    setState(() {
      _otpValue = value;
      _isOtpComplete = value.length == 4;
    });
  }

  void _handleOTPComplete(String otp) {
    setState(() {
      _otpValue = otp;
      _isOtpComplete = true;
    });
  }

  void _handleResendCode() {
    _otpKey.currentState?.clear();
    setState(() {
      _otpValue = '';
      _isOtpComplete = false;
    });
    startResendCountdown();
    // TODO: Call API to resend OTP
  }

  void _handleConfirm() {
    if (!_isOtpComplete) return;
    context.navigator.goToHome();
  }

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
              _buildHeader(textTheme, colors),
              const SizedBox(height: 32),
              OTPInputField(
                key: _otpKey,
                length: 4,
                onChanged: _handleOTPChanged,
                onCompleted: _handleOTPComplete,
              ),
              const SizedBox(height: 24),
              OtpResendSection(
                resendCountdown: resendCountdown,
                canResend: canResend,
                onResend: _handleResendCode,
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(colors, textTheme),
    );
  }

  Widget _buildHeader(SellioTextTheme textTheme, dynamic colors) {
    return Column(
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
      ],
    );
  }

  Widget _buildBottomButton(dynamic colors, SellioTextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(color: colors.surfaceLow),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
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
            ),
            child: Text(
              context.local.confirm,
              style: textTheme.labelMedium.copyWith(
                color: _isOtpComplete ? colors.onPrimary : colors.hint,
              ),
            ),
          ),
        ),
      ),
    );
  }
}