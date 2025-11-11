import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../country.dart';
import 'create_account_form_state.dart';

class CreateAccountFormCubit extends Cubit<CreateAccountFormState> {
  CreateAccountFormCubit() : super(const CreateAccountFormInitial()) {
    final defaultCountry = mockCountries.firstWhere((c) => c.code == '+964');
    emit(CreateAccountFormChanged(selectedCountry: defaultCountry));
  }

  void updatePhoneNumber(String phoneNumber) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final phoneError = _validatePhoneNumber(phoneNumber);
      final newState = currentState.copyWith(
        phoneNumber: phoneNumber,
        phoneError: phoneError,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateFullName(String fullName) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final nameError = _validateFullName(fullName);
      final newState = currentState.copyWith(
        fullName: fullName,
        nameError: nameError,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateCountry(String country) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final countryError = _validateCountry(country);
      final newState = currentState.copyWith(
        country: country,
        countryError: countryError,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateCity(String city) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final cityError = _validateCity(city);
      final newState = currentState.copyWith(
        city: city,
        cityError: cityError,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updatePassword(String password) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final passwordError = _validatePassword(password);
      final confirmPasswordError = _validateConfirmPassword(
        password,
        currentState.confirmPassword,
      );
      final newState = currentState.copyWith(
        password: password,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      );
      emit(_updateFormValidation(newState));
    }
  }

  void updateConfirmPassword(String confirmPassword) {
    if (state is CreateAccountFormChanged) {
      final currentState = state as CreateAccountFormChanged;
      final confirmPasswordError = _validateConfirmPassword(
        currentState.password,
        confirmPassword,
      );
      final newState = currentState.copyWith(
        confirmPassword: confirmPassword,
        confirmPasswordError: confirmPasswordError,
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

  Future<void> submitForm() async {
    if (state is! CreateAccountFormChanged) return;

    final currentState = state as CreateAccountFormChanged;
    if (!currentState.isFormValid) return;

    emit(currentState.copyWith(isLoading: true));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final phoneNumber = '${currentState.selectedCountry.code}${currentState
          .phoneNumber}';
      emit(CreateAccountFormSuccess(phoneNumber: phoneNumber));
    } catch (e) {
      emit(CreateAccountFormError(message: e.toString()));
      emit(currentState.copyWith(isLoading: false));
    }
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
        state.phoneError == null &&
        state.nameError == null &&
        state.countryError == null &&
        state.cityError == null &&
        state.passwordError == null &&
        state.confirmPasswordError == null;
  }

  String? _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return null;
    if (phoneNumber.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    return null;
  }

  String? _validateFullName(String fullName) {
    if (fullName.isEmpty) return null;
    if (fullName.length < 2) return 'Full name must be at least 2 characters';
    return null;
  }

  String? _validateCountry(String country) {
    if (country.isEmpty) return null;
    if (country.length < 2) return 'Country must be at least 2 characters';
    return null;
  }

  String? _validateCity(String city) {
    if (city.isEmpty) return null;
    if (city.length < 2) return 'City must be at least 2 characters';
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return null;
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return null;
    if (password != confirmPassword) return 'Passwords do not match';
    return null;
  }
}