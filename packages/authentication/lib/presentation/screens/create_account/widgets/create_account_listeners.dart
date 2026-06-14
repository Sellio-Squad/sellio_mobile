import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/auth_localization_service.dart';
import '../../../navigation/auth_navigator.dart';
import '../cubit/registration_cubit.dart';
import '../cubit/registration_state.dart';

class CreateAccountListeners extends StatelessWidget {
  final Widget child;
  final AuthNavigator navigator;

  const CreateAccountListeners({
    super.key,
    required this.child,
    required this.navigator,
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
      BuildContext context, RegistrationOtpRequired state) async {
    final cubit = context.read<RegistrationCubit>();

    await navigator.pushOtp(
      phoneNumber: state.phoneNumber,
      onVerify: (otp) => cubit.verifyOtp(otp),
      onVerifySuccess: () => _handleSuccess(context),
    );

    if (context.mounted) {
      cubit.resetToIdle();
    }
  }

  void _handleSuccess(BuildContext context) {
    SnackBarHelper.showSuccess(
      context,
      context.authLocal.account_created_successfully,
      title: context.authLocal.success,
    );
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (context.mounted) {
        navigator.goToHome();
      }
    });
  }

  void _handleError(BuildContext context, RegistrationFailure state) {
    final message = state.errorMessage ?? context.authLocal.registration_failed;
    SnackBarHelper.showError(
      context,
      message,
      title: context.authLocal.error,
    );
  }
}
