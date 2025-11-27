import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/app_localizations.dart';
import 'package:sellio_mobile/core/validation/auth_validators.dart';
import 'package:sellio_mobile/domain/entities/country.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import 'package:sellio_mobile/domain/services/country_service.dart';

import 'login_form_state.dart';

enum AuthFieldType {
  phone,
  password,
}

class LoginFormCubit extends Cubit<LoginFormState> {
  final AuthRepository _authRepository;
  final CountryService _countryService;

  LoginFormCubit({
    required AuthRepository authRepository,
    required CountryService countryService,
  })  : _authRepository = authRepository,
        _countryService = countryService,
        super(const LoginFormInitial()) {
    _initializeDefaultCountry();
  }

  void _initializeDefaultCountry() {
    final defaultCountry = _countryService.getDefaultCountry();
    if (defaultCountry != null) {
      emit(LoginFormChanged(selectedCountry: defaultCountry));
    }
  }

  void updatePhoneNumber(String phoneNumber) {
    if (state is LoginFormChanged) {
      final currentState = state as LoginFormChanged;
      final newState = currentState.copyWith(
        phoneNumber: phoneNumber,
        clearCurrentFieldError: true,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updatePassword(String password) {
    if (state is LoginFormChanged) {
      final currentState = state as LoginFormChanged;
      final newState = currentState.copyWith(
        password: password,
        clearCurrentFieldError: true,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateSelectedCountry(Country country) {
    if (state is LoginFormChanged) {
      final currentState = state as LoginFormChanged;
      final newState = currentState.copyWith(selectedCountry: country);
      emit(_updateFormValidation(newState));
    }
  }

  void validateFieldOnFocusChange(
    AuthFieldType fieldType,
    String value,
    AppLocalizations localizations,
  ) {
    if (value.isEmpty) return;
    if (state is! LoginFormChanged) return;

    String? error;
    switch (fieldType) {
      case AuthFieldType.phone:
        error = AuthValidators.validatePhone(value, localizations);
        break;
      case AuthFieldType.password:
        error = AuthValidators.validatePassword(value, localizations);
        break;
    }

    if (error != null) {
      final currentState = state as LoginFormChanged;
      emit(currentState.copyWith(currentFieldError: error));
    }
  }

  void clearCurrentFieldError() {
    if (state is LoginFormChanged) {
      final currentState = state as LoginFormChanged;
      emit(currentState.copyWith(clearCurrentFieldError: true));
    }
  }

  Future<void> submitForm(AppLocalizations localizations) async {
    if (state is! LoginFormChanged) return;
    final currentState = state as LoginFormChanged;
    
    final validationError = _validateAllFieldsForSubmission(
      currentState,
      localizations,
    );
    if (validationError != null) {
      emit(currentState.copyWith(currentFieldError: validationError));
      return;
    }

    emit(currentState.copyWith(isLoading: true));

    try {
      final result = await _authRepository.login(
        phoneNumber: currentState.phoneNumber,
        countryCode: currentState.selectedCountry.code,
        password: currentState.password,
      );

      result.fold(
        onSuccess: (user) {
          final phoneNumber =
              '${currentState.selectedCountry.code}${currentState.phoneNumber}';
          emit(LoginFormSuccess(phoneNumber: phoneNumber));
        },
        onFailure: (error) {
          emit(LoginFormError(
            message: error.message,
          ));
          emit(currentState.copyWith(isLoading: false));
        },
      );
    } catch (e) {
      emit(LoginFormError(message: localizations.login_failed));
      emit(currentState.copyWith(isLoading: false));
    }
  }

  String? _validateAllFieldsForSubmission(
    LoginFormChanged state,
    AppLocalizations localizations,
  ) {
    final phoneError = AuthValidators.validatePhone(
      state.phoneNumber,
      localizations,
    );
    if (phoneError != null) return phoneError;

    final passwordError = AuthValidators.validatePassword(
      state.password,
      localizations,
    );
    if (passwordError != null) return passwordError;

    return null;
  }

  LoginFormChanged _updateFormValidation(LoginFormChanged state) {
    final isValid = _isFormValid(state);
    return state.copyWith(isFormValid: isValid);
  }

  bool _isFormValid(LoginFormChanged state) {
    return state.phoneNumber.isNotEmpty &&
        state.password.isNotEmpty &&
        state.phoneNumber.length >= 10 &&
        state.password.length >= 6;
  }
}
