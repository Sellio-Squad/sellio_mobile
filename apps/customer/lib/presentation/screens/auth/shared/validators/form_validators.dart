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
      FormFieldType.firstName => validateFirstName(value),
      FormFieldType.lastName => validateLastName(value),
      FormFieldType.city => validateCity(value),
    };
  }

  static ValidationResult validatePhone(String phone, {int? minLength}) {
    if (!AuthConstants.digitsOnly.hasMatch(phone)) {
      return const ValidationResult.invalid(
          ValidationErrorType.phoneDigitsOnly);
    }
    if (minLength != null && phone.length != minLength) {
      return const ValidationResult.invalid(ValidationErrorType.phoneMinLength);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validatePassword(String password) {
    if (password.length < AuthConstants.minPasswordLength) {
      return const ValidationResult.invalid(
          ValidationErrorType.passwordMinLength);
    }
    if (password.length > AuthConstants.maxPasswordLength) {
      return const ValidationResult.invalid(
          ValidationErrorType.passwordMaxLength);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (password != confirmPassword) {
      return const ValidationResult.invalid(
          ValidationErrorType.passwordsDoNotMatch);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateFirstName(String name) {
    if (name.length < AuthConstants.minNameLength) {
      return const ValidationResult.invalid(
          ValidationErrorType.firstNameMinLength);
    }
    if (!AuthConstants.lettersAndSpaces.hasMatch(name)) {
      return const ValidationResult.invalid(
          ValidationErrorType.firstNameLettersOnly);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateLastName(String name) {
    if (name.length < AuthConstants.minNameLength) {
      return const ValidationResult.invalid(
          ValidationErrorType.lastNameMinLength);
    }
    if (!AuthConstants.lettersAndSpaces.hasMatch(name)) {
      return const ValidationResult.invalid(
          ValidationErrorType.lastNameLettersOnly);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateCity(String city) {
    if (city.length < AuthConstants.minLocationLength) {
      return const ValidationResult.invalid(ValidationErrorType.cityMinLength);
    }
    if (!AuthConstants.lettersAndSpaces.hasMatch(city)) {
      return const ValidationResult.invalid(
          ValidationErrorType.cityLettersOnly);
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
    required String firstName,
    required String lastName,
    required String phone,
    required String city,
    required String password,
    required String confirmPassword,
  }) {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        phone.isNotEmpty &&
        city.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        validateFirstName(firstName).isValid &&
        validateLastName(lastName).isValid &&
        validatePhone(phone).isValid &&
        validateCity(city).isValid &&
        validatePassword(password).isValid &&
        validateConfirmPassword(password, confirmPassword).isValid;
  }

  static ValidationErrorType? validateRegistrationFields({
    required String firstName,
    required String lastName,
    required String phone,
    required String city,
    required String password,
    required String confirmPassword,
  }) {
    final validations = [
      validateFirstName(firstName),
      validateLastName(lastName),
      validatePhone(phone),
      validateCity(city),
      validatePassword(password),
      validateConfirmPassword(password, confirmPassword),
    ];

    for (final validation in validations) {
      if (!validation.isValid) {
        return validation.errorType;
      }
    }
    return null;
  }

  static ValidationErrorType? validateLoginFields({
    required String phone,
    required String password,
  }) {
    final phoneValidation = validatePhone(phone);
    if (!phoneValidation.isValid) {
      return phoneValidation.errorType;
    }

    final passwordValidation = validatePassword(password);
    if (!passwordValidation.isValid) {
      return passwordValidation.errorType;
    }

    return null;
  }
}
