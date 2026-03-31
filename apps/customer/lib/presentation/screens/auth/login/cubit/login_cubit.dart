
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/screens/auth/shared/enums/validation_error_type.dart';
import 'package:sellio_mobile/presentation/screens/auth/shared/extensions.dart';
import '../../../../../domain/repositories/auth_repository.dart';
import 'package:sellio_mobile/domain/repositories/country_repository.dart';
import 'package:sellio_mobile/presentation/cubits/auth/authentication_cubit.dart';

import '../../shared/validators/form_validators.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final CountryRepository _countryRepository;
  final AuthenticationCubit _authenticationCubit;

  LoginCubit({
    required AuthRepository authRepository,
    required CountryRepository countryRepository,
    required AuthenticationCubit authenticationCubit,
    Country? initialCountry,
  })  : _authRepository = authRepository,
        _countryRepository = countryRepository,
        _authenticationCubit = authenticationCubit,
        super(LoginIdle(
        selectedCountry: initialCountry ?? Country.parse('eg'),
      ));

  Future<void> loadInitialCountry() async {
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final countryCode = await _countryRepository.getCurrentCountryCode();
    final countryObject = Country.parse(countryCode);

    emit(currentState.copyWith(selectedCountry: countryObject));
  }

  void updatePhoneNumber(String value) {
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final minPhoneLength = currentState.selectedCountry.maxPhoneLength;
    final result = FormValidators.validatePhone(value, minLength: minPhoneLength);

    emit(currentState.copyWith(
      phoneNumber: value,
      phoneError: () => result.error as PhoneValidationError?,
      isFormValid: _isFormValid(
        phone: value,
        password: currentState.password,
        phoneError: result.error as PhoneValidationError?,
        passwordError: currentState.passwordError,
      ),
    ));
  }

  void updatePassword(String value) {
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final result = FormValidators.validatePassword(value);

    emit(currentState.copyWith(
      password: value,
      passwordError: () => result.error as PasswordValidationError?,
      isFormValid: _isFormValid(
        phone: currentState.phoneNumber,
        password: value,
        phoneError: currentState.phoneError,
        passwordError: result.error as PasswordValidationError?,
      ),
    ));
  }

  void updateSelectedCountry(Country country) {
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final minPhoneLength = country.maxPhoneLength;
    final result = FormValidators.validatePhone(
      currentState.phoneNumber,
      minLength: minPhoneLength,
    );

    emit(currentState.copyWith(
      selectedCountry: country,
      phoneCode: country.phoneCode,
      phoneError: () => result.error as PhoneValidationError?,
      isFormValid: _isFormValid(
        phone: currentState.phoneNumber,
        password: currentState.password,
        phoneError: result.error as PhoneValidationError?,
        passwordError: currentState.passwordError,
      ),
    ));
  }

  void validatePhoneOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final minPhoneLength = currentState.selectedCountry.maxPhoneLength;
    final result = FormValidators.validatePhone(value, minLength: minPhoneLength);

    emit(currentState.copyWith(
      phoneError: () => result.error as PhoneValidationError?,
    ));
  }

  void validatePasswordOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final result = FormValidators.validatePassword(value);

    emit(currentState.copyWith(
      passwordError: () => result.error as PasswordValidationError?,
    ));
  }

  Future<void> login() async {
    final currentState = state;
    if (currentState is! LoginIdle) return;

    final minPhoneLength = currentState.selectedCountry.maxPhoneLength;
    final phoneResult = FormValidators.validatePhone(
      currentState.phoneNumber,
      minLength: minPhoneLength,
    );
    final passwordResult = FormValidators.validatePassword(currentState.password);

    if (!phoneResult.isValid || !passwordResult.isValid) {
      emit(currentState.copyWith(
        phoneError: () => phoneResult.error as PhoneValidationError?,
        passwordError: () => passwordResult.error as PasswordValidationError?,
      ));

      return;
    }

    emit(LoginSubmitting());

    final countryCode = currentState.selectedCountry.phoneCode;
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

        emit(currentState.copyWith(
          phoneError: () => null,
          passwordError: () => null,
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _authenticationCubit.loadAuthenticationStatus();

    return super.close();
  }
}

  bool _isFormValid({
    required String phone,
    required String password,
    required PhoneValidationError? phoneError,
    required PasswordValidationError? passwordError,
  }) {
    return phone.isNotEmpty &&
        password.isNotEmpty &&
        phoneError == null &&
        passwordError == null;
  }
