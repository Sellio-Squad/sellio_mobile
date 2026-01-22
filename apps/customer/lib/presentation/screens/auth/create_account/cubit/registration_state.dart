import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../shared/enums/validation_error_type.dart';

/// Base class for all registration states
sealed class RegistrationState extends Equatable {
  const RegistrationState();
}

/// Idle state representing the registration form is ready for input
class RegistrationIdle extends RegistrationState {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String city;
  final String password;
  final String confirmPassword;
  final String selectedCountryCode;
  final String phoneCode;
  final bool isFormValid;
  final ValidationErrorType? validationError;
  final List<String> cities;

  const RegistrationIdle({
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.city = '',
    this.password = '',
    this.confirmPassword = '',
    this.selectedCountryCode = 'eg',
    this.phoneCode = '20',
    this.isFormValid = false,
    this.validationError,
    this.cities = const [],
  });

  RegistrationIdle copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? city,
    String? password,
    String? confirmPassword,
    String? selectedCountryCode,
    String? phoneCode,
    File? selectedProfileImage,
    bool? isFormValid,
    ValidationErrorType? validationError,
    bool clearValidationError = false,
    bool clearProfileImage = false,
    List<String>? cities,
  }) {
    return RegistrationIdle(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      phoneCode: phoneCode ?? this.phoneCode,
      isFormValid: isFormValid ?? this.isFormValid,
      validationError: clearValidationError
          ? null
          : (validationError ?? this.validationError),
      cities: cities ?? this.cities,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        city,
        password,
        confirmPassword,
        selectedCountryCode,
        phoneCode,
        isFormValid,
        validationError,
        cities,
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
