import 'package:core/error/result.dart';

abstract class CountryRepository {
  Future<String> getCurrentCountryCode();
  Future<Result<List<String>>> getCitiesByCountryIso2(String iso2);
}
