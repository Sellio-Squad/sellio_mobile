import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/auth_localization_service.dart';
import '../../../cubits/auth/authentication_cubit.dart';
import '../../../navigation/auth_navigator.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginListeners extends StatelessWidget {
  final Widget child;
  final AuthNavigator navigator;

  const LoginListeners({
    super.key,
    required this.child,
    required this.navigator,
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
    final authCubit = context.read<AuthenticationCubit>();
    authCubit.loadUserProfile();
    SnackBarHelper.showSuccess(
      context,
      context.authLocal.login,
      title: context.authLocal.success,
    );
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (context.mounted) {
        navigator.pop();
      }
    });
  }

  void _handleError(BuildContext context, LoginFailure state) {
    final message = state.errorMessage ?? context.authLocal.login_failed;
    SnackBarHelper.showError(
      context,
      message,
      title: context.authLocal.error,
    );
  }
}
