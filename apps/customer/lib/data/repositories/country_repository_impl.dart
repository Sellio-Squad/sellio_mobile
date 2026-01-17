import 'package:country_picker/src/country.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasource/local/initial_country_local_datasource.dart';

class CountryRepositoryImpl  implements CountryRepository {
  final InitialCountryLocalDataSource initialCountryLocalDataSource;
  CountryRepositoryImpl({required this.initialCountryLocalDataSource});

  @override
  Future<Country> getInitialCountry() async {
    try {
      final code = await initialCountryLocalDataSource.getCountryCode();
      return Country.parse(code ?? 'eg');
    } catch (_) {
      return Country.parse('eg');
    }
  }
}