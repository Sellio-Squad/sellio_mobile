import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/enums/auth_error_type.dart';
import '../../../../../../core/enums/form_field_type.dart';
import '../../../../../../core/utils/validators/form_validators.dart';
import '../../../../../../domain/repositories/auth_repository.dart';
import 'create_account_form_state.dart';

class CreateAccountFormCubit extends Cubit<CreateAccountFormState> {
  final AuthRepository _authRepository;

  CreateAccountFormCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const CreateAccountFormInitial()) {
    _initialize();
  }

  void _initialize() {
    final defaultCountry = Country(
      phoneCode: '20',
      countryCode: 'EG',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Egypt',
      example: '1001234567',
      displayName: 'Egypt (EG) [+20]',
      displayNameNoCountryCode: 'Egypt (EG)',
      e164Key: '20-EG-0',
    );

    emit(CreateAccountFormLoaded(selectedCountry: defaultCountry));
  }

  void updateFirstName(String value) {
    _updateField((state) => state.copyWith(
      firstName: value,
      clearFieldError: true,
    ));
  }

  void updateLastName(String value) {
    _updateField((state) => state.copyWith(
      lastName: value,
      clearFieldError: true,
    ));
  }

  void updatePhoneNumber(String value) {
    _updateField((state) => state.copyWith(
      phoneNumber: value,
      clearFieldError: true,
    ));
  }

  void updateEmail(String value) {
    _updateField((state) => state.copyWith(
      email: value,
      clearFieldError: true,
    ));
  }

  void updateCity(String value) {
    _updateField((state) => state.copyWith(
      city: value,
      clearFieldError: true,
    ));
  }

  void updatePassword(String value) {
    _updateField((state) => state.copyWith(
      password: value,
      clearFieldError: true,
    ));
  }

  void updateConfirmPassword(String value) {
    _updateField((state) => state.copyWith(
      confirmPassword: value,
      clearFieldError: true,
    ));
  }

  void updateSelectedCountry(Country country) {
    _updateField((state) => state.copyWith(selectedCountry: country));
  }

  void updateProfileImage(File? image) {
    _updateField((state) => state.copyWith(
      selectedProfileImage: image,
      clearProfileImage: image == null,
    ));
  }

  void _updateField(
      CreateAccountFormLoaded Function(CreateAccountFormLoaded) updater,
      ) {
    final currentState = state;
    if (currentState is! CreateAccountFormLoaded) return;

    final newState = updater(currentState);
    emit(newState.copyWith(isFormValid: _isFormValid(newState)));
  }

  void validateFieldOnFocusChange(FormFieldType fieldType, String value) {
    if (value.isEmpty) return;
    final currentState = state;
    if (currentState is! CreateAccountFormLoaded) return;

    final result = FormValidators.validateField(
      fieldType,
      value,
      password: currentState.password,
    );

    if (!result.isValid && result.errorType != null) {
      emit(currentState.copyWith(fieldError: result.errorType));
    }
  }

  void clearFieldError() {
    final currentState = state;
    if (currentState is CreateAccountFormLoaded) {
      emit(currentState.copyWith(clearFieldError: true));
    }
  }

  Future<void> submitForm() async {
    final currentState = state;
    if (currentState is! CreateAccountFormLoaded) return;

    final validationError = FormValidators.validateRegistrationFields(
      firstName: currentState.firstName,
      lastName: currentState.lastName,
      phone: currentState.phoneNumber,
      email: currentState.email,
      city: currentState.city,
      password: currentState.password,
      confirmPassword: currentState.confirmPassword,
    );

    if (validationError != null) {
      emit(currentState.copyWith(fieldError: validationError));
      return;
    }

    emit(currentState.copyWith(isLoading: true));

    final countryCode = currentState.selectedCountry?.countryCode ?? 'EG';
    final fullPhoneNumber =
        '+${currentState.selectedCountry?.phoneCode ?? '20'}${currentState.phoneNumber}';

    final result = await _authRepository.register(
      firstName: currentState.firstName,
      lastName: currentState.lastName,
      phoneNumber: fullPhoneNumber,
      password: currentState.password,
      city: currentState.city,
      country: countryCode,
      email: currentState.email,
      region: countryCode,
    );

    result.fold(
      onSuccess: (_) {
        emit(const CreateAccountFormSuccess());
      },
      onFailure: (failure) {
        emit(const CreateAccountFormError(errorType: AuthErrorType.accountCreationFailed));
        emit(currentState.copyWith(isLoading: false));
      },
    );
  }

  bool _isFormValid(CreateAccountFormLoaded state) {
    return FormValidators.isRegistrationFormValid(
      firstName: state.firstName,
      lastName: state.lastName,
      phone: state.phoneNumber,
      email: state.email,
      city: state.city,
      password: state.password,
      confirmPassword: state.confirmPassword,
    );
  }
}