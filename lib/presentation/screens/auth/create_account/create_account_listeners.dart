import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/app_management/route/routing.dart';

import '../../../../core/design_system/widgets/snack_bar.dart';
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
              context.navigator.pushSignupOtp(
                SignupOtpArgs(
                  phoneNumber: state.phoneNumber,
                ),
              );
            } else if (state is CreateAccountFormError) {
              _showErrorSnackBar(context, state.message);
            } else if (state is CreateAccountFormChanged &&
                state.currentFieldError != null) {
              _showErrorSnackBar(context, state.currentFieldError!);
            }
          },
        ),
      ],
      child: child,
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

    Future.delayed(const Duration(seconds: 4), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
