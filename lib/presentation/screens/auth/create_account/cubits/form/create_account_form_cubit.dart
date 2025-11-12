import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../country.dart';
import 'create_account_form_state.dart';

class CreateAccountFormCubit extends Cubit<CreateAccountFormState> {
  CreateAccountFormCubit() : super(CreateAccountFormInitial()) {
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

  void validateFieldOnFocusChange(String fieldType, String value) {
    if (value.isEmpty) return;
    if (state is! CreateAccountFormChanged) return;

    String? error;
    switch (fieldType) {
      case 'phone':
        error = _validatePhoneNumber(value);
        break;
      case 'name':
        error = _validateFullName(value);
        break;
      case 'country':
        error = _validateCountry(value);
        break;
      case 'city':
        error = _validateCity(value);
        break;
      case 'password':
        error = _validatePassword(value);
        break;
      case 'confirmPassword':
        final currentState = state as CreateAccountFormChanged;
        error = _validateConfirmPassword(currentState.password, value);
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

  Future<void> submitForm() async {
    if (state is! CreateAccountFormChanged) return;
    final currentState = state as CreateAccountFormChanged;
    if (!_validateAllFieldsForSubmission(currentState)) {
      return;
    }

    emit(currentState.copyWith(isLoading: true));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final phoneNumber =
          '${currentState.selectedCountry.code}${currentState.phoneNumber}';
      emit(CreateAccountFormSuccess(phoneNumber: phoneNumber));
    } catch (e) {
      emit(CreateAccountFormError(
          message: 'Failed to create account. Please try again.'));
      emit(currentState.copyWith(isLoading: false));
    }
  }

  bool _validateAllFieldsForSubmission(CreateAccountFormChanged state) {
    final phoneError = _validatePhoneNumber(state.phoneNumber);
    if (phoneError != null) {
      emit(state.copyWith(currentFieldError: phoneError));
      return false;
    }

    final nameError = _validateFullName(state.fullName);
    if (nameError != null) {
      emit(state.copyWith(currentFieldError: nameError));
      return false;
    }

    final countryError = _validateCountry(state.country);
    if (countryError != null) {
      emit(state.copyWith(currentFieldError: countryError));
      return false;
    }

    final cityError = _validateCity(state.city);
    if (cityError != null) {
      emit(state.copyWith(currentFieldError: cityError));
      return false;
    }

    final passwordError = _validatePassword(state.password);
    if (passwordError != null) {
      // Update the form state to include the current field error
      emit(state.copyWith(currentFieldError: passwordError));
      return false;
    }

    final confirmPasswordError =
        _validateConfirmPassword(state.password, state.confirmPassword);
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

  String? _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  String? _validateFullName(String fullName) {
    if (fullName.length < 2) return 'Full name must be at least 2 characters';
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(fullName)) {
      return 'Full name must contain only letters and spaces';
    }
    return null;
  }

  String? _validateCountry(String country) {
    if (country.length < 2) return 'Country must be at least 2 characters';
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(country)) {
      return 'Country must contain only letters and spaces';
    }
    return null;
  }

  String? _validateCity(String city) {
    if (city.length < 2) return 'City must be at least 2 characters';
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(city)) {
      return 'City must contain only letters and spaces';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.length < 6) return 'Password must be at least 6 characters';
    if (password.length > 20) return 'Password must be less than 20 characters';
    return null;
  }

  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) return 'Passwords do not match';
    return null;
  }
}
