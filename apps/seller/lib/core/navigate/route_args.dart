import 'package:core/core.dart';
import 'package:flutter/material.dart';

class OtpArgs {
  final String phoneNumber;
  final String? title;
  final String? subtitle;
  final Future<Result<void>> Function(String otp) onVerify;
  final VoidCallback onVerifySuccess;

  OtpArgs({
    required this.phoneNumber,
    this.title,
    this.subtitle,
    required this.onVerify,
    required this.onVerifySuccess,
  });
}
