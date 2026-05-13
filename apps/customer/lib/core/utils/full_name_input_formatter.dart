import 'package:flutter/services.dart';

class FullNameInputFormatter extends TextInputFormatter {
  static const int maxLength = 50;

  static final RegExp _allowedPattern = RegExp(r'^[a-zA-Z\u0600-\u06FF ]*$');
  static final RegExp _doubleSpacePattern = RegExp(r' {2}');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) return oldValue;

    if (_doubleSpacePattern.hasMatch(newValue.text)) return oldValue;

    if (newValue.text.length > maxLength) return oldValue;

    if (!_allowedPattern.hasMatch(newValue.text)) {
      return oldValue;
    }

    return newValue;
  }
}
