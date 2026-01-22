import 'package:flutter/cupertino.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/data/core/utils/repository_call_handler.dart';

import '../../domain/repositories/country_repository.dart';
import '../datasource/local/initial_country_local_datasource.dart';
import '../datasource/remote/country_remote_datasource.dart';

class CountryRepositoryImpl implements CountryRepository {
  final InitialCountryLocalDataSource initialCountryLocalDataSource;
  final CountryRemoteDataSource countryRemoteDataSource;

  CountryRepositoryImpl(
      {required this.initialCountryLocalDataSource,
      required this.countryRemoteDataSource,});

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

  @override
  Future<Result<List<String>>> getCitiesByCountryIso2(String iso2) async {
    return RepositoryCallHandler.call<List<String>>(() async {
      final response = await countryRemoteDataSource.getCitiesByCountryIso2(iso2);

      return response;
    });
  }
}
