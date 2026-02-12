import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

import '../../shared/enums/validation_error_type.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordIdle extends ForgotPasswordState {
  final String phoneNumber;
  final Country? selectedCountry;
  final bool isFormValid;
  final PhoneValidationError? phoneError;

  const ForgotPasswordIdle({
    this.phoneNumber = '',
    this.selectedCountry,
    this.isFormValid = false,
    this.phoneError,
  });

  ForgotPasswordIdle copyWith({
    String? phoneNumber,
    Country? selectedCountry,
    bool? isFormValid,
    PhoneValidationError? Function()? phoneError,
  }) {
    return ForgotPasswordIdle(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isFormValid: isFormValid ?? this.isFormValid,
      phoneError: phoneError != null ? phoneError() : this.phoneError,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        selectedCountry,
        isFormValid,
        phoneError,
      ];
}

class ForgotPasswordSendingOtp extends ForgotPasswordState {
  const ForgotPasswordSendingOtp();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordOtpRequired extends ForgotPasswordState {
  final String phoneNumber;
  final String defaultRegion;

  const ForgotPasswordOtpRequired({
    required this.phoneNumber,
    required this.defaultRegion,
  });

  @override
  List<Object> get props => [phoneNumber, defaultRegion];
}

class ForgotPasswordVerified extends ForgotPasswordState {
  final String newPassword;
  final String confirmPassword;
  final bool isResetFormValid;
  final PasswordValidationError? passwordError;
  final PasswordValidationError? confirmPasswordError;

  const ForgotPasswordVerified({
    this.newPassword = '',
    this.confirmPassword = '',
    this.isResetFormValid = false,
    this.passwordError,
    this.confirmPasswordError,
  });

  ForgotPasswordVerified copyWith({
    String? newPassword,
    String? confirmPassword,
    bool? isResetFormValid,
    PasswordValidationError? Function()? passwordError,
    PasswordValidationError? Function()? confirmPasswordError,
  }) {
    return ForgotPasswordVerified(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isResetFormValid: isResetFormValid ?? this.isResetFormValid,
      passwordError: passwordError != null ? passwordError() : this.passwordError,
      confirmPasswordError: confirmPasswordError != null ? confirmPasswordError() : this.confirmPasswordError,
    );
  }


  @override
  List<Object?> get props => [
    newPassword,
    confirmPassword,
    isResetFormValid,
    passwordError,
    confirmPasswordError,
  ];
}

class ForgotPasswordResetting extends ForgotPasswordState {
  const ForgotPasswordResetting();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordSuccess();

  @override
  List<Object> get props => [];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String? errorMessage;

  const ForgotPasswordFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
