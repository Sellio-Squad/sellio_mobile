import 'package:country_picker/country_picker.dart';
import 'package:flutter_intl_phone_field/countries.dart' as intl_countries;

extension CountryExtensions on Country {
  int? get maxPhoneLength {
    if (countryCode.isEmpty) return null;

    try {
      final countryData = intl_countries.countries.firstWhere(
        (c) => c.code.toUpperCase() == countryCode.toUpperCase(),
      );

      return countryData.maxLength;
    } catch (e) {
      return 10;
    }
  }
}
