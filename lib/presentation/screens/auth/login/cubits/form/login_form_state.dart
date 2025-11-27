import 'package:equatable/equatable.dart';
import '../../../../../../domain/entities/country.dart';

sealed class LoginFormState extends Equatable {
  const LoginFormState();

  @override
  List<Object?> get props => [];
}

class LoginFormInitial extends LoginFormState {
  const LoginFormInitial();
}

class LoginFormChanged extends LoginFormState {
  final String phoneNumber;
  final String password;
  final Country selectedCountry;
  final bool isFormValid;
  final bool isLoading;
  final String? currentFieldError;

  const LoginFormChanged({
    this.phoneNumber = '',
    this.password = '',
    required this.selectedCountry,
    this.isFormValid = false,
    this.isLoading = false,
    this.currentFieldError,
  });

  LoginFormChanged copyWith({
    String? phoneNumber,
    String? password,
    Country? selectedCountry,
    bool? isFormValid,
    bool? isLoading,
    String? currentFieldError,
    bool clearCurrentFieldError = false,
  }) {
    return LoginFormChanged(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      currentFieldError: clearCurrentFieldError ? null : (currentFieldError ??
          this.currentFieldError),
    );
  }

  @override
  List<Object?> get props =>
      [
        phoneNumber,
        password,
        selectedCountry,
        isFormValid,
        isLoading,
        currentFieldError,
      ];
}

class LoginFormSuccess extends LoginFormState {
  final String phoneNumber;

  const LoginFormSuccess({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class LoginFormError extends LoginFormState {
  final String message;

  const LoginFormError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}