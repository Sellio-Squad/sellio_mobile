import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

import '../../shared/enums/validation_error_type.dart';

/// Base class for all registration states
sealed class RegistrationState extends Equatable {
  const RegistrationState();
}

/// Idle state representing the registration form is ready for input
class RegistrationIdle extends RegistrationState {
  final String fullName;
  final String phoneNumber;
  final String city;
  final String password;
  final String confirmPassword;
  final Country? selectedCountry;
  final bool isFormValid;
  final ValidationErrorType? validationError;

  const RegistrationIdle({
    this.fullName = '',
    this.phoneNumber = '',
    this.city = '',
    this.password = '',
    this.confirmPassword = '',
    this.selectedCountry,
    this.isFormValid = false,
    this.validationError,
  });

  RegistrationIdle copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? city,
    String? password,
    String? confirmPassword,
    Country? selectedCountry,
    File? selectedProfileImage,
    bool? isFormValid,
    ValidationErrorType? validationError,
    bool clearValidationError = false,
    bool clearProfileImage = false,
  }) {
    return RegistrationIdle(
      fullName: firstName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isFormValid: isFormValid ?? this.isFormValid,
      validationError: clearValidationError ? null : (validationError ?? this.validationError),
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        phoneNumber,
        city,
        password,
        confirmPassword,
        selectedCountry,
        isFormValid,
        validationError,
      ];
}

/// State indicating registration operation is in progress
class RegistrationSubmitting extends RegistrationState {
  const RegistrationSubmitting();

  @override
  List<Object?> get props => [];
}

/// State indicating OTP is required for registration
/// Repository handles sessionId internally, presentation layer navigates to OTP screen
class RegistrationOtpRequired extends RegistrationState {
  final String phoneNumber;

  const RegistrationOtpRequired({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

/// State indicating registration was successful
class RegistrationSuccess extends RegistrationState {
  const RegistrationSuccess();

  @override
  List<Object> get props => [];
}

/// State indicating registration operation failed
class RegistrationFailure extends RegistrationState {
  final String? errorMessage;

  const RegistrationFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
