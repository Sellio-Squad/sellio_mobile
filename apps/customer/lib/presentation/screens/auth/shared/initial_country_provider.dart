import 'package:country_picker/country_picker.dart';
import 'package:country_detector/country_detector.dart';

class InitialCountryProvider {
  static Future<Country> getInitialCountry() async {
    try {
      String? code = await CountryDetector().isoCountryCode();
      return Country.parse(code ?? 'eg');
    } catch (_) {
      return Country.parse('eg');
    }
  }
}