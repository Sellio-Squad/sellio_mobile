import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../core/design_system/widgets/cards/sellio_otp_card.dart';
import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../core/navigate/routing.dart';

import '../../../../domain/repositories/auth_repository.dart';
import '../../../../core/error/result.dart';
import '../../../../core/design_system/themes/sellio_typography.dart';
import 'widget/lock_icon.dart';

class ForgetPasswordOTPScreen extends StatefulWidget {
  final ForgetPasswordOtpArgs args;

  const ForgetPasswordOTPScreen({super.key, required this.args});

  @override
  State<ForgetPasswordOTPScreen> createState() => _ForgetPasswordOTPScreenState();
}

class _ForgetPasswordOTPScreenState extends State<ForgetPasswordOTPScreen> {
  final GlobalKey<OTPInputFieldState> otpKey = GlobalKey();
  String otp = "";
  bool isComplete = false;

  int countdown = 55;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  //---------------- TIMER ----------------//
  void startTimer() {
    countdown = 55;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => countdown > 0 ? countdown-- : t.cancel());
    });
  }

  //---------------- VERIFY OTP ----------------//
  Future<void> verifyOtp() async {
    final repo = context.read<AuthRepository>();

    final result = await repo.verifyOtp(
      phoneNumber: widget.args.phoneNumber,
      countryCode: widget.args.countryCode,
      otpCode: otp,
    );

    if (result is Success<bool>) {
      context.navigator.pushConfirmPassword(
        ConfirmPasswordArgs(
          phoneNumber: widget.args.phoneNumber,
          countryCode: widget.args.countryCode,
          otp: otp,
        ),
      );
    } else if (result is ResultFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.failure.message)),
      );
    }
  }

  //---------------- RESEND OTP ----------------//
  Future<void> resendOtp() async {
    otpKey.currentState?.clear();
    otp = "";
    isComplete = false;
    startTimer();

    final repo = context.read<AuthRepository>();
    await repo.resendOtp(
      phoneNumber: widget.args.phoneNumber,
      countryCode: widget.args.countryCode,
    );
  }

  //------------------------------------------------------------------ UI  ------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final text = context.theme.typography.textTheme;

    return Scaffold(
      backgroundColor: colors.surfaceLow,
      appBar: AppBar(
        backgroundColor: colors.surfaceLow,
        elevation: 0,
        leading: BackButton(color: colors.title),
        title: Text(context.local.forget_password,
            style: text.titleMedium.copyWith(color: colors.title)),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(child: buildLockIcon(colors)),
            const SizedBox(height: 40),

            Text(context.local.enter_code,
                style: text.titleMedium.copyWith(color: colors.title)),
            const SizedBox(height: 8),

            Text(context.local.enter_the_4_digit_sent_to(widget.args.phoneNumber),
                style: text.bodySmall.copyWith(color: colors.body)),

            const SizedBox(height: 32),
            OTPInputField(
              key: otpKey,
              length: 4,
              onChanged: (value) => setState(() {
                otp = value;
                isComplete = value.length == 4;
              }),
            ),

            const SizedBox(height: 24),
            _buildResend(colors, text),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 328,
                child: ElevatedButton(
                  onPressed: isComplete ? verifyOtp : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isComplete ? colors.primary : colors.disabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    context.local.confirm,
                    style: text.labelMedium.copyWith(
                        color: isComplete ? colors.onPrimary : colors.hint),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResend(dynamic colors, SellioTextTheme text) {
    final ready = countdown == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.local.dont_received_code,
            style: text.labelMedium.copyWith(color: colors.body)),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: ready ? resendOtp : null,
          child: Text(
            ready
                ? context.local.re_send
                : context.local.re_send_in_resend_countdown_Sec(countdown),
            style: text.labelMedium.copyWith(
              color: ready ? colors.primary : colors.body,
              decoration: ready ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }
}
