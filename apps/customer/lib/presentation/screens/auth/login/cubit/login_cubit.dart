import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/countries.dart' as intl_countries;
import 'package:sellio_mobile/domain/repositories/country_repository.dart';
import 'package:sellio_mobile/presentation/cubits/auth/authentication_cubit.dart';

import '../../../../../domain/repositories/auth_repository.dart';
import '../../shared/enums/form_field_type.dart';
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

  void updateSelectedCountryCode(Country country) {
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
    final int minPhoneLength = intl_countries.countries
        .firstWhere(
          (c) => c.code == currentState.selectedCountry.countryCode,
        )
        .maxLength;

    FormValidators.validateField(
      fieldType,
      value,
      minPhoneLength: minPhoneLength,
    );

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
    final requiredLength = _getRequiredPhoneLength(state);
    final bool isValid = FormValidators.isLoginFormValid(
      phone: state.phoneNumber,
      password: state.password,
      minPhoneLength: requiredLength,
    );

    return isValid;
  }

  int? _getRequiredPhoneLength(LoginIdle state) {
    if (state.selectedCountry.countryCode.isEmpty) return null;

    try {
      final countryData = intl_countries.countries.firstWhere(
        (c) =>
            c.code.toUpperCase() ==
            state.selectedCountry.countryCode.toUpperCase(),
      );

      return countryData.maxLength;
    } catch (e) {
      return 10;
    }
  }

  Future<void> loginAsGuest() async {
    emit(LoginSubmitting());

    final result = await _authRepository.loginAsGuest();

    result.fold(
      onSuccess: (_) {
        emit(const LoginSuccess());
      },
      onFailure: (failure) {
        emit(LoginFailure(
          errorMessage: failure.message,
        ));

        final currentState = state;
        if (currentState is LoginIdle) {
          emit(currentState);
        } else {
          emit(LoginIdle(
            selectedCountry: (state as LoginIdle).selectedCountry,
          ));
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
        emit(LoginFailure(
          errorMessage: failure.message,
        ));
        emit(currentState);
      },
    );
  }

  @override
  Future<void> close() {
    _authenticationCubit.loadAuthenticationStatus();

    return super.close();
  }
}
