import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:country_picker/country_picker.dart';
import '../../../../domain/validators/validation_error_type.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationIdle extends RegistrationState {
  final String fullName;
  final String phoneNumber;
  final String city;
  final String password;
  final String confirmPassword;
  final String phoneCode;
  final String countryName;
  final bool isFormValid;
  final FullNameValidationError? fullNameError;
  final PhoneValidationError? phoneError;
  final CityValidationError? cityError;
  final PasswordValidationError? passwordError;
  final PasswordValidationError? confirmPasswordError;
  final Country selectedCountry;
  final List<String> cities;

  const RegistrationIdle({
    this.fullName = '',
    this.phoneNumber = '',
    this.city = '',
    this.password = '',
    this.countryName = 'Egypt',
    this.confirmPassword = '',
    required this.selectedCountry,
    this.phoneCode = '20',
    this.isFormValid = false,
    this.fullNameError,
    this.phoneError,
    this.cityError,
    this.passwordError,
    this.confirmPasswordError,
    this.cities = const [],
  });

  RegistrationIdle copyWith({
    String? fullName,
    String? phoneNumber,
    String? city,
    String? password,
    String? confirmPassword,
    Country? selectedCountry,
    String? countryName,
    String? phoneCode,
    File? selectedProfileImage,
    bool? isFormValid,
    FullNameValidationError? Function()? fullNameError,
    PhoneValidationError? Function()? phoneError,
    CityValidationError? Function()? cityError,
    PasswordValidationError? Function()? passwordError,
    PasswordValidationError? Function()? confirmPasswordError,
    List<String>? cities,
  }) {
    return RegistrationIdle(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      countryName: countryName ?? this.countryName,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      phoneCode: phoneCode ?? this.phoneCode,
      isFormValid: isFormValid ?? this.isFormValid,
      fullNameError:
          fullNameError != null ? fullNameError() : this.fullNameError,
      phoneError: phoneError != null ? phoneError() : this.phoneError,
      cityError: cityError != null ? cityError() : this.cityError,
      passwordError:
          passwordError != null ? passwordError() : this.passwordError,
      confirmPasswordError: confirmPasswordError != null
          ? confirmPasswordError()
          : this.confirmPasswordError,
      cities: cities ?? this.cities,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        selectedCountry,
        phoneNumber,
        city,
        password,
        confirmPassword,
        phoneCode,
        isFormValid,
        fullNameError,
        phoneError,
        cityError,
        passwordError,
        confirmPasswordError,
        cities,
      ];
}

class RegistrationSubmitting extends RegistrationState {
  const RegistrationSubmitting();

  @override
  List<Object> get props => [];
}

class RegistrationOtpRequired extends RegistrationState {
  final String phoneNumber;

  const RegistrationOtpRequired({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

class RegistrationSuccess extends RegistrationState {
  const RegistrationSuccess();

  @override
  List<Object> get props => [];
}

class RegistrationFailure extends RegistrationState {
  final String? errorMessage;

  const RegistrationFailure({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
