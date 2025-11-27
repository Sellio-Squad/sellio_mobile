import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';

import '../../../../core/design_system/widgets/sellio_snack_bar.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateAccountFormCubit, CreateAccountFormState>(
          listener: (context, state) {
            if (state is CreateAccountFormSuccess) {
              _handleSuccess(context, state);
            } else if (state is CreateAccountFormError) {
              _handleGeneralError(context, state.message);
            } else if (state is CreateAccountFormChanged &&
                state.currentFieldError != null) {
              _handleFieldValidationError(context, state);
            }
          },
        ),
      ],
      child: child,
    );
  }

  void _handleSuccess(BuildContext context, CreateAccountFormSuccess state) {
    context.navigator.pushSignupOtp(
      SignupOtpArgs(
        phoneNumber: state.phoneNumber,
        sessionId: state.sessionId,
      ),
    );
  }

  void _handleGeneralError(BuildContext context, String message) {
    _showErrorSnackBar(context, message);
  }

  void _handleFieldValidationError(
      BuildContext context, CreateAccountFormChanged state) {
    _showErrorSnackBar(context, state.currentFieldError!);

    // Clear the field error after showing the snackbar
    Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) {
        context.read<CreateAccountFormCubit>().clearCurrentFieldError();
      }
    });
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

    Future.delayed(const Duration(seconds: 4), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
