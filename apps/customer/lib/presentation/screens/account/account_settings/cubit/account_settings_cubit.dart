import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/result.dart';
import '../../../../../domain/repositories/user_repository.dart';
import '../../../auth/country.dart';
import 'account_settings_state.dart';

class AccountSettingsCubit extends Cubit<AccountSettingsState> {
  final UserRepository _repository;
  AccountSettingsCubit(this._repository) : super(const AccountSettingsState());

  void updatePhoneNumber(String value, {required Country selectedCountry}) {
    emit(
      state.copyWith(
        phoneNumber: value,
        isPhoneValid: state.isPhoneNumberValid(selectedCountry, value),
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

  Future<void> updateAccountDetails(Country selectedCountry) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final fullNameParts = splitFullName(state.fullName);
    final formattedPhone = formatPhoneNumber(selectedCountry, state.phoneNumber);
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

  String formatPhoneNumber(Country country, String phone) {
    String normalized = phone.trim();
    normalized = normalized.replaceAll(' ', '');

    if (normalized.startsWith('0')) {
      normalized = normalized.substring(1);
    }

    return "${country.code}$normalized";
  }

}
