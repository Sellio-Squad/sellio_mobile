import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../shared/extensions.dart';
import 'cubits/form/login_form_cubit.dart';
import 'cubits/form/login_form_state.dart';

class LoginListeners extends StatelessWidget {
  final Widget child;

  const LoginListeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormCubit, LoginFormState>(
      listener: (context, state) {
        if (state is LoginFormSuccess) {
          _handleSuccess(context, state);
        } else if (state is LoginFormError) {
          _handleGeneralError(context, state);
        } else if (state is LoginFormLoaded && state.fieldError != null) {
          _handleFieldValidationError(context, state);
        }
      },
      child: child,
    );
  }

  void _handleSuccess(BuildContext context, LoginFormSuccess state) {
    SnackBarHelper.showSuccess(context, context.local.login);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (context.mounted) {
        context.navigator.goToHome();
      }
    });
  }

  void _handleGeneralError(BuildContext context, LoginFormError state) {
    final message = state.errorType.toLocalizedString(context);
    SnackBarHelper.showError(context, message);
  }

  void _handleFieldValidationError(
      BuildContext context,
      LoginFormLoaded state,
      ) {
    final errorMessage = state.fieldError!.toLocalizedString(context);
    SnackBarHelper.showError(context, errorMessage);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) {
        context.read<LoginFormCubit>().clearFieldError();
      }
    });
  }
}
