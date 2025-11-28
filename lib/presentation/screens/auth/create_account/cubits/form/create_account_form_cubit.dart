import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../country.dart';
import 'create_account_form_state.dart';

class CreateAccountFormCubit extends Cubit<CreateAccountFormState> {
  CreateAccountFormCubit() : super(const CreateAccountFormInitial()) {
    final defaultCountry = mockCountries.firstWhere((c) => c.code == '+964');
    emit(CreateAccountFormChanged(selectedCountry: defaultCountry));
  }

  // -------------------- FIELD UPDATING -------------------- //

  void updatePhoneNumber(String value) => _update((s) => s.copyWith(
    phoneNumber: value,
    clearCurrentFieldError: true,
  ));

  void updateFullName(String value) => _update((s) => s.copyWith(
    fullName: value,
    clearCurrentFieldError: true,
  ));

  void updateCountry(String value) => _update((s) => s.copyWith(
    country: value,
    clearCurrentFieldError: true,
  ));

  void updateCity(String value) => _update((s) => s.copyWith(
    city: value,
    clearCurrentFieldError: true,
  ));

  void updatePassword(String value) => _update((s) => s.copyWith(
    password: value,
    clearCurrentFieldError: true,
  ));

  void updateConfirmPassword(String value) => _update((s) => s.copyWith(
    confirmPassword: value,
    clearCurrentFieldError: true,
  ));

  void updateSelectedCountry(Country country) =>
      _update((s) => s.copyWith(selectedCountry: country));

  void updateProfileImage(File? image) => _update((s) => s.copyWith(
    selectedProfileImage: image,
    clearProfileImage: image == null,
  ));

  // Unified update helper
  void _update(CreateAccountFormChanged Function(CreateAccountFormChanged) change) {
    if (state is! CreateAccountFormChanged) return;
    final newState = change(state as CreateAccountFormChanged);
    emit(_applyValidation(newState));
  }

  // -------------------- VALIDATION -------------------- //

  void validateFieldOnFocusChange(String field, String value) {
    if (value.isEmpty || state is! CreateAccountFormChanged) return;
    String? error;

    switch (field) {
      case 'phone': error = _validatePhone(value); break;
      case 'name': error = _validateName(value); break;
      case 'country': error = _validateCountry(value); break;
      case 'city': error = _validateCity(value); break;
      case 'password': error = _validatePassword(value); break;
      case 'confirmPassword':
        final s = state as CreateAccountFormChanged;
        error = _validatePasswordMatch(s.password, value);
        break;
    }

    if (error != null) {
      emit((state as CreateAccountFormChanged)
          .copyWith(currentFieldError: error));
    }
  }

  void clearCurrentFieldError() {
    if (state is CreateAccountFormChanged) {
      emit((state as CreateAccountFormChanged)
          .copyWith(clearCurrentFieldError: true));
    }
  }

  // -------------------- FORM SUBMISSION -------------------- //

  Future<void> submitForm() async {
    if (state is! CreateAccountFormChanged) return;
    final s = state as CreateAccountFormChanged;

    if (!_validateAllSubmitFields(s)) return;

    emit(s.copyWith(isLoading: true));

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(CreateAccountFormSuccess(
        phoneNumber: '${s.selectedCountry.code}${s.phoneNumber}',
        countryCode: s.selectedCountry.code, //<-- REQUIRED & FIXED
      ));
    } catch (_) {
      emit(const CreateAccountFormError(
          message: 'Failed to create account. Please try again.'));
      emit(s.copyWith(isLoading: false));
    }
  }

  bool _validateAllSubmitFields(CreateAccountFormChanged s) {
    final checks = [
      _validatePhone(s.phoneNumber),
      _validateName(s.fullName),
      _validateCountry(s.country),
      _validateCity(s.city),
      _validatePassword(s.password),
      _validatePasswordMatch(s.password, s.confirmPassword),
    ];

    for (final error in checks) {
      if (error != null) {
        emit(s.copyWith(currentFieldError: error));
        return false;
      }
    }
    return true;
  }

  // -------------------- AUTO VALIDATION -------------------- //

  CreateAccountFormChanged _applyValidation(CreateAccountFormChanged s) =>
      s.copyWith(isFormValid: _isValid(s));

  bool _isValid(CreateAccountFormChanged s) =>
      s.phoneNumber.length >= 10 &&
          s.fullName.length >= 2 &&
          s.country.length >= 2 &&
          s.city.length >= 2 &&
          s.password.length >= 6 &&
          s.password == s.confirmPassword;

  // -------------------- INPUT VALIDATORS -------------------- //

  String? _validatePhone(String v) =>
      v.length < 10 ? 'Phone must be at least 10 digits' : null;

  String? _validateName(String v) =>
      v.length < 2 ? 'Name must be at least 2 characters' : null;

  String? _validateCountry(String v) =>
      v.length < 2 ? 'Country must be at least 2 characters' : null;

  String? _validateCity(String v) =>
      v.length < 2 ? 'City must be at least 2 characters' : null;

  String? _validatePassword(String v) =>
      v.length < 6 ? 'Password must be at least 6 characters' : null;

  String? _validatePasswordMatch(String p, String c) =>
      p != c ? 'Passwords do not match' : null;
}
