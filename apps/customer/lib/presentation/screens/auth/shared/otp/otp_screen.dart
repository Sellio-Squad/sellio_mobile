import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/di/injection_container.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart'
    show AuthRepository;

import '../../../../../core/utils/snackbar_helper.dart';
import '../constants/auth_constants.dart';
import 'cubit/otp_cubit.dart';
import 'cubit/otp_state.dart';
import 'widgets/otp_resend_section.dart';

class OtpScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? phoneNumber;
  final VoidCallback onVerifySuccess;
  final Future<Result<void>> Function(String otp) onVerify;
  final int otpLength;

  const OtpScreen({
    super.key,
    required this.title,
    required this.subtitle,
    this.phoneNumber,
    required this.onVerifySuccess,
    required this.onVerify,
    this.otpLength = AuthConstants.otpLength,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(
        onVerify: onVerify,
        otpLength: otpLength,
        authRepository: sl<AuthRepository>(),
      ),
      child: _OtpScreenContent(
        title: title,
        subtitle: subtitle,
        phoneNumber: phoneNumber,
        onVerifySuccess: onVerifySuccess,
        otpLength: otpLength,
      ),
    );
  }
}

class _OtpScreenContent extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? phoneNumber;
  final VoidCallback onVerifySuccess;
  final int otpLength;

  const _OtpScreenContent({
    required this.title,
    required this.subtitle,
    this.phoneNumber,
    required this.onVerifySuccess,
    required this.otpLength,
  });

  @override
  State<_OtpScreenContent> createState() => _OtpScreenContentState();
}

class _OtpScreenContentState extends State<_OtpScreenContent> {
  final GlobalKey<OTPInputFieldState> _otpKey = GlobalKey<OTPInputFieldState>();

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          widget.onVerifySuccess();
        } else if (state is OtpFailure) {
          SnackBarHelper.showError(
            context,
            state.errorMessage ?? context.local.otp_verification_failed,
          );
        } else if (state is OtpResent) {
          _otpKey.currentState?.clear();
          SnackBarHelper.showSuccess(
            context,
            state.message ?? context.local.otp_resent_successfully,
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AuthBackgroundWrapper(
          containerPadding: const EdgeInsets.symmetric(vertical: 16),
          showLogo: true,
          child: Scaffold(
            backgroundColor: colors.surfaceLow,
            appBar: SellioAppBar(
              title: widget.title,
              showBackButton: true,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(textTheme, colors),
                            const SizedBox(height: 32),
                            _buildOtpInput(),
                            const SizedBox(height: 24),
                            _buildResendSection(),
                          ],
                        ),
                      ),
                    ),
                    _buildConfirmButton(colors, textTheme),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(SellioTextTheme textTheme, dynamic colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.phoneNumber != null
              ? context.local.enter_the_4_digit_sent_to(widget.phoneNumber!)
              : widget.subtitle,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        return OTPInputField(
          key: _otpKey,
          length: widget.otpLength,
          onChanged: (value) {
            context.read<OtpCubit>().updateOtp(value);
          },
          onCompleted: (otp) {
            context.read<OtpCubit>().updateOtp(otp);
          },
        );
      },
    );
  }

  Widget _buildResendSection() {
    return BlocBuilder<OtpCubit, OtpState>(
      buildWhen: (previous, current) => current is OtpIdle,
      builder: (context, state) {
        final idle = state is OtpIdle ? state : const OtpIdle();

        return OtpResendSection(
          resendCountdown: idle.countdown,
          canResend: idle.canResend,
          onResend: () => context.read<OtpCubit>().resendOtp(),
        );
      },
    );
  }

  Widget _buildConfirmButton(dynamic colors, SellioTextTheme textTheme) {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        final isLoading = state is OtpVerifying;
        final isEnabled = state is OtpIdle && state.isComplete && !isLoading;

        return SellioButton(
          text: context.local.confirm,
          onTap: isEnabled ? () => context.read<OtpCubit>().verifyOtp() : null,
          isLoading: isLoading,
          backgroundColor: isEnabled ? colors.primary : colors.disabled,
          textColor: isEnabled ? colors.onPrimary : colors.hint,
        );
      },
    );
  }
}
