import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

import '../../shared/enums/validation_error_type.dart';

sealed class LoginState extends Equatable {
  final Country? selectedCountry;
  const LoginState({this.selectedCountry});

  @override
  List<Object?> get props => [selectedCountry];
}

class LoginIdle extends LoginState {
  final String phoneNumber;
  final String password;
  final String selectedCountryCode;
  final String phoneCode;
  final Country? selectedCountry;
  final bool isFormValid;
  final ValidationErrorType? validationError;

  const LoginIdle({
    this.phoneNumber = '',
    this.password = '',
    this.selectedCountryCode = 'eg',
    this.phoneCode = '20',
    this.selectedCountry,
    this.isFormValid = false,
    this.validationError,
  });

  LoginIdle copyWith({
    String? phoneNumber,
    String? password,
    Country? selectedCountry,
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
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isFormValid: isFormValid ?? this.isFormValid,
      validationError: clearValidationError ? null : (validationError ?? this.validationError),
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        password,
        selectedCountry,
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
