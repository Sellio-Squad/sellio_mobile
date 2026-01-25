import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/country_repository.dart';

import '../../../../../domain/repositories/auth_repository.dart';
import '../../shared/enums/form_field_type.dart';
import '../../shared/validators/form_validators.dart';
import 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthRepository _authRepository;
  final CountryRepository _countryRepository;

  RegistrationCubit({
    required AuthRepository authRepository,
    required CountryRepository countryRepository,
  })  : _authRepository = authRepository,
        _countryRepository = countryRepository,
        super(const RegistrationIdle());

  Future<void> loadInitialCountry() async {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final countryCode = await _countryRepository.getCurrentCountryCode();

    emit(currentState.copyWith(selectedCountryCode: countryCode));
  }

  void updateFullName(String value) {
    _updateField((state) => state.copyWith(
          fullName: value,
          clearValidationError: true,
        ));
  }

  void updatePhoneNumber(String value) {
    _updateField((state) => state.copyWith(
          phoneNumber: value,
          clearValidationError: true,
        ));
  }

  void updateCity(String value) {
    _updateField((state) => state.copyWith(
          city: value,
          clearValidationError: true,
        ));
  }

  void updatePassword(String value) {
    _updateField((state) => state.copyWith(
          password: value,
          clearValidationError: true,
        ));
  }

  void updateConfirmPassword(String value) {
    _updateField((state) => state.copyWith(
          confirmPassword: value,
          clearValidationError: true,
        ));
  }

  void updateSelectedCountryCode(
    String country,
    String phoneCode,
    String countryName,
  ) {
    _updateField((state) => state.copyWith(
          selectedCountryCode: country,
          phoneCode: phoneCode,
          countryName: countryName,
        ));
  }

  void _updateField(RegistrationIdle Function(RegistrationIdle) updater) {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final newState = updater(currentState);
    emit(newState.copyWith(isFormValid: _isFormValid(newState)));
  }

  void validateFieldOnFocusChange(FormFieldType fieldType, String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = FormValidators.validateField(
      fieldType,
      value,
      password: currentState.password,
    );

    if (!result.isValid && result.errorType != null) {
      emit(currentState.copyWith(validationError: result.errorType));
    }
  }

  void clearValidationError() {
    final currentState = state;
    if (currentState is RegistrationIdle) {
      emit(currentState.copyWith(clearValidationError: true));
    }
  }

  bool _isFormValid(RegistrationIdle state) {
    return FormValidators.isRegistrationFormValid(
      fullName: state.fullName,
      phone: state.phoneNumber,
      city: state.city,
      password: state.password,
      confirmPassword: state.confirmPassword,
    );
  }

  Future<void> register() async {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final validationError = FormValidators.validateRegistrationFields(
      fullName: currentState.fullName,
      phone: currentState.phoneNumber,
      city: currentState.city,
      password: currentState.password,
      confirmPassword: currentState.confirmPassword,
    );

    if (validationError != null) {
      emit(currentState.copyWith(validationError: validationError));
      return;
    }

    emit(const RegistrationSubmitting());

    final countryCode = currentState.selectedCountryCode;
    final countryName = currentState.countryName;
    final fullPhoneNumber =
        '${currentState.phoneCode}${currentState.phoneNumber}';

    final result = await _authRepository.register(
      fullName: currentState.fullName,
      phoneNumber: fullPhoneNumber,
      password: currentState.password,
      city: currentState.city,
      country: countryName,
      region: countryCode,
    );

    result.fold(
      onSuccess: (_) {
        // Repository stores sessionId internally
        // Emit state to trigger navigation to OTP screen
        emit(RegistrationOtpRequired(phoneNumber: fullPhoneNumber));
      },
      onFailure: (failure) {
        emit(RegistrationFailure(errorMessage: failure.message));
        emit(currentState);
      },
    );
  }

  Future<void> verifyOtp(String otp) async {
    final result = await _authRepository.verifyRegistrationOtp(otp: otp);

    result.fold(
      onSuccess: (_) {
        emit(const RegistrationSuccess());
      },
      onFailure: (failure) {
        throw Exception(failure.message);
      },
    );
  }

  Future<void> resendOtp() async {
    final result = await _authRepository.resendRegistrationOtp();

    result.fold(
      onSuccess: (_) {
        // Success - OTP cubit will handle UI feedback
      },
      onFailure: (failure) {
        throw Exception(failure.message);
      },
    );
  }
}
