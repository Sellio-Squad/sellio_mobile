import '../constants/auth_constants.dart';
import '../enums/form_field_type.dart';
import '../enums/validation_error_type.dart';
import 'validation_result.dart';

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
    if (!AuthConstants.digitsOnly.hasMatch(phone)) {
      return const ValidationResult.invalid(PhoneValidationError.digitsOnly);
    }
    if (minLength != null && phone.length != minLength) {
      return const ValidationResult.invalid(PhoneValidationError.minLength);
    }

    return const ValidationResult.valid();
  }

  static ValidationResult validatePassword(String password) {
    if (password.length < AuthConstants.minPasswordLength) {
      return const ValidationResult.invalid(
        PasswordValidationError.minLength,
      );
    }
    if (password.length > AuthConstants.maxPasswordLength) {
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
    if (name.length < AuthConstants.minNameLength) {
      return const ValidationResult.invalid(FullNameValidationError.minLength);
    }
    if (!AuthConstants.lettersAndSpaces.hasMatch(name)) {
      return const ValidationResult.invalid(
          FullNameValidationError.lettersOnly);
    }

    return const ValidationResult.valid();
  }

  static ValidationResult validateCity(String city) {
    if (city.length < AuthConstants.minLocationLength) {
      return const ValidationResult.invalid(CityValidationError.minLength);
    }
    if (!AuthConstants.lettersAndSpaces.hasMatch(city)) {
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
