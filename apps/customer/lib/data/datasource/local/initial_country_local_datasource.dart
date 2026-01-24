import 'package:country_detector/country_detector.dart';

abstract class InitialCountryLocalDataSource {
  Future<String?> getCountryCode();
}

class InitialCountryLocalDataSourceImpl
    implements InitialCountryLocalDataSource {
  @override
  Future<String?> getCountryCode() {
    return CountryDetector().isoCountryCode();
  }
}