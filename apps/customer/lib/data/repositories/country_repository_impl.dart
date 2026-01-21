import 'package:flutter/cupertino.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasource/local/initial_country_local_datasource.dart';

class CountryRepositoryImpl  implements CountryRepository {
  final InitialCountryLocalDataSource initialCountryLocalDataSource;
  CountryRepositoryImpl({required this.initialCountryLocalDataSource});

  @override
  Future<String> getCurrentCountryCode() async {
    try {
      final code = await initialCountryLocalDataSource.getCountryCode();

      return code ?? 'eg';
    } catch (e) {
      debugPrint("Failed To Get Initial Country\nCause: $e");
      return 'eg';
    }
  }
}