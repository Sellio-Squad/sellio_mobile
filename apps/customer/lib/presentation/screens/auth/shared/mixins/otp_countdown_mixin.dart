import 'dart:async';
import 'package:flutter/material.dart';

mixin OtpCountdownMixin<T extends StatefulWidget> on State<T> {
  static const int _defaultCountdownSeconds = 55;

  Timer? _countdownTimer;
  int _resendCountdown = 0;

  int get resendCountdown => _resendCountdown;
  bool get canResend => _resendCountdown == 0;

  void startResendCountdown([int seconds = _defaultCountdownSeconds]) {
    _resendCountdown = seconds;
    _countdownTimer?.cancel();

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  void cancelCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  @override
  void dispose() {
    cancelCountdown();
    super.dispose();
  }
}