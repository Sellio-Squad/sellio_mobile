import 'package:authentication/authentication.dart';

abstract class AppNavigator implements AuthNavigator {
  void goToHome();
  void goToLogin();
  void pop<T extends Object?>([T? result]);
}
