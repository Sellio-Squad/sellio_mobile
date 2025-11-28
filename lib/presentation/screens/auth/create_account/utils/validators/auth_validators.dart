// lib/core/utils/validators/auth_validators.dart
class AuthValidators {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return null; // Let required check handle empty
    if (value.length < 10) return 'Phone number must be at least 10 digits';
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 2) return 'Must be at least 2 characters';
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Must contain only letters and spaces';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirm) {
    if (password != confirm) return 'Passwords do not match';
    return null;
  }
}