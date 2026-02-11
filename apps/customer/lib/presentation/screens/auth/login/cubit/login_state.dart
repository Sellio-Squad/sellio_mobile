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
  final PhoneValidationError? phoneError;
  final PasswordValidationError? passwordError;
  final Country selectedCountry;

  const LoginIdle({
    this.phoneNumber = '',
    this.password = '',
    this.phoneCode = '20',
    required this.selectedCountry,
    this.isFormValid = false,
    this.passwordError,
    this.phoneError,
  });

  LoginIdle copyWith({
    String? phoneNumber,
    String? password,
    Country? selectedCountry,
    String? phoneCode,
    bool? isFormValid,
    PhoneValidationError? Function()? phoneError,
    PasswordValidationError? Function()? passwordError,
  }) {
    return LoginIdle(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      phoneCode: phoneCode ?? this.phoneCode,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isFormValid: isFormValid ?? this.isFormValid,
      phoneError: phoneError != null ? phoneError() : this.phoneError,
      passwordError:
          passwordError != null ? passwordError() : this.passwordError,
    );
  }

  @override
  List<Object?> get props => [
        selectedCountry,
        phoneNumber,
        password,
        phoneCode,
        isFormValid,
        phoneError,
        passwordError,
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
