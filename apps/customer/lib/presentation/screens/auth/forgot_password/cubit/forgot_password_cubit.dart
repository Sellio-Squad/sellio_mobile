import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/country_repository.dart';
import 'package:sellio_mobile/presentation/screens/auth/shared/extensions.dart';
import '../../../../../domain/repositories/auth_repository.dart';
import '../../shared/enums/validation_error_type.dart';
import '../../shared/validators/form_validators.dart';
import '../../shared/validators/validation_result.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;
  final CountryRepository _countryRepository;
  ForgotPasswordIdle? _lastIdleState;

  ForgotPasswordCubit({
    required AuthRepository authRepository,
    required CountryRepository countryRepository,
    Country? initialCountry,
    bool startWithVerified = false,
  })  : _authRepository = authRepository,
        _countryRepository = countryRepository,
        super(
          startWithVerified
              ? const ForgotPasswordVerified()
              : ForgotPasswordIdle(
                  selectedCountry: initialCountry ?? Country.parse('eg'),
                ),
        );

  void updatePhoneNumber(String value) {
    final currentState = state;
    if (currentState is! ForgotPasswordIdle) return;

    final minPhoneLength = currentState.selectedCountry?.maxPhoneLength;
    final result =
        FormValidators.validatePhone(value, minLength: minPhoneLength);

    emit(currentState.copyWith(
      phoneNumber: value,
      phoneError: () => result.error as PhoneValidationError?,
      isFormValid: value.isNotEmpty && result.error == null,
    ));
  }

  void updateSelectedCountry(Country country) {
    final currentState = state;
    if (currentState is! ForgotPasswordIdle) return;

    final minPhoneLength = country.maxPhoneLength;
    final result = FormValidators.validatePhone(
      currentState.phoneNumber,
      minLength: minPhoneLength,
    );

    emit(currentState.copyWith(
      selectedCountry: country,
      phoneError: () => result.error as PhoneValidationError?,
      isFormValid: currentState.phoneNumber.isNotEmpty && result.error == null,
    ));
  }

  void validatePhoneOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! ForgotPasswordIdle) return;

    final minPhoneLength = currentState.selectedCountry?.maxPhoneLength;
    final result =
        FormValidators.validatePhone(value, minLength: minPhoneLength);

    emit(currentState.copyWith(
      phoneError: () => result.error as PhoneValidationError?,
    ));
  }

  Future<void> sendOtp() async {
    final currentState = state;
    if (currentState is! ForgotPasswordIdle) return;
    _lastIdleState = currentState;

    if (currentState.phoneNumber.isEmpty) return;

    final minPhoneLength = currentState.selectedCountry?.maxPhoneLength;
    final phoneResult = FormValidators.validatePhone(
      currentState.phoneNumber,
      minLength: minPhoneLength,
    );

    if (!phoneResult.isValid) {
      emit(currentState.copyWith(
        phoneError: () => phoneResult.error as PhoneValidationError?,
      ));

      return;
    }

    emit(const ForgotPasswordSendingOtp());

    final phoneNumber = currentState.phoneNumber;
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
        emit(currentState.copyWith(
          phoneError: () => null,
        ));
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

  // ==================== Password Reset Step ====================

  void updateNewPassword(String value) {
    final currentState = state;
    if (currentState is! ForgotPasswordVerified) return;

    final result = FormValidators.validatePassword(value);

    ValidationResult confirmResult = const ValidationResult.valid();
    if (currentState.confirmPassword.isNotEmpty) {
      confirmResult = FormValidators.validateConfirmPassword(
        value,
        currentState.confirmPassword,
      );
    }

    emit(currentState.copyWith(
      newPassword: value,
      passwordError: () => result.error as PasswordValidationError?,
      confirmPasswordError: () =>
          confirmResult.error as PasswordValidationError?,
      isResetFormValid: _validateResetForm(
        value,
        currentState.confirmPassword,
        result.error as PasswordValidationError?,
        confirmResult.error as PasswordValidationError?,
      ),
    ));
  }

  void updateConfirmPassword(String value) {
    final currentState = state;
    if (currentState is! ForgotPasswordVerified) return;

    final result = FormValidators.validateConfirmPassword(
      currentState.newPassword,
      value,
    );

    emit(currentState.copyWith(
      confirmPassword: value,
      confirmPasswordError: () => result.error as PasswordValidationError?,
      isResetFormValid: _validateResetForm(
        currentState.newPassword,
        value,
        currentState.passwordError,
        result.error as PasswordValidationError?,
      ),
    ));
  }

  bool _validateResetForm(
    String password,
    String confirm,
    PasswordValidationError? passwordError,
    PasswordValidationError? confirmPasswordError,
  ) {
    return password.isNotEmpty &&
        confirm.isNotEmpty &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  void validateNewPasswordOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! ForgotPasswordVerified) return;

    final result = FormValidators.validatePassword(value);

    emit(currentState.copyWith(
      passwordError: () => result.error as PasswordValidationError?,
    ));
  }

  void validateConfirmPasswordOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! ForgotPasswordVerified) return;

    final result = FormValidators.validateConfirmPassword(
      currentState.newPassword,
      value,
    );

    emit(currentState.copyWith(
      confirmPasswordError: () => result.error as PasswordValidationError?,
    ));
  }

  Future<void> resetPassword() async {
    final currentState = state;
    if (currentState is! ForgotPasswordVerified) return;

    final newPassword = currentState.newPassword;
    final confirmPassword = currentState.confirmPassword;

    final passwordResult = FormValidators.validatePassword(newPassword);
    final confirmResult = FormValidators.validateConfirmPassword(
      newPassword,
      confirmPassword,
    );

    if (!passwordResult.isValid || !confirmResult.isValid) {
      emit(currentState.copyWith(
        passwordError: () => passwordResult.error as PasswordValidationError?,
        confirmPasswordError: () =>
            confirmResult.error as PasswordValidationError?,
      ));

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
        emit(currentState.copyWith(
          passwordError: () => null,
          confirmPasswordError: () => null,
        ));
      },
    );
  }

  void resetToIdle() {
    if (state is ForgotPasswordIdle) return;

    if (_lastIdleState != null) {
      emit(_lastIdleState!);
    }
  }

  Future<void> loadInitialCountry() async {
    final currentState = state;
    if (currentState is! ForgotPasswordIdle) return;

    final countryCode = await _countryRepository.getCurrentCountryCode();
    final countryObject = Country.parse(countryCode);

    emit(currentState.copyWith(selectedCountry: countryObject));
  }
}
