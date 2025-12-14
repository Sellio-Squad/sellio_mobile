import 'package:equatable/equatable.dart';

import '../country.dart';

class AccountSettingsState extends Equatable {
  final String phoneNumber;
  final String fullName;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final bool isPhoneValid;

  bool get isFormValid => phoneNumber.isNotEmpty && fullName.isNotEmpty && isPhoneValid;

  const AccountSettingsState({
    this.phoneNumber = '',
    this.fullName = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isPhoneValid = false,
  });

  bool isPhoneNumberValid(Country country, String phone) {
    if (country.code == '+20') {
      return RegExp(r'^(0?1\d{9})$').hasMatch(phone);
    } else if (country.code == '+964') {
      return RegExp(r'^(0?7\d{9,10})$').hasMatch(phone);
    }
    return false;
  }


  AccountSettingsState copyWith({
    String? phoneNumber,
    String? fullName,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool? isPhoneValid,
  }) {
    return AccountSettingsState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
    );
  }

  @override
  List<Object?> get props => [
    phoneNumber,
    fullName,
    isLoading,
    isSuccess,
    errorMessage,
    isPhoneValid,
  ];
}
