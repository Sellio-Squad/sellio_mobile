import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/enums/form_field_type.dart';
import '../../../../../../core/enums/auth_error_type.dart';
import '../../../../../../core/utils/validators/form_validators.dart';
import '../../../../../../domain/repositories/auth_repository.dart';
import 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  final AuthRepository _authRepository;

  LoginFormCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginFormInitial()) {
    _initialize();
  }

  void _initialize() {
    final defaultCountry = Country(
      phoneCode: '964',
      countryCode: 'IQ',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Iraq',
      example: '7912345678',
      displayName: 'Iraq (IQ) [+964]',
      displayNameNoCountryCode: 'Iraq (IQ)',
      e164Key: '964-IQ-0',
    );

    emit(LoginFormLoaded(selectedCountry: defaultCountry));
  }

  void updatePhoneNumber(String value) {
    _updateField((state) => state.copyWith(
      phoneNumber: value,
      clearFieldError: true,
    ));
  }

  void updatePassword(String value) {
    _updateField((state) => state.copyWith(
      password: value,
      clearFieldError: true,
    ));
  }

  void updateSelectedCountry(Country country) {
    _updateField((state) => state.copyWith(selectedCountry: country));
  }

  void _updateField(LoginFormLoaded Function(LoginFormLoaded) updater) {
    final currentState = state;
    if (currentState is! LoginFormLoaded) return;

    final newState = updater(currentState);
    emit(newState.copyWith(isFormValid: _isFormValid(newState)));
  }

  void validateFieldOnFocusChange(FormFieldType fieldType, String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! LoginFormLoaded) return;

    final result = FormValidators.validateField(fieldType, value);

    if (!result.isValid && result.errorType != null) {
      emit(currentState.copyWith(fieldError: result.errorType));
    }
  }

  void clearFieldError() {
    final currentState = state;
    if (currentState is LoginFormLoaded) {
      emit(currentState.copyWith(clearFieldError: true));
    }
  }

  Future<void> submitForm() async {
    final currentState = state;
    if (currentState is! LoginFormLoaded) return;

    final validationError = FormValidators.validateLoginFields(
      phone: currentState.phoneNumber,
      password: currentState.password,
    );

    if (validationError != null) {
      emit(currentState.copyWith(fieldError: validationError));
      return;
    }

    emit(currentState.copyWith(isLoading: true));

    final countryCode = '+${currentState.selectedCountry?.phoneCode ?? '964'}';
    final phoneNumber = '$countryCode${currentState.phoneNumber}';

    final result = await _authRepository.login(
      phoneNumber: phoneNumber,
      password: currentState.password,
    );

    result.fold(
      onSuccess: (_) {
        final phoneNumber = '$countryCode${currentState.phoneNumber}';
        emit(LoginFormSuccess(phoneNumber: phoneNumber));
      },
      onFailure: (failure) {
        emit(const LoginFormError(errorType: AuthErrorType.loginFailed));
        emit(currentState.copyWith(isLoading: false));
      },
    );
  }

  bool _isFormValid(LoginFormLoaded state) {
    return FormValidators.isLoginFormValid(
      phone: state.phoneNumber,
      password: state.password,
    );
  }
}
