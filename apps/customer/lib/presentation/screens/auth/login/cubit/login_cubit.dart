import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/repositories/auth_repository.dart';
import '../../shared/enums/form_field_type.dart';
import '../../shared/validators/form_validators.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({
    required AuthRepository authRepository,
    Country? initialCountry,
  })  : _authRepository = authRepository,
        super(LoginIdle(selectedCountry: initialCountry));

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
    return FormValidators.isLoginFormValid(
      phone: state.phoneNumber,
      password: state.password,
    );
  }

  Future<void> loginAsGuest() async {
    emit(const LoginSubmitting());

    final result = await _authRepository.loginAsGuest();

    result.fold(
      onSuccess: (_) {
        emit(const LoginSuccess());
      },
      onFailure: (failure) {
        emit(LoginFailure(errorMessage: failure.message));

        final currentState = state;
        if (currentState is LoginIdle) {
          emit(currentState);
        } else {
          emit(const LoginIdle());
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

    emit(const LoginSubmitting());

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
        emit(LoginFailure(errorMessage: failure.message));
        emit(currentState);
      },
    );
  }
}
