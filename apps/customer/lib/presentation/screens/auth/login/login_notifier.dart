import 'package:flutter/foundation.dart';


class LoginEventNotifier {
  final ValueNotifier<bool?> _loginEvent = ValueNotifier<bool?>(null);

  ValueListenable<bool?> get loginEvent => _loginEvent;

  void notifyLoginSuccess() {
    _loginEvent.value = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      _loginEvent.value = null;
    });
  }

}
