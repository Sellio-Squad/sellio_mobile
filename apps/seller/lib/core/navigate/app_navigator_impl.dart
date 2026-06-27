import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'app_navigator.dart';
import 'app_routes.dart';
import 'route_manager.dart';
import 'route_args.dart';

class AppNavigatorImpl implements AppNavigator {
  @override
  void pushLogin() {
    RouteGenerator.router.pushNamed(AppRoutes.login.name);
  }

  @override
  void pushCreateAccount() {
    RouteGenerator.router.pushNamed(AppRoutes.register.name);
  }

  @override
  void pushForgotPassword() {
    RouteGenerator.router.pushNamed(AppRoutes.forgotPassword.name);
  }

  @override
  Future<void> pushOtp({
    required String phoneNumber,
    required Future<Result<void>> Function(String otp) onVerify,
    required VoidCallback onVerifySuccess,
  }) async {
    RouteGenerator.router.pushNamed(
      AppRoutes.otp.name,
      extra: OtpArgs(
        phoneNumber: phoneNumber,
        onVerify: onVerify,
        onVerifySuccess: onVerifySuccess,
      ),
    );
  }

  @override
  void pushResetPassword() {
    RouteGenerator.router.pushNamed(AppRoutes.resetPassword.name);
  }

  @override
  void goToHome() {
    RouteGenerator.router.goNamed(AppRoutes.home.name);
  }

  @override
  void goToLogin() {
    RouteGenerator.router.goNamed(AppRoutes.login.name);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    RouteGenerator.router.pop(result);
  }
}
