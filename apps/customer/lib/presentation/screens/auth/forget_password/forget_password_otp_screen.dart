import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import '../shared/mixins/otp_countdown_mixin.dart';
import '../shared/widgets/otp_resend_section.dart';
import 'widgets/lock_icon.dart';

class ForgetPasswordOTPScreen extends StatefulWidget {
  final ForgetPasswordOtpArgs args;

  const ForgetPasswordOTPScreen({
    super.key,
    required this.args,
  });

  @override
  State<ForgetPasswordOTPScreen> createState() => _ForgetPasswordOTPScreenState();
}

class _ForgetPasswordOTPScreenState extends State<ForgetPasswordOTPScreen>
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

    context.navigator.pushConfirmPassword(
      ConfirmPasswordArgs(
        phoneNumber: widget.args.phoneNumber,
        otp: _otpValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Scaffold(
      backgroundColor: colors.surfaceLow,
      appBar: _buildAppBar(colors, textTheme),
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
                  ],
                ),
              ),
            ),
            _buildConfirmButton(colors, textTheme),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(dynamic colors, SellioTextTheme textTheme) {
    return AppBar(
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
        context.local.forget_password,
        style: textTheme.titleMedium.copyWith(color: colors.title),
      ),
      centerTitle: false,
      titleSpacing: 8,
      backgroundColor: colors.surfaceLow,
      elevation: 0,
    );
  }

  Widget _buildHeader(SellioTextTheme textTheme, dynamic colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 328,
            child: Text(
              context.local.enter_code,
              style: textTheme.titleMedium.copyWith(color: colors.title),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 328,
            child: Text(
              context.local.enter_the_4_digit_sent_to(widget.args.phoneNumber),
              style: textTheme.bodySmall.copyWith(color: colors.body),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(dynamic colors, SellioTextTheme textTheme) {
    return Padding(
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
            context.local.confirm,
            style: textTheme.labelMedium.copyWith(
              color: _isOtpComplete ? colors.onPrimary : colors.hint,
            ),
          ),
        ),
      ),
    );
  }
}