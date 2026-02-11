import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import '../../../../core/utils/snackbar_helper.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class LoginListeners extends StatelessWidget {
  final Widget child;

  const LoginListeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _handleSuccess(context);
        } else if (state is LoginFailure) {
          _handleError(context, state);
        }
      },
      child: child,
    );
  }

  void _handleSuccess(BuildContext context) {
    SnackBarHelper.showSuccess(context, context.local.login);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (context.mounted) {
        context.navigator.goToHome();
      }
    });
  }

  void _handleError(BuildContext context, LoginFailure state) {
    final message = state.errorMessage ?? context.local.login_failed;
    SnackBarHelper.showError(context, message);
  }
}
