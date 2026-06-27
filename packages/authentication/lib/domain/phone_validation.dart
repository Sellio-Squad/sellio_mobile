class PhoneValidator {
  static bool validate(String countryCode, String phone) {
    if (phone.isEmpty) return false;

    switch (countryCode) {
      case 'EG':
        return RegExp(r'^(0?1\d{9})$').hasMatch(phone);

      case 'PS':
        return RegExp(r'^(0?5\d{8})$').hasMatch(phone);

      case 'IQ':
        return RegExp(r'^(0?7\d{9,10})$').hasMatch(phone);

      case 'SY':
        return RegExp(r'^(0?9\d{8})$').hasMatch(phone);

      default:
        return RegExp(r'^\d{8,15}$').hasMatch(phone);
    }
  }
}
