import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/auth_repository.dart';
import 'package:flutter_intl_phone_field/countries.dart' as intl_countries;
import 'package:sellio_mobile/domain/repositories/country_repository.dart';
import '../../shared/enums/form_field_type.dart';
import '../../shared/validators/form_validators.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final CountryRepository _countryRepository;

  LoginCubit({
    required AuthRepository authRepository,
    required CountryRepository countryRepository,
    Country? initialCountry,
  })  : _authRepository = authRepository,
        _countryRepository = countryRepository,
        super(LoginIdle(selectedCountry: initialCountry));

  Future<void> loadInitialCountry() async {
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final countryCode = await _countryRepository.getCurrentCountryCode();

    emit(currentState.copyWith(selectedCountryCode: countryCode));
  }

  void updatePhoneNumber(String value) {
    _updateField((state) => state.copyWith(
          phoneNumber: value,
          clearValidationError: true,
        ));
  }

  void updatePassword(String value) {
    _updateField((state) => state.copyWith(
          password: value,
          clearValidationError: true,
        ));
  }

  void updateSelectedCountry(Country country) {
    _updateField((state) => state.copyWith(selectedCountry: country));
  }

  void updateSelectedCountryCode(String countryCode) {
    _updateField(
      (state) => state.copyWith(
        selectedCountryCode: countryCode,
        selectedCountry: Country.parse(countryCode),
      ),
    );
  }

  // void updateSelectedCountryCode(String countryCode, String phoneCode) {
  //   _updateField((state) =>
  //       state.copyWith(selectedCountryCode: countryCode, phoneCode: phoneCode));
  // }

  void _updateField(LoginIdle Function(LoginIdle) updater) {
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final newState = updater(currentState);
    emit(newState.copyWith(isFormValid: _isFormValid(newState)));
  }

  void validateFieldOnFocusChange(FormFieldType fieldType, String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final result = FormValidators.validateField(fieldType, value);
    final int minPhoneLength = currentState.selectedCountry != null
        ? intl_countries.countries
            .firstWhere((c) => c.code == currentState.selectedCountryCode)
            .maxLength
        : 0;

    FormValidators.validateField(
      fieldType,
      value,
      minPhoneLength: minPhoneLength,
    );

    if (!result.isValid && result.errorType != null) {
      emit(currentState.copyWith(validationError: result.errorType));
    }
  }

  void clearValidationError() {
    final currentState = state;
    if (currentState is LoginIdle) {
      emit(currentState.copyWith(clearValidationError: true));
    }
  }

  bool _isFormValid(LoginIdle state) {
    final requiredLength = _getRequiredPhoneLength(state);
    final bool isValid = FormValidators.isLoginFormValid(
      phone: state.phoneNumber,
      password: state.password,
      minPhoneLength: requiredLength,
    );
    log("requiredLength $requiredLength");
    log('isValid $isValid');
    return isValid;
  }

  int? _getRequiredPhoneLength(LoginIdle state) {
    if (state.selectedCountryCode.isEmpty) return null;

    final countryData = intl_countries.countries.firstWhere(
      (c) => c.code.toUpperCase() == state.selectedCountryCode.toUpperCase(),
    );
    log("Country not found for code: ${state.selectedCountryCode}");
    return countryData.maxLength;
  }

  Future<void> loginAsGuest() async {
    final currentState = state;
    emit(LoginSubmitting(
      selectedCountryCode: state.selectedCountryCode,
      selectedCountry: state.selectedCountry,
    ));

    final result = await _authRepository.loginAsGuest();

    result.fold(
      onSuccess: (_) {
        emit(const LoginSuccess());
      },
      onFailure: (failure) {
        emit(LoginFailure(
          errorMessage: failure.message,
          selectedCountryCode: state.selectedCountryCode,
          selectedCountry: state.selectedCountry,
        ));

        final currentState = state;
        if (currentState is LoginIdle) {
          emit(currentState);
        } else {
          emit(LoginIdle(
            selectedCountryCode: state.selectedCountryCode,
            selectedCountry: state.selectedCountry,
          ));
        }
      },
    );
  }

  Future<void> login() async {
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final validationError = FormValidators.validateLoginFields(
      phone: currentState.phoneNumber,
      password: currentState.password,
    );

    if (validationError != null) {
      emit(currentState.copyWith(validationError: validationError));
      return;
    }
    emit(LoginSubmitting(
      selectedCountryCode: currentState.selectedCountryCode,
      selectedCountry: currentState.selectedCountry,
    ));

    // emit(const LoginSubmitting());

    //   final countryCode = currentState.phoneCode;

    final countryCode = currentState.selectedCountry?.phoneCode ?? '';
    final phoneNumber = '+$countryCode${currentState.phoneNumber}';

    final result = await _authRepository.login(
      phoneNumber: phoneNumber,
      password: currentState.password,
    );

    result.fold(
      onSuccess: (_) {
        emit(const LoginSuccess());
      },
      onFailure: (failure) {
        emit(LoginFailure(
          selectedCountryCode: state.selectedCountryCode,
          selectedCountry: state.selectedCountry,
          errorMessage: failure.message,
        ));
        emit(currentState);
      },
    );
  }
}
