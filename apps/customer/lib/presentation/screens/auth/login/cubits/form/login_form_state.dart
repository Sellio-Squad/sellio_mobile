import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/enums/validation_error_type.dart';

sealed class LoginFormState extends Equatable {
  const LoginFormState();
}

class LoginFormInitial extends LoginFormState {
  const LoginFormInitial();

  @override
  List<Object?> get props => [];
}

class LoginFormLoaded extends LoginFormState {
  final String phoneNumber;
  final String password;
  final Country? selectedCountry;
  final bool isFormValid;
  final bool isLoading;
  final ValidationErrorType? fieldError;

  const LoginFormLoaded({
    this.phoneNumber = '',
    this.password = '',
    this.selectedCountry,
    this.isFormValid = false,
    this.isLoading = false,
    this.fieldError,
  });

  LoginFormLoaded copyWith({
    String? phoneNumber,
    String? password,
    Country? selectedCountry,
    bool? isFormValid,
    bool? isLoading,
    ValidationErrorType? fieldError,
    bool clearFieldError = false,
  }) {
    return LoginFormLoaded(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      fieldError: clearFieldError ? null : (fieldError ?? this.fieldError),
    );
  }

  @override
  List<Object?> get props => [
    phoneNumber,
    password,
    selectedCountry,
    isFormValid,
    isLoading,
    fieldError,
  ];
}

class LoginFormSuccess extends LoginFormState {
  final String phoneNumber;

  const LoginFormSuccess({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class LoginFormError extends LoginFormState {
  final String messageKey;

  const LoginFormError({required this.messageKey});

  @override
  List<Object> get props => [messageKey];
}