import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';

import 'package:design_system/design_system.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginFormCubit, LoginFormState>(
          listener: (context, state) {
            if (state is LoginFormSuccess) {
              _handleSuccess(context, state);
            } else if (state is LoginFormError) {
              _handleGeneralError(context, state.message);
            } else if (state is LoginFormChanged &&
                state.currentFieldError != null) {
              _handleFieldValidationError(context, state);
            }
          },
        ),
      ],
      child: child,
    );
  }

  void _handleSuccess(BuildContext context, LoginFormSuccess state) {
    _showSuccessSnackBar(context, 'Login successful!');

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (context.mounted) {
        context.navigator.goToHome();
      }
    }
    );
  }

  void _handleGeneralError(BuildContext context, String message) {
    _showErrorSnackBar(context, message);
  }

  void _handleFieldValidationError(BuildContext context,
      LoginFormChanged state) {
    _showErrorSnackBar(context, state.currentFieldError!);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) {
        context.read<LoginFormCubit>().clearCurrentFieldError();
      }
    }
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) =>
          Positioned(
            top: MediaQuery
                .of(context)
                .padding
                .top + 26,
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

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) =>
          Positioned(
            top: MediaQuery
                .of(context)
                .padding
                .top + 26,
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

    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    }
    );
  }
}
