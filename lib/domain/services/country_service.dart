import '../entities/country.dart';
import '../../../core/design_system/constants/app_images.dart';

abstract class CountryService {
  List<Country> getAvailableCountries();
  Country? getDefaultCountry();
  Country? getCountryByCode(String code);
}

class CountryServiceImpl implements CountryService {
  static const String _defaultCountryCode = '+964';

  @override
  List<Country> getAvailableCountries() {
    return [
      const Country(
        name: 'Iraq',
        code: '+964',
        flagAsset: AppImages.flagIraq,
      ),
      const Country(
        name: 'Egypt',
        code: '+20',
        flagAsset: AppImages.flagEgypt,
      ),
    ];
  }

  @override
  Country? getDefaultCountry() {
    return getCountryByCode(_defaultCountryCode);
  }

  @override
  Country? getCountryByCode(String code) {
    try {
      return getAvailableCountries().firstWhere(
        (country) => country.code == code,
      );
    } catch (e) {
      return null;
    }
  }
}

