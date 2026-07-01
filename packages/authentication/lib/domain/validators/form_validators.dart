import 'package:core/core.dart';
import 'form_field_type.dart';
import 'validation_error_type.dart';

abstract class FormValidators {
  FormValidators._();

  static ValidationResult validateField(
    FormFieldType fieldType,
    String value, {
    String? password,
    int? minPhoneLength,
  }) {
    return switch (fieldType) {
      FormFieldType.phone => validatePhone(value, minLength: minPhoneLength),
      FormFieldType.password => validatePassword(value),
      FormFieldType.confirmPassword =>
        validateConfirmPassword(password ?? '', value),
      FormFieldType.fullName => validateFullName(value),
      FormFieldType.city => validateCity(value),
    };
  }

  static ValidationResult validatePhone(String phone, {int? minLength}) {
    if (!ValidatorUtils.isLettersOnly(phone) && !ValidationConstants.digitsOnly.hasMatch(phone)) {
       return const ValidationResult.invalid(PhoneValidationError.digitsOnly);
    }
    
    final targetLength = minLength ?? ValidationConstants.minPhoneLength;
    if (phone.length < targetLength) {
      return const ValidationResult.invalid(PhoneValidationError.minLength);
    }

    return const ValidationResult.valid();
  }

  static ValidationResult validatePassword(String password) {
    if (password.length < ValidationConstants.minPasswordLength) {
      return const ValidationResult.invalid(
        PasswordValidationError.minLength,
      );
    }
    if (password.length > ValidationConstants.maxPasswordLength) {
      return const ValidationResult.invalid(
        PasswordValidationError.maxLength,
      );
    }

    return const ValidationResult.valid();
  }

  static ValidationResult validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (password != confirmPassword) {
      return const ValidationResult.invalid(
          PasswordValidationError.passwordsDoNotMatch);
    }

    return const ValidationResult.valid();
  }

  static ValidationResult validateFullName(String name) {
    if (name.length < ValidationConstants.minNameLength) {
      return const ValidationResult.invalid(FullNameValidationError.minLength);
    }
    if (!ValidationConstants.lettersAndSpaces.hasMatch(name)) {
      return const ValidationResult.invalid(
          FullNameValidationError.lettersOnly);
    }

    return const ValidationResult.valid();
  }

  static ValidationResult validateCity(String city) {
    if (city.length < ValidationConstants.minLocationLength) {
      return const ValidationResult.invalid(CityValidationError.minLength);
    }
    if (!ValidationConstants.lettersAndSpaces.hasMatch(city)) {
      return const ValidationResult.invalid(CityValidationError.lettersOnly);
    }

    return const ValidationResult.valid();
  }

  static bool isLoginFormValid({
    required String phone,
    required String password,
    int? minPhoneLength,
  }) {
    return phone.isNotEmpty &&
        password.isNotEmpty &&
        validatePhone(phone, minLength: minPhoneLength).isValid &&
        validatePassword(password).isValid;
  }

  static bool isRegistrationFormValid({
    required String fullName,
    required String phone,
    required String city,
    required String password,
    required String confirmPassword,
    int? minPhoneLength,
  }) {
    return fullName.isNotEmpty &&
        phone.isNotEmpty &&
        city.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        validateFullName(fullName).isValid &&
        validatePhone(phone, minLength: minPhoneLength).isValid &&
        validateCity(city).isValid &&
        validatePassword(password).isValid &&
        validateConfirmPassword(password, confirmPassword).isValid;
  }
}
