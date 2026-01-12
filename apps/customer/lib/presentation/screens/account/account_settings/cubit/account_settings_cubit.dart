import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/phone_validation.dart';

import '../../../../../core/error/result.dart';
import '../../../../../domain/repositories/user_repository.dart';
import 'account_settings_state.dart';

class AccountSettingsCubit extends Cubit<AccountSettingsState> {
  final UserRepository _repository;

  AccountSettingsCubit(this._repository) : super(const AccountSettingsState());

  Future<void> loadAccountDetails() async {
    emit(state.copyWith(isLoading: true));
    final result = await _repository.getUserProfile();
    if (result is Success) {
      final parsedData = _parsePhoneNumber(result.data.phoneNumber);
      emit(state.copyWith(
        isLoading: false,
        phoneNumber: parsedData.phoneNumber,
        selectedCountry: parsedData.country ?? state.selectedCountry,
        fullName: "${result.data.firstName} ${result.data.lastName}",
        errorMessage: null,
      ));
    } else if (result is ResultFailure) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.failure.message,
      ));
    }
  }

  void updatePhoneNumber(String value, {required Country selectedCountry}) {
    final isValid = PhoneValidator.validate(selectedCountry.countryCode, value);
    emit(
      state.copyWith(
        phoneNumber: value,
        isPhoneValid: isValid,
        errorMessage: null,
      ),
    );
  }

  void updateName(String value) {
    emit(
      state.copyWith(
        fullName: value,
        errorMessage: null,
      ),
    );
  }

  void updateSelectedCountry(Country country) {
    final isValid =
        PhoneValidator.validate(country.countryCode, state.phoneNumber);
    emit(state.copyWith(selectedCountry: country, isPhoneValid: isValid));
    updatePhoneNumber(state.phoneNumber, selectedCountry: country);
  }

  Future<void> updateAccountDetails(Country selectedCountry) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final fullNameParts = splitFullName(state.fullName);
    final formattedPhone =
        _formatPhoneNumber(selectedCountry, state.phoneNumber);
    final result = await _repository.updateUserProfile(
      phoneNumber: formattedPhone,
      firstName: fullNameParts["firstName"],
      lastName: fullNameParts["lastName"],
    );
    if (result is Success) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } else if (result is ResultFailure) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.failure.message,
      ));
    }
  }

  Map<String, String> splitFullName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) {
      return {"firstName": "", "lastName": ""};
    }
    if (parts.length == 1) {
      return {"firstName": parts.first, "lastName": ""};
    }
    return {
      "firstName": parts.first,
      "lastName": parts.sublist(1).join(" "),
    };
  }

  String _formatPhoneNumber(Country country, String phone) {
    String normalized = phone.trim().replaceAll(' ', '');
    if (normalized.startsWith('0')) {
      normalized = normalized.substring(1);
    }
    return "+${country.phoneCode}$normalized";
  }

  ({String phoneNumber, Country? country}) _parsePhoneNumber(String fullPhone) {
    if (fullPhone.isEmpty) return (phoneNumber: "", country: null);

    String processedPhone = fullPhone;

    if (processedPhone.startsWith('+')) {
      processedPhone = processedPhone.substring(1);
    }

    final List<Country> countries = CountryService().getAll();
    countries.sort((a, b) => b.phoneCode.length.compareTo(a.phoneCode.length));

    for (final country in countries) {
      if (processedPhone.startsWith(country.phoneCode)) {
        final parsedPhoneNumber =
            processedPhone.substring(country.phoneCode.length);
        return (phoneNumber: parsedPhoneNumber, country: country);
      }
    }
    return (phoneNumber: fullPhone, country: null);
  }
}
