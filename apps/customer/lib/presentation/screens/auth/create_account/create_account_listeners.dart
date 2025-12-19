import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../shared/extensions.dart';
import 'cubits/form/create_account_form_cubit.dart';
import 'cubits/form/create_account_form_state.dart';

class CreateAccountListeners extends StatelessWidget {
  final Widget child;

  const CreateAccountListeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAccountFormCubit, CreateAccountFormState>(
      listener: (context, state) {
        if (state is CreateAccountFormSuccess) {
          _handleSuccess(context);
        } else if (state is CreateAccountFormError) {
          _handleGeneralError(context, state);
        } else if (state is CreateAccountFormLoaded && state.fieldError != null) {
          _handleFieldValidationError(context, state);
        }
      },
      child: child,
    );
  }

  void _handleSuccess(BuildContext context) {
    context.navigator.pushSignupOtp();
  }

  void _handleGeneralError(BuildContext context, CreateAccountFormError state) {
    final message = state.errorType.toLocalizedString(context);
    SnackBarHelper.showError(context, message);
  }

  void _handleFieldValidationError(
      BuildContext context,
      CreateAccountFormLoaded state,
      ) {
    final errorMessage = state.fieldError!.toLocalizedString(context);
    SnackBarHelper.showError(context, errorMessage);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) {
        context.read<CreateAccountFormCubit>().clearFieldError();
      }
    });
  }
}