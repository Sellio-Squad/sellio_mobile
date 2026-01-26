import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../shared/enums/validation_error_type.dart';

/// Base class for all registration states
sealed class RegistrationState extends Equatable {
  final String selectedCountryCode;
  final Country? selectedCountry;

  const RegistrationState({
    this.selectedCountryCode = 'eg',
    this.selectedCountry,
  });

  @override
  List<Object?> get props => [selectedCountryCode, selectedCountry];
}

/// Idle state representing the registration form is ready for input
class RegistrationIdle extends RegistrationState {
  final String fullName;
  final String phoneNumber;
  final String city;
  final String password;
  final String confirmPassword;
  final String selectedCountryCode;
  final String phoneCode;
  final String countryName;
  final bool isFormValid;
  final ValidationErrorType? validationError;

  const RegistrationIdle({
    this.fullName = '',
    this.phoneNumber = '',
    this.city = '',
    this.password = '',
    this.countryName = 'North korea',
    this.confirmPassword = '',
    this.selectedCountryCode = 'eg',
    this.phoneCode = '20',
    this.isFormValid = false,
    this.validationError,
  });

  RegistrationIdle copyWith({
    String? fullName,
    String? phoneNumber,
    String? email,
    String? city,
    String? password,
    String? confirmPassword,
    String? selectedCountryCode,
    Country? selectedCountry,
    String? countryName,
    String? phoneCode,
    File? selectedProfileImage,
    bool? isFormValid,
    ValidationErrorType? validationError,
    bool clearValidationError = false,
    bool clearProfileImage = false,
  }) {
    return RegistrationIdle(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      countryName: countryName ?? this.countryName,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      phoneCode: phoneCode ?? this.phoneCode,
      isFormValid: isFormValid ?? this.isFormValid,
      validationError: clearValidationError
          ? null
          : (validationError ?? this.validationError),
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        ...super.props,
        phoneNumber,
        city,
        password,
        confirmPassword,
        phoneCode,
        isFormValid,
        validationError,
      ];
}

/// State indicating registration operation is in progress
class RegistrationSubmitting extends RegistrationState {
  const RegistrationSubmitting({
    required super.selectedCountryCode,
    super.selectedCountry,
  });
}

/// State indicating OTP is required for registration
/// Repository handles sessionId internally, presentation layer navigates to OTP screen
class RegistrationOtpRequired extends RegistrationState {
  final String phoneNumber;

  const RegistrationOtpRequired({
    required this.phoneNumber,
    required super.selectedCountryCode,
    super.selectedCountry,
  });

  @override
  List<Object?> get props => [...super.props, phoneNumber];
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

  const RegistrationFailure({
    this.errorMessage,
    required super.selectedCountryCode,
    super.selectedCountry,
  });

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
