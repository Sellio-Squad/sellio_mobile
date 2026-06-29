import 'dart:ui';

import 'package:core/core.dart';

abstract class AuthNavigator {
  void pushLogin();
  void pushCreateAccount();
  void pushForgotPassword();
  Future<void> pushOtp({
    required String phoneNumber,
    required Future<Result<void>> Function(String otp) onVerify,
    required VoidCallback onVerifySuccess,
  });
  void pushResetPassword();
  void goToHome();
  void goToLogin();
  void pop<T extends Object?>([T? result]);
}
