import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../country.dart';
import 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(const LoginFormInitial()) {
    final defaultCountry = mockCountries.firstWhere((c) => c.code == '+964');
    emit(LoginFormChanged(selectedCountry: defaultCountry));
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

  void validateFieldOnFocusChange(String fieldType, String value) {
    if (value.isEmpty) return;
    if (state is! LoginFormChanged) return;

    String? error;
    switch (fieldType) {
      case 'phone':
        error = _validatePhoneNumber(value);
        break;
      case 'password':
        error = _validatePassword(value);
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

  Future<void> submitForm() async {
    if (state is! LoginFormChanged) return;
    final currentState = state as LoginFormChanged;
    if (!_validateAllFieldsForSubmission(currentState)) {
      return;
    }

    emit(currentState.copyWith(isLoading: true));

    try {
      await Future.delayed(const Duration(seconds: 2));
      final phoneNumber =
          '${currentState.selectedCountry.code}${currentState.phoneNumber}';
      emit(LoginFormSuccess(phoneNumber: phoneNumber));
    } catch (e) {
      emit(const LoginFormError(message: 'Login failed. Please try again.'));
      emit(currentState.copyWith(isLoading: false));
    }
  }

  bool _validateAllFieldsForSubmission(LoginFormChanged state) {
    final phoneError = _validatePhoneNumber(state.phoneNumber);
    if (phoneError != null) {
      emit(state.copyWith(currentFieldError: phoneError));
      return false;
    }

    final passwordError = _validatePassword(state.password);
    if (passwordError != null) {
      emit(state.copyWith(currentFieldError: passwordError));
      return false;
    }

    return true;
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

  String? _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}
