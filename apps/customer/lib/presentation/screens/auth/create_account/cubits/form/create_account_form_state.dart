import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import '../../../enums/auth_error_type.dart';
import '../../../enums/validation_error_type.dart';

sealed class CreateAccountFormState extends Equatable {
  const CreateAccountFormState();
}

class CreateAccountFormInitial extends CreateAccountFormState {
  const CreateAccountFormInitial();

  @override
  List<Object?> get props => [];
}

class CreateAccountFormLoaded extends CreateAccountFormState {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String city;
  final String password;
  final String confirmPassword;
  final Country? selectedCountry;
  final File? selectedProfileImage;
  final bool isFormValid;
  final bool isLoading;
  final ValidationErrorType? fieldError;

  const CreateAccountFormLoaded({
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.email = '',
    this.city = '',
    this.password = '',
    this.confirmPassword = '',
    this.selectedCountry,
    this.selectedProfileImage,
    this.isFormValid = false,
    this.isLoading = false,
    this.fieldError,
  });

  CreateAccountFormLoaded copyWith({
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
    bool? isLoading,
    ValidationErrorType? fieldError,
    bool clearFieldError = false,
    bool clearProfileImage = false,
  }) {
    return CreateAccountFormLoaded(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      city: city ?? this.city,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedProfileImage: clearProfileImage
          ? null
          : (selectedProfileImage ?? this.selectedProfileImage),
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      fieldError: clearFieldError ? null : (fieldError ?? this.fieldError),
    );
  }

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    phoneNumber,
    email,
    city,
    password,
    confirmPassword,
    selectedCountry,
    selectedProfileImage,
    isFormValid,
    isLoading,
    fieldError,
  ];
}

class CreateAccountFormSuccess extends CreateAccountFormState {
  const CreateAccountFormSuccess();

  @override
  List<Object?> get props => [];
}

class CreateAccountFormError extends CreateAccountFormState {
  final AuthErrorType errorType;

  const CreateAccountFormError({required this.errorType});

  @override
  List<Object?> get props => [errorType];
}
