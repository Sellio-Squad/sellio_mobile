import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

class AccountSettingsState extends Equatable {
  final String phoneNumber;
  final String fullName;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final bool isPhoneValid;
  final Country? selectedCountry;

  bool get isFormValid =>
      phoneNumber.isNotEmpty && fullName.isNotEmpty && isPhoneValid;

  const AccountSettingsState({
    this.phoneNumber = '',
    this.fullName = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isPhoneValid = false,
    this.selectedCountry,
  });

  bool isPhoneNumberValid(Country country, String phone) {
    if (country.countryCode == 'EG') {
      return RegExp(r'^(0?1\d{9})$').hasMatch(phone);
    } else if (country.countryCode == 'PS') {
      return RegExp(r'^(0?5\d{8})$').hasMatch(phone);
    } else if (country.countryCode == 'IQ') {
      return RegExp(r'^(0?7\d{9,10})$').hasMatch(phone);
    } else if (country.countryCode == 'SY') {
      return RegExp(r'^(0?9\d{8})$').hasMatch(phone);
    }
    return RegExp(r'^\d{8,15}$').hasMatch(phone);
  }

  AccountSettingsState copyWith({
    String? phoneNumber,
    String? fullName,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool? isPhoneValid,
    Country? selectedCountry,
  }) {
    return AccountSettingsState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      selectedCountry: selectedCountry ?? this.selectedCountry,
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
        selectedCountry,
      ];
}
