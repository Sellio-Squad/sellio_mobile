import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

import '../../shared/enums/validation_error_type.dart';

sealed class LoginState extends Equatable {
  final String selectedCountryCode;
  final Country? selectedCountry;

  const LoginState({
    this.selectedCountryCode = 'eg',
    this.selectedCountry,
  });

  @override
  List<Object?> get props => [selectedCountryCode, selectedCountry];
}

class LoginIdle extends LoginState {
  final String phoneNumber;
  final String password;
  final String phoneCode;
  final bool isFormValid;
  final ValidationErrorType? validationError;

  const LoginIdle({
    this.phoneNumber = '',
    this.password = '',
    super.selectedCountryCode,
    this.phoneCode = '20',
    super.selectedCountry,
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
      validationError: clearValidationError
          ? null
          : (validationError ?? this.validationError),
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        phoneNumber,
        password,
        phoneCode,
        isFormValid,
        validationError,
      ];
}

class LoginSubmitting extends LoginState {
  const LoginSubmitting({
    required super.selectedCountryCode,
    super.selectedCountry,
  });

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
    required super.selectedCountryCode,
    super.selectedCountry,
  });

  @override
  List<Object?> get props => [...super.props,errorMessage];
}
