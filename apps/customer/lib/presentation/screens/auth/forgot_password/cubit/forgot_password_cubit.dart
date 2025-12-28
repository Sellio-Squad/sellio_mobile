import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/auth_repository.dart';
import '../../shared/enums/form_field_type.dart';
import '../../shared/validators/form_validators.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit({
    required AuthRepository authRepository,
    Country? initialCountry,
    bool startWithVerified = false,
  })  : _authRepository = authRepository,
        super(
          startWithVerified
              ? const ForgotPasswordVerified()
              : ForgotPasswordIdle(selectedCountry: initialCountry),
        );

  void updatePhoneNumber(String value) {
    _updateField((state) => state.copyWith(
          phoneNumber: value,
          clearValidationError: true,
        ));
  }

  void updateSelectedCountry(Country country) {
    _updateField((state) => state.copyWith(selectedCountry: country));
  }

  void _updateField(ForgotPasswordIdle Function(ForgotPasswordIdle) updater) {
    final currentState = state;
    if (currentState is! ForgotPasswordIdle) return;

    final newState = updater(currentState);
    emit(newState.copyWith(isFormValid: newState.phoneNumber.isNotEmpty));
  }

  void updateNewPassword(String value) {
    final currentState = state;
    if (currentState is! ForgotPasswordVerified) return;
    
    final newState = currentState.copyWith(newPassword: value);
    emit(newState.copyWith(
      isResetFormValid: _validateResetForm(newState.newPassword, newState.confirmPassword),
    ));
  }

  void updateConfirmPassword(String value) {
    final currentState = state;
    if (currentState is! ForgotPasswordVerified) return;

    final newState = currentState.copyWith(confirmPassword: value);
    emit(newState.copyWith(
      isResetFormValid: _validateResetForm(newState.newPassword, newState.confirmPassword),
    ));
  }

  bool _validateResetForm(String password, String confirm) {
    if (password.isEmpty || confirm.isEmpty) return false;
    
    final passwordValid = FormValidators.validatePassword(password).isValid;
    final confirmValid = FormValidators.validateConfirmPassword(password, confirm).isValid;
    
    return passwordValid && confirmValid;
  }

  void validateFieldOnFocusChange(FormFieldType fieldType, String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! ForgotPasswordIdle) return;

    final result = FormValidators.validateField(fieldType, value);

    if (!result.isValid && result.errorType != null) {
      emit(currentState.copyWith(validationError: result.errorType));
    }
  }

  void clearValidationError() {
    final currentState = state;
    if (currentState is ForgotPasswordIdle) {
      emit(currentState.copyWith(clearValidationError: true));
    }
  }


  Future<void> sendOtp() async {
    final currentState = state;
    if (currentState is! ForgotPasswordIdle) return;

    if (currentState.phoneNumber.isEmpty) return;

    emit(const ForgotPasswordSendingOtp());

    final countryCode = currentState.selectedCountry?.phoneCode;
    final phoneNumber = '$countryCode${currentState.phoneNumber}';
    final region = currentState.selectedCountry?.countryCode ?? '';

    final result = await _authRepository.sendForgotPasswordOtp(
      phoneNumber: phoneNumber,
      defaultRegion: region,
    );

    result.fold(
      onSuccess: (_) {
        emit(ForgotPasswordOtpRequired(
          phoneNumber: phoneNumber,
          defaultRegion: region,
        ));
      },
      onFailure: (failure) {
        emit(ForgotPasswordFailure(errorMessage: failure.message));
        emit(currentState);
      },
    );
  }

  Future<void> verifyOtp(String otp) async {
    final result = await _authRepository.verifyForgotPasswordOtp(otp: otp);
    
    result.fold(
      onSuccess: (_) {
        emit(const ForgotPasswordVerified());
      },
      onFailure: (failure) {
        throw Exception(failure.message);
      },
    );
  }

  Future<void> resendOtp() async {
    final currentPhoneState = state;
    String? phoneNumber;
    String? defaultRegion;
    
    if (currentPhoneState is ForgotPasswordOtpRequired) {
      phoneNumber = currentPhoneState.phoneNumber;
      defaultRegion = currentPhoneState.defaultRegion;
    }
    
    if (phoneNumber == null || defaultRegion == null) {
      throw Exception('Phone number or region not available for resend');
    }
    
    final result = await _authRepository.sendForgotPasswordOtp(
      phoneNumber: phoneNumber,
      defaultRegion: defaultRegion,
    );
    
    result.fold(
      onSuccess: (_) {
        // Success - OTP cubit will handle UI feedback
      },
      onFailure: (failure) {
        throw Exception(failure.message);
      },
    );
  }

  Future<void> resetPassword() async {
    final currentState = state;
    if (currentState is! ForgotPasswordVerified) return;

    final newPassword = currentState.newPassword;
    final confirmPassword = currentState.confirmPassword;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      emit(const ForgotPasswordFailure(errorMessage: 'Password fields cannot be empty'));
      return;
    }

    if (newPassword != confirmPassword) {
      emit(const ForgotPasswordFailure(errorMessage: 'Passwords do not match'));
      return;
    }

    emit(const ForgotPasswordResetting());

    final result = await _authRepository.resetPassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    result.fold(
      onSuccess: (_) {
        emit(const ForgotPasswordSuccess());
      },
      onFailure: (failure) {
        emit(ForgotPasswordFailure(errorMessage: failure.message));
        emit(currentState);
      },
    );
  }
}
