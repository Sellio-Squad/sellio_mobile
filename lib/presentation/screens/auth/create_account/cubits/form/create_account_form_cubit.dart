import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/app_localizations.dart';
import 'package:sellio_mobile/core/validation/auth_validators.dart';
import 'package:sellio_mobile/domain/entities/country.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import 'package:sellio_mobile/domain/services/country_service.dart';

import 'create_account_form_state.dart';

enum CreateAccountFieldType {
  phone,
  name,
  country,
  city,
  password,
  confirmPassword,
}

class CreateAccountFormCubit extends Cubit<CreateAccountFormState> {
  final AuthRepository _authRepository;
  final CountryService _countryService;

  CreateAccountFormCubit({
    required AuthRepository authRepository,
    required CountryService countryService,
  })  : _authRepository = authRepository,
        _countryService = countryService,
        super(const CreateAccountFormInitial()) {
    _initializeDefaultCountry();
  }

  void _initializeDefaultCountry() {
    final defaultCountry = _countryService.getDefaultCountry();
    if (defaultCountry != null) {
      emit(CreateAccountFormChanged(selectedCountry: defaultCountry));
    }
  }

  void updatePhoneNumber(String phoneNumber) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final newState = currentState.copyWith(
        phoneNumber: phoneNumber,
        clearCurrentFieldError: true,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateFullName(String fullName) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final newState = currentState.copyWith(
        fullName: fullName,
        clearCurrentFieldError: true,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateCountry(String country) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final newState = currentState.copyWith(
        country: country,
        clearCurrentFieldError: true,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateCity(String city) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final newState = currentState.copyWith(
        city: city,
        clearCurrentFieldError: true,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updatePassword(String password) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final newState = currentState.copyWith(
        password: password,
        clearCurrentFieldError: true,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateConfirmPassword(String confirmPassword) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final newState = currentState.copyWith(
        confirmPassword: confirmPassword,
        clearCurrentFieldError: true,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateSelectedCountry(Country country) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final newState = currentState.copyWith(selectedCountry: country);
      emit(_updateFormValidation(newState));
    }
  }

  void updateProfileImage(File? image) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final newState = currentState.copyWith(
        selectedProfileImage: image,
        clearProfileImage: image == null,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void validateFieldOnFocusChange(
    CreateAccountFieldType fieldType,
    String value,
    AppLocalizations localizations,
  ) {
    if (value.isEmpty) return;
    if (state is! CreateAccountFormChanged) return;

    String? error;
    switch (fieldType) {
      case CreateAccountFieldType.phone:
        error = AuthValidators.validatePhone(value, localizations);
        break;
      case CreateAccountFieldType.name:
        error = AuthValidators.validateFullName(value, localizations);
        break;
      case CreateAccountFieldType.country:
        error = AuthValidators.validateCountry(value, localizations);
        break;
      case CreateAccountFieldType.city:
        error = AuthValidators.validateCity(value, localizations);
        break;
      case CreateAccountFieldType.password:
        error = AuthValidators.validatePassword(value, localizations);
        break;
      case CreateAccountFieldType.confirmPassword:
        final currentState = state as CreateAccountFormChanged;
        error = AuthValidators.validateConfirmPassword(
          currentState.password,
          value,
          localizations,
        );
        break;
    }

    if (error != null) {
      final currentState = state as CreateAccountFormChanged;
      emit(currentState.copyWith(currentFieldError: error));
    }
  }

  void clearCurrentFieldError() {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      emit(currentState.copyWith(clearCurrentFieldError: true));
    }
  }

  Future<void> submitForm(AppLocalizations localizations) async {
    if (state is! CreateAccountFormChanged) return;
    final currentState = state as CreateAccountFormChanged;

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
      final result = await _authRepository.register(
        fullName: currentState.fullName,
        phoneNumber: currentState.phoneNumber,
        countryCode: currentState.selectedCountry.code,
        password: currentState.password,
        country: currentState.country,
        city: currentState.city,
        profilePhotoUrl: null, // TODO: Handle image upload
      );

      result.fold(
        onSuccess: (user) {
          final phoneNumber =
              '${currentState.selectedCountry.code}${currentState.phoneNumber}';
          emit(CreateAccountFormSuccess(phoneNumber: phoneNumber));
        },
        onFailure: (error) {
          emit(CreateAccountFormError(
            message: error.message,
          ));
          emit(currentState.copyWith(isLoading: false));
        },
      );
    } catch (e) {
      emit(CreateAccountFormError(
        message: localizations.failed_to_create_account,
      ));
      emit(currentState.copyWith(isLoading: false));
    }
  }

  String? _validateAllFieldsForSubmission(
    CreateAccountFormChanged state,
    AppLocalizations localizations,
  ) {
    final phoneError = AuthValidators.validatePhone(
      state.phoneNumber,
      localizations,
    );
    if (phoneError != null) return phoneError;

    final nameError = AuthValidators.validateFullName(
      state.fullName,
      localizations,
    );
    if (nameError != null) return nameError;

    final countryError = AuthValidators.validateCountry(
      state.country,
      localizations,
    );
    if (countryError != null) return countryError;

    final cityError = AuthValidators.validateCity(
      state.city,
      localizations,
    );
    if (cityError != null) return cityError;

    final passwordError = AuthValidators.validatePassword(
      state.password,
      localizations,
    );
    if (passwordError != null) return passwordError;

    final confirmPasswordError = AuthValidators.validateConfirmPassword(
      state.password,
      state.confirmPassword,
      localizations,
    );
    if (confirmPasswordError != null) return confirmPasswordError;

    return null;
  }

  CreateAccountFormChanged _updateFormValidation(
      CreateAccountFormChanged state) {
    final isValid = _isFormValid(state);
    return state.copyWith(isFormValid: isValid);
  }

  bool _isFormValid(CreateAccountFormChanged state) {
    return state.phoneNumber.isNotEmpty &&
        state.fullName.isNotEmpty &&
        state.country.isNotEmpty &&
        state.city.isNotEmpty &&
        state.password.isNotEmpty &&
        state.confirmPassword.isNotEmpty &&
        state.phoneNumber.length >= 10 &&
        state.fullName.length >= 2 &&
        state.country.length >= 2 &&
        state.city.length >= 2 &&
        state.password.length >= 6 &&
        state.password == state.confirmPassword;
  }
}
