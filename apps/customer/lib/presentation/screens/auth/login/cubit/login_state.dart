import 'package:equatable/equatable.dart';

import '../../shared/enums/validation_error_type.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

class LoginIdle extends LoginState {
  final String phoneNumber;
  final String password;
  final String selectedCountryCode;
  final String phoneCode;
  final bool isFormValid;
  final ValidationErrorType? validationError;

  const LoginIdle({
    this.phoneNumber = '',
    this.password = '',
    this.selectedCountryCode = 'eg',
    this.phoneCode = '20',
    this.isFormValid = false,
    this.validationError,
  });

  LoginIdle copyWith({
    String? phoneNumber,
    String? password,
    String? selectedCountryCode,
    String? phoneCode,
    bool? isFormValid,
    ValidationErrorType? validationError,
    bool clearValidationError = false,
  }) {
    return LoginIdle(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      phoneCode: phoneCode ?? this.phoneCode,
      isFormValid: isFormValid ?? this.isFormValid,
      validationError: clearValidationError
          ? null
          : (validationError ?? this.validationError),
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        password,
        selectedCountryCode,
        isFormValid,
        validationError,
      ];
}

class LoginSubmitting extends LoginState {
  const LoginSubmitting();

  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  const LoginSuccess();

  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  final String? errorMessage;

  const LoginFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
