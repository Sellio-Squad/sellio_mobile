import 'validation_constants.dart';

class ValidatorUtils {
  ValidatorUtils._();

  static bool isValidPhone(String phone) {
    return phone.length >= ValidationConstants.minPhoneLength &&
        ValidationConstants.digitsOnly.hasMatch(phone);
  }

  static bool isValidLength(String? value, int min, [int? max]) {
    if (value == null) return false;
    final length = value.trim().length;
    if (length < min) return false;
    if (max != null && length > max) return false;
    return true;
  }

  static bool isLettersOnly(String value) {
    return ValidationConstants.lettersAndSpaces.hasMatch(value);
  }

  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
