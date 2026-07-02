import 'package:authentication/authentication.dart';

abstract class AppNavigator implements AuthNavigator {
  void pushCreateStore();

  void goToDashboard();
  void goToHome();
  void goToLogin();
  void pop<T extends Object?>([T? result]);
}
