import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

import '../../shared/enums/validation_error_type.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

class LoginIdle extends LoginState {
  final String phoneNumber;
  final String password;
  final String phoneCode;
  final bool isFormValid;
  final ValidationErrorType? validationError;
  final Country selectedCountry;

  const LoginIdle({
    this.phoneNumber = '',
    this.password = '',
    this.phoneCode = '20',
    required this.selectedCountry,
    this.isFormValid = false,
    this.validationError,
  });

  LoginIdle copyWith({
    String? phoneNumber,
    String? password,
    Country? selectedCountry,
    String? phoneCode,
    bool? isFormValid,
    ValidationErrorType? validationError,
    bool clearValidationError = false,
  }) {
    return LoginIdle(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      phoneCode: phoneCode ?? this.phoneCode,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isFormValid: isFormValid ?? this.isFormValid,
      validationError: clearValidationError
          ? null
          : (validationError ?? this.validationError),
    );
  }

  @override
  List<Object?> get props => [
        selectedCountry,
        phoneNumber,
        password,
        phoneCode,
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

  const LoginFailure({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
