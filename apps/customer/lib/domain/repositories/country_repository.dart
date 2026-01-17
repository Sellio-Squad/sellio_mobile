import 'package:country_picker/country_picker.dart';

abstract class CountryRepository {
  Future<Country> getInitialCountry();
}