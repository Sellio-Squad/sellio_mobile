import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/countries.dart' as intl_countries;
import 'package:country_picker/country_picker.dart';
import 'package:sellio_mobile/domain/repositories/country_repository.dart';

import '../../../../../domain/repositories/auth_repository.dart';
import '../../shared/enums/form_field_type.dart';
import '../../shared/validators/form_validators.dart';
import 'registration_state.dart';

/// Cubit for handling registration operations.
///
/// This cubit is focused solely on registration functionality, following the
/// Single Responsibility Principle.
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

    emit(currentState.copyWith(
      selectedCountryCode: countryCode,
      selectedCountry: Country.parse(countryCode),
    ));
  }

  // ==================== Field Updates ====================

  void updateFirstName(String value) {
    _updateField((state) => state.copyWith(
          firstName: value,
          clearValidationError: true,
        ));
  }

  void updateLastName(String value) {
    _updateField((state) => state.copyWith(
          lastName: value,
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

  void updateSelectedCountryCode(String country) {
    _updateField((state) => state.copyWith(
          selectedCountryCode: country,
          selectedCountry: Country.parse(country),
        ));
  }

  void _updateField(RegistrationIdle Function(RegistrationIdle) updater) {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final newState = updater(currentState);
    emit(newState.copyWith(isFormValid: _isFormValid(newState)));
  }

  // ==================== Validation ====================

  int? _getRequiredPhoneLength(RegistrationIdle state) {
    if (state.selectedCountryCode.isEmpty) return null;
    try {
      final countryData = intl_countries.countries.firstWhere(
        (c) => c.code.toUpperCase() == state.selectedCountryCode.toUpperCase(),
      );
      return countryData.maxLength;
    } catch (e) {
      log("Country not found for code: ${state.selectedCountryCode}");
      return 10;
    }
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
    final requiredLength = _getRequiredPhoneLength(state);
    return FormValidators.isRegistrationFormValid(
      firstName: state.firstName,
      lastName: state.lastName,
      phone: state.phoneNumber,
      city: state.city,
      password: state.password,
      confirmPassword: state.confirmPassword,
      minPhoneLength: requiredLength,
    );
  }

  // ==================== Registration Operations ====================

  /// Performs registration operation
  /// On success, emits RegistrationOtpRequired state which triggers navigation to OTP screen
  Future<void> register() async {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final validationError = FormValidators.validateRegistrationFields(
      firstName: currentState.firstName,
      lastName: currentState.lastName,
      phone: currentState.phoneNumber,
      city: currentState.city,
      password: currentState.password,
      confirmPassword: currentState.confirmPassword,
    );

    if (validationError != null) {
      emit(currentState.copyWith(validationError: validationError));
      return;
    }

    emit(RegistrationSubmitting(
      selectedCountryCode: currentState.selectedCountryCode,
      selectedCountry: currentState.selectedCountry,
    ));

    final countryCode = currentState.selectedCountryCode;
    final fullPhoneNumber =
        '${currentState.phoneCode}${currentState.phoneNumber}';

    final result = await _authRepository.register(
      firstName: currentState.firstName,
      lastName: currentState.lastName,
      phoneNumber: fullPhoneNumber,
      password: currentState.password,
      city: currentState.city,
      country: countryCode,
      region: countryCode,
    );

    result.fold(
      onSuccess: (_) {
        // Repository stores sessionId internally
        // Emit state to trigger navigation to OTP screen
        emit(RegistrationOtpRequired(
          phoneNumber: fullPhoneNumber,
          selectedCountryCode: currentState.selectedCountryCode,
          selectedCountry: currentState.selectedCountry,
        ));
      },
      onFailure: (failure) {
        emit(RegistrationFailure(
          errorMessage: failure.message,
          selectedCountryCode: currentState.selectedCountryCode,
          selectedCountry: currentState.selectedCountry,
        ));
        emit(currentState);
      },
    );
  }

  /// Verifies OTP - called by OTP screen via callback
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

  /// Resends OTP - called by OTP screen via callback
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
