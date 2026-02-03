import 'package:flutter/services.dart';

class FullNameInputFormatter extends TextInputFormatter {
  static const int maxLength = 50;
  static const String _allowedPattern = r'[a-zA-Z\u0600-\u06FF ]';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) return oldValue;

    if (newValue.text.contains('  ')) return oldValue;

    if (newValue.text.length > maxLength) return oldValue;
    if (!RegExp('^$_allowedPattern*\$').hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}
