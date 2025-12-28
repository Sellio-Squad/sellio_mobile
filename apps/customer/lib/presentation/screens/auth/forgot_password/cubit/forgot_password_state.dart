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
  final ValidationErrorType? validationError;

  const ForgotPasswordIdle({
    this.phoneNumber = '',
    this.selectedCountry,
    this.isFormValid = false,
    this.validationError,
  });

  ForgotPasswordIdle copyWith({
    String? phoneNumber,
    Country? selectedCountry,
    bool? isFormValid,
    ValidationErrorType? validationError,
    bool clearValidationError = false,
  }) {
    return ForgotPasswordIdle(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isFormValid: isFormValid ?? this.isFormValid,
      validationError: clearValidationError ? null : (validationError ?? this.validationError),
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        selectedCountry,
        isFormValid,
        validationError,
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

  const ForgotPasswordVerified({
    this.newPassword = '',
    this.confirmPassword = '',
    this.isResetFormValid = false,
  });

  ForgotPasswordVerified copyWith({
    String? newPassword,
    String? confirmPassword,
    bool? isResetFormValid,
  }) {
    return ForgotPasswordVerified(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isResetFormValid: isResetFormValid ?? this.isResetFormValid,
    );
  }

  @override
  List<Object> get props => [newPassword, confirmPassword, isResetFormValid];
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
