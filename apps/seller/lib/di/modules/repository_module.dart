import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

class RepositoryModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<CountryRepository>(
      () => CountryRepositoryImpl(
        initialCountryLocalDataSource: sl(),
        countryRemoteDataSource: sl(),
      ),
    );
  }
}
