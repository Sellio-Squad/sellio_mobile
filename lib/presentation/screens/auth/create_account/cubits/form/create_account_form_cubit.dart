import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import 'package:sellio_mobile/presentation/screens/auth/create_account/FieldType.dart';
import 'package:sellio_mobile/presentation/screens/auth/create_account/utils/validators.dart';

import '../../../country.dart';
import 'create_account_form_state.dart';

class CreateAccountFormCubit extends Cubit<CreateAccountFormState> {
  final AuthRepository _authRepository;

  CreateAccountFormCubit(this._authRepository)
      : super(CreateAccountFormInitial()) {
    final defaultCountry = mockCountries.firstWhere((c) => c.code == '+964');
    emit(CreateAccountFormChanged(selectedCountry: defaultCountry));
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

  void validateFieldOnFocusChange(FieldType fieldType, String value) {
    if (value.isEmpty) return;
    if (state is! CreateAccountFormChanged) return;

    String? error;
    switch (fieldType) {
      case FieldType.phone:
        error = Validators.phoneNumber(value);
        break;
      case FieldType.name:
        error = Validators.fullName(value);
        break;
      case FieldType.country:
        error = Validators.country(value);
        break;
      case FieldType.city:
        error = Validators.city(value);
        break;
      case FieldType.password:
        error = Validators.password(value);
        break;
      case FieldType.confirmPassword:
        final currentState = state as CreateAccountFormChanged;
        error = Validators.confirmPassword(currentState.password, value);
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

  Future<void> createAccount() async {
    if (state is! CreateAccountFormChanged) return;
    final currentState = state as CreateAccountFormChanged;
    if (!_validateAllFieldsForSubmission(currentState)) {
      return;
    }

    emit(currentState.copyWith(isLoading: true));

    try {
      final parts = currentState.fullName.trim().split(' ');
      final firstName = parts.first;
      final lastName = parts.sublist(1).join(' ');

      final result = await _authRepository.createAccount(
          phoneNumber: currentState.phoneNumber,
          firstName: firstName,
          lastName: lastName,
          country: currentState.country,
          city: currentState.city,
          password: currentState.password,
          countryCode: currentState.selectedCountry.code);
      emit(currentState.copyWith(isLoading: false));

      result.fold(onSuccess: (sessionId) {
        final phoneNumber =
            '${currentState.selectedCountry.code}${currentState.phoneNumber}';
        emit(CreateAccountFormSuccess(
            phoneNumber: phoneNumber, sessionId: sessionId));
      }, onFailure: (failure) {
        emit(CreateAccountFormError(message: failure.message));
      });


    } catch (e) {
    emit(CreateAccountFormError(message: e.toString()));
    emit(currentState.copyWith(isLoading: false));
    }
  }

  bool _validateAllFieldsForSubmission(CreateAccountFormChanged state) {
    final phoneError = Validators.phoneNumber(state.phoneNumber);
    if (phoneError != null) {
      emit(state.copyWith(currentFieldError: phoneError));
      return false;
    }

    final nameError = Validators.fullName(state.fullName);
    if (nameError != null) {
      emit(state.copyWith(currentFieldError: nameError));
      return false;
    }

    final countryError = Validators.country(state.country);
    if (countryError != null) {
      emit(state.copyWith(currentFieldError: countryError));
      return false;
    }

    final cityError = Validators.city(state.city);
    if (cityError != null) {
      emit(state.copyWith(currentFieldError: cityError));
      return false;
    }

    final passwordError = Validators.password(state.password);
    if (passwordError != null) {
      // Update the form state to include the current field error
      emit(state.copyWith(currentFieldError: passwordError));
      return false;
    }

    final confirmPasswordError =
    Validators.confirmPassword(state.password, state.confirmPassword);
    if (confirmPasswordError != null) {
      emit(state.copyWith(currentFieldError: confirmPasswordError));
      return false;
    }
    return true;
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
