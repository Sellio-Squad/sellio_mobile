import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/constants/auth_constants.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/auth_background_wrapper.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/sellio_otp_card.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_snack_bar.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import 'package:sellio_mobile/core/navigate/route_args.dart';
import 'package:sellio_mobile/di/injection_container.dart';

import 'cubits/otp_verification_cubit.dart';
import 'cubits/otp_verification_state.dart';

class ConfirmAccountScreen extends StatelessWidget {
  final SignupOtpArgs? args;

  const ConfirmAccountScreen({
    super.key,
    this.args,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerificationCubit(
        authRepository: sl(),
      ),
      child: _ConfirmAccountView(args: args),
    );
  }
}

class _ConfirmAccountView extends StatefulWidget {
  final SignupOtpArgs? args;

  const _ConfirmAccountView({this.args});

  @override
  State<_ConfirmAccountView> createState() => _ConfirmAccountViewState();
}

class _ConfirmAccountViewState extends State<_ConfirmAccountView> {
  final GlobalKey<OTPInputFieldState> _otpKey = GlobalKey<OTPInputFieldState>();
  String _otpValue = '';
  bool _isOtpComplete = false;
  int _resendCountdown = 0;
  Timer? _countdownTimer;
  String? _sessionId;
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _sessionId = widget.args?.sessionId;
    _phoneNumber = widget.args?.phoneNumber;
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
    if (_sessionId == null) return;

    _otpKey.currentState?.clear();
    setState(() {
      _otpValue = '';
      _isOtpComplete = false;
    });
    _startResendCountdown();

    context.read<OtpVerificationCubit>().resendOtp(sessionId: _sessionId!);
  }

  void _handleVerifyOtp() {
    if (_sessionId == null) {
      _showErrorSnackBar(context, 'Session has expired. Please try again.');
      return;
    }

    if (_otpValue.length != 4) return;

    context.read<OtpVerificationCubit>().verifyOtp(
          sessionId: _sessionId!,
          otp: _otpValue,
          localizations: context.local,
        );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
      listener: (context, state) {
        if (state is OtpVerificationSuccess) {
          _showSuccessSnackBar(context, context.local.login_successful);
          Future.delayed(AuthConstants.navigationDelay, () {
            if (context.mounted) {
              context.navigator.goToHome();
            }
          });
        } else if (state is OtpVerificationError) {
          _showErrorSnackBar(context, state.message);
        } else if (state is OtpResendSuccess) {
          _showSuccessSnackBar(context, 'OTP resent successfully');
        }
      },
      builder: (context, state) {
        final isLoading =
            state is OtpVerificationLoading || state is OtpResendLoading;

        return Scaffold(
          body: AuthBackgroundWrapper(
            showLogo: true,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.local.confirm_your_account,
                    style: textTheme.titleMedium.copyWith(color: colors.title),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _phoneNumber != null
                        ? context.local
                            .enter_the_4_digit_sent_to(_phoneNumber!)
                        : context.local.enter_the_4digit,
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
                  onPressed:
                      _isOtpComplete && !isLoading ? _handleVerifyOtp : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isOtpComplete && !isLoading
                        ? colors.primary
                        : colors.disabled,
                    disabledBackgroundColor: colors.disabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(colors.onPrimary),
                          ),
                        )
                      : Text(
                          context.local.confirm,
                          style: textTheme.labelMedium.copyWith(
                            color: _isOtpComplete && !isLoading
                                ? colors.onPrimary
                                : colors.hint,
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResendSection(dynamic colors, dynamic textTheme) {
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
            canResend
                ? context.local.re_send
                : context.local
                    .re_send_in_resend_countdown_Sec(_resendCountdown),
            style: textTheme.labelMedium.copyWith(
              color: canResend ? colors.primary : colors.body,
              decoration: canResend ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 26,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SellioSnackBar(
              isError: true,
              message: message,
              onCancelTap: () {
                overlayEntry.remove();
              },
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(AuthConstants.snackBarDisplayDuration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 26,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SellioSnackBar(
              isError: false,
              message: message,
              onCancelTap: () {
                overlayEntry.remove();
              },
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(AuthConstants.successSnackBarDisplayDuration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
