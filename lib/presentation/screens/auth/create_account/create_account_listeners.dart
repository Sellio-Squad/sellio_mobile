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
            }
            else if (state is CreateAccountFormError) {
              _showError(context, state.message);
            }
            else if (state is CreateAccountFormChanged && state.currentFieldError != null) {
              _handleFieldError(context, state);
            }
          },
        ),
      ],
      child: child,
    );
  }

  //----------------------- SUCCESS → NAVIGATE OTP -----------------------//
  void _handleSuccess(BuildContext context, CreateAccountFormSuccess state) {
    context.navigator.pushSignupOtp(
      SignupOtpArgs(
        phoneNumber: state.phoneNumber,
        countryCode: state.countryCode,            // ← REQUIRED & FIXED
      ),
    );
  }

  //----------------------- ERROR HANDLING -----------------------//
  void _handleFieldError(BuildContext context, CreateAccountFormChanged state) {
    _showError(context, state.currentFieldError!);

    Future.delayed(const Duration(milliseconds: 150), () {
      if (context.mounted) {
        context.read<CreateAccountFormCubit>().clearCurrentFieldError();
      }
    });
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => Positioned(
        top: MediaQuery.of(context).padding.top + 26,
        left: 0, right: 0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SellioSnackBar(
              isError: true,
              message: message,
              onCancelTap: () => entry.remove(),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 4), () {
      if (entry.mounted) entry.remove();
    });
  }
}
