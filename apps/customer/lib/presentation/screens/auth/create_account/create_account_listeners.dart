import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../shared/otp/otp_screen.dart';
import 'cubit/registration_cubit.dart';
import 'cubit/registration_state.dart';

class CreateAccountListeners extends StatelessWidget {
  final Widget child;

  const CreateAccountListeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationOtpRequired) {
          _navigateToOtpScreen(context, state);
        } else if (state is RegistrationSuccess) {
          _handleSuccess(context);
        } else if (state is RegistrationFailure) {
          _handleError(context, state);
        }
      },
      child: child,
    );
  }

  void _navigateToOtpScreen(
      BuildContext context, RegistrationOtpRequired state) {
    final cubit = context.read<RegistrationCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpScreen(
          title: context.local.confirm_your_account,
          subtitle: context.local.enter_the_4_digit_sent_to(state.phoneNumber),
          phoneNumber: state.phoneNumber,
          onVerify: (otp) => cubit.verifyOtp(otp),
          onVerifySuccess: () {
            _handleSuccess(context);
          },
        ),
      ),
    ).then((_) {
      cubit.resetToIdle();
    });
  }

  void _handleSuccess(BuildContext context) {
    SnackBarHelper.showSuccess(
        context, context.local.account_created_successfully);
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (context.mounted) {
        context.navigator.goToHome();
      }
    });
  }

  void _handleError(BuildContext context, RegistrationFailure state) {
    final message = state.errorMessage ?? context.local.registration_failed;
    SnackBarHelper.showError(context, message);
  }
}
