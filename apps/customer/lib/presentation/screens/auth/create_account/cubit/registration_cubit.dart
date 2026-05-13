import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/repositories/country_repository.dart';
import 'package:sellio_mobile/presentation/screens/auth/shared/enums/validation_error_type.dart';
import 'package:sellio_mobile/presentation/screens/auth/shared/extensions.dart';

import '../../../../../domain/repositories/auth_repository.dart';
import '../../shared/validators/form_validators.dart';
import '../../shared/validators/validation_result.dart';
import 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthRepository _authRepository;
  final CountryRepository _countryRepository;
  late RegistrationIdle? _lastIdleState;

  RegistrationCubit({
    required AuthRepository authRepository,
    required CountryRepository countryRepository,
    Country? initialCountry,
  })  : _authRepository = authRepository,
        _countryRepository = countryRepository,
        super(RegistrationIdle(
          selectedCountry: initialCountry ?? Country.parse('eg'),
        ));

  Future<void> loadInitialCountry() async {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final countryCode = await _countryRepository.getCurrentCountryCode();
    final country = Country.parse(countryCode);

    emit(currentState.copyWith(selectedCountry: country));
    loadCitiesForSelectedCountry(countryCode);
  }

  Future<void> loadCitiesForSelectedCountry(String iso2) async {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = await _countryRepository.getCitiesByCountryIso2(iso2);

    result.fold(
      onSuccess: (cities) {
        final latestState = state;
        if (latestState is RegistrationIdle &&
            latestState.selectedCountry.countryCode == iso2) {
          emit(latestState.copyWith(cities: cities));
        }
      },
      onFailure: (e) {
        emit(currentState.copyWith(cities: []));
      },
    );
  }

  void updateFullName(String value) {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = FormValidators.validateFullName(value);

    emit(currentState.copyWith(
      fullName: value,
      fullNameError: () => result.error as FullNameValidationError?,
      isFormValid: _isFormValid(
        fullName: value,
        phone: currentState.phoneNumber,
        city: currentState.city,
        password: currentState.password,
        confirmPassword: currentState.confirmPassword,
        fullNameError: result.error as FullNameValidationError?,
        phoneError: currentState.phoneError,
        cityError: currentState.cityError,
        passwordError: currentState.passwordError,
        confirmPasswordError: currentState.confirmPasswordError,
      ),
    ));
  }

  void updatePhoneNumber(String value) {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final minPhoneLength = currentState.selectedCountry.maxPhoneLength;
    final result =
        FormValidators.validatePhone(value, minLength: minPhoneLength);

    emit(currentState.copyWith(
      phoneNumber: value,
      phoneError: () => result.error as PhoneValidationError?,
      isFormValid: _isFormValid(
        fullName: currentState.fullName,
        phone: value,
        city: currentState.city,
        password: currentState.password,
        confirmPassword: currentState.confirmPassword,
        fullNameError: currentState.fullNameError,
        phoneError: result.error as PhoneValidationError?,
        cityError: currentState.cityError,
        passwordError: currentState.passwordError,
        confirmPasswordError: currentState.confirmPasswordError,
      ),
    ));
  }

  void updateCity(String value) {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = FormValidators.validateCity(value);

    emit(currentState.copyWith(
      city: value,
      cityError: () => result.error as CityValidationError?,
      isFormValid: _isFormValid(
        fullName: currentState.fullName,
        phone: currentState.phoneNumber,
        city: value,
        password: currentState.password,
        confirmPassword: currentState.confirmPassword,
        fullNameError: currentState.fullNameError,
        phoneError: currentState.phoneError,
        cityError: result.error as CityValidationError?,
        passwordError: currentState.passwordError,
        confirmPasswordError: currentState.confirmPasswordError,
      ),
    ));
  }

  void updatePassword(String value) {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = FormValidators.validatePassword(value);

    ValidationResult confirmResult = const ValidationResult.valid();
    if (currentState.confirmPassword.isNotEmpty) {
      confirmResult = FormValidators.validateConfirmPassword(
        value,
        currentState.confirmPassword,
      );
    }

    emit(currentState.copyWith(
      password: value,
      passwordError: () => result.error as PasswordValidationError?,
      confirmPasswordError: () =>
          confirmResult.error as PasswordValidationError?,
      isFormValid: _isFormValid(
        fullName: currentState.fullName,
        phone: currentState.phoneNumber,
        city: currentState.city,
        password: value,
        confirmPassword: currentState.confirmPassword,
        fullNameError: currentState.fullNameError,
        phoneError: currentState.phoneError,
        cityError: currentState.cityError,
        passwordError: result.error as PasswordValidationError?,
        confirmPasswordError: confirmResult.error as PasswordValidationError?,
      ),
    ));
  }

  void updateConfirmPassword(String value) {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = FormValidators.validateConfirmPassword(
      currentState.password,
      value,
    );

    emit(currentState.copyWith(
      confirmPassword: value,
      confirmPasswordError: () => result.error as PasswordValidationError?,
      isFormValid: _isFormValid(
        fullName: currentState.fullName,
        phone: currentState.phoneNumber,
        city: currentState.city,
        password: currentState.password,
        confirmPassword: value,
        fullNameError: currentState.fullNameError,
        phoneError: currentState.phoneError,
        cityError: currentState.cityError,
        passwordError: currentState.passwordError,
        confirmPasswordError: result.error as PasswordValidationError?,
      ),
    ));
  }

  void updateSelectedCountry(Country country) {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    // Re-validate phone with new country length
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
        fullName: currentState.fullName,
        phone: currentState.phoneNumber,
        city: currentState.city,
        password: currentState.password,
        confirmPassword: currentState.confirmPassword,
        fullNameError: currentState.fullNameError,
        phoneError: result.error as PhoneValidationError?,
        cityError: currentState.cityError,
        passwordError: currentState.passwordError,
        confirmPasswordError: currentState.confirmPasswordError,
      ),
    ));

    // Load cities for the new country
    loadCitiesForSelectedCountry(country.countryCode);
  }

  // ==================== Validation ====================

  void validateFullNameOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = FormValidators.validateFullName(value);
    emit(currentState.copyWith(
      fullNameError: () => result.error as FullNameValidationError?,
    ));
  }

  void validatePhoneOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final minPhoneLength = currentState.selectedCountry.maxPhoneLength;
    final result =
        FormValidators.validatePhone(value, minLength: minPhoneLength);

    emit(currentState.copyWith(
      phoneError: () => result.error as PhoneValidationError?,
    ));
  }

  void validateCityOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = FormValidators.validateCity(value);
    emit(currentState.copyWith(
      cityError: () => result.error as CityValidationError?,
    ));
  }

  void validatePasswordOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = FormValidators.validatePassword(value);
    emit(currentState.copyWith(
      passwordError: () => result.error as PasswordValidationError?,
    ));
  }

  void validateConfirmPasswordOnFocusLost(String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    final result = FormValidators.validateConfirmPassword(
      currentState.password,
      value,
    );
    emit(currentState.copyWith(
      confirmPasswordError: () => result.error as PasswordValidationError?,
    ));
  }

  bool _isFormValid({
    required String fullName,
    required String phone,
    required String city,
    required String password,
    required String confirmPassword,
    required FullNameValidationError? fullNameError,
    required PhoneValidationError? phoneError,
    required CityValidationError? cityError,
    required PasswordValidationError? passwordError,
    required PasswordValidationError? confirmPasswordError,
  }) {
    return fullName.isNotEmpty &&
        phone.isNotEmpty &&
        city.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        fullNameError == null &&
        phoneError == null &&
        cityError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  // ==================== Registration Operations ====================

  /// Performs registration operation
  /// On success, emits RegistrationOtpRequired state which triggers navigation to OTP screen
  Future<void> register() async {
    final currentState = state;
    if (currentState is! RegistrationIdle) return;

    _lastIdleState = currentState;
    final minPhoneLength = currentState.selectedCountry.maxPhoneLength;
    final fullNameResult =
        FormValidators.validateFullName(currentState.fullName);
    final phoneResult = FormValidators.validatePhone(
      currentState.phoneNumber,
      minLength: minPhoneLength,
    );
    final cityResult = FormValidators.validateCity(currentState.city);
    final passwordResult =
        FormValidators.validatePassword(currentState.password);
    final confirmPasswordResult = FormValidators.validateConfirmPassword(
      currentState.password,
      currentState.confirmPassword,
    );

    // Check if any validation failed
    if (!fullNameResult.isValid ||
        !phoneResult.isValid ||
        !cityResult.isValid ||
        !passwordResult.isValid ||
        !confirmPasswordResult.isValid) {
      emit(currentState.copyWith(
        fullNameError: () => fullNameResult.error as FullNameValidationError?,
        phoneError: () => phoneResult.error as PhoneValidationError?,
        cityError: () => cityResult.error as CityValidationError?,
        passwordError: () => passwordResult.error as PasswordValidationError?,
        confirmPasswordError: () =>
            confirmPasswordResult.error as PasswordValidationError?,
      ));
      return;
    }

    emit(const RegistrationSubmitting());

    final countryCode = currentState.selectedCountry.phoneCode;
    final countryName = currentState.selectedCountry.name;
    final fullPhoneNumber = '+$countryCode${currentState.phoneNumber}';

    final result = await _authRepository.register(
      fullName: currentState.fullName.trim(),
      phoneNumber: fullPhoneNumber,
      password: currentState.password,
      city: currentState.city,
      country: countryName,
      countryCode: countryCode,
      region: countryCode,
    );

    result.fold(
      onSuccess: (_) {
        // Repository stores sessionId internally
        // Emit state to trigger navigation to OTP screen
        emit(RegistrationOtpRequired(phoneNumber: fullPhoneNumber));
      },
      onFailure: (failure) {
        emit(RegistrationFailure(errorMessage: failure.message));
        // Return to idle state with cleared errors
        emit(currentState.copyWith(
          fullNameError: () => null,
          phoneError: () => null,
          cityError: () => null,
          passwordError: () => null,
          confirmPasswordError: () => null,
        ));
      },
    );
  }

  /// Verifies OTP - called by OTP screen via callback
  Future<Result<void>> verifyOtp(String otp) async {
    return await _authRepository.verifyRegistrationOtp(otp: otp);
  }

  void resetToIdle() {
    if (state is RegistrationIdle) return;

    if (_lastIdleState != null) {
      emit(_lastIdleState!);
    }
  }
}
