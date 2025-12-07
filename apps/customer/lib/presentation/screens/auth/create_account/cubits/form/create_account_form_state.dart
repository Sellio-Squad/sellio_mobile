import 'dart:io';
import 'package:equatable/equatable.dart';
import '../../../country.dart';

sealed class CreateAccountFormState extends Equatable {
  const CreateAccountFormState();
}

class CreateAccountFormInitial extends CreateAccountFormState {
  const CreateAccountFormInitial();

  @override
  List<Object?> get props => [];
}

class CreateAccountFormChanged extends CreateAccountFormState {
  final String phoneNumber;
  final String fullName;
  final String country;
  final String city;
  final String password;
  final String confirmPassword;
  final Country selectedCountry;
  final File? selectedProfileImage;
  final bool isFormValid;
  final bool isLoading;
  final String? phoneError;
  final String? nameError;
  final String? countryError;
  final String? cityError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? currentFieldError;

  const CreateAccountFormChanged({
    this.phoneNumber = '',
    this.fullName = '',
    this.country = '',
    this.city = '',
    this.password = '',
    this.confirmPassword = '',
    required this.selectedCountry,
    this.selectedProfileImage,
    this.isFormValid = false,
    this.isLoading = false,
    this.phoneError,
    this.nameError,
    this.countryError,
    this.cityError,
    this.passwordError,
    this.confirmPasswordError,
    this.currentFieldError,
  });

  CreateAccountFormChanged copyWith({
    String? phoneNumber,
    String? fullName,
    String? country,
    String? city,
    String? password,
    String? confirmPassword,
    Country? selectedCountry,
    File? selectedProfileImage,
    bool? isFormValid,
    bool? isLoading,
    String? phoneError,
    String? nameError,
    String? countryError,
    String? cityError,
    String? passwordError,
    String? confirmPasswordError,
    String? currentFieldError,
    bool clearProfileImage = false,
    bool clearCurrentFieldError = false,
  }) {
    return CreateAccountFormChanged(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      country: country ?? this.country,
      city: city ?? this.city,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedProfileImage: clearProfileImage
          ? null
          : (selectedProfileImage ?? this.selectedProfileImage),
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      phoneError: phoneError,
      nameError: nameError,
      countryError: countryError,
      cityError: cityError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      currentFieldError: clearCurrentFieldError
          ? null
          : (currentFieldError ?? this.currentFieldError),
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        fullName,
        country,
        city,
        password,
        confirmPassword,
        selectedCountry,
        selectedProfileImage,
        isFormValid,
        isLoading,
        phoneError,
        nameError,
        countryError,
        cityError,
        passwordError,
        confirmPasswordError,
        currentFieldError,
      ];
}

class CreateAccountFormError extends CreateAccountFormState {
  final String message;

  const CreateAccountFormError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateAccountFormSuccess extends CreateAccountFormState {
  final String phoneNumber;

  const CreateAccountFormSuccess({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class CreateAccountFormFieldError extends CreateAccountFormState {
  final String message;

  const CreateAccountFormFieldError({required this.message});

  @override
  List<Object?> get props => [message];
}
