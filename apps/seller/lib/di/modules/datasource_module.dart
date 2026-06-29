import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

class DataSourceModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<InitialCountryLocalDataSource>(
      () => InitialCountryLocalDataSourceImpl(),
    );
    sl.registerLazySingleton<CountryRemoteDataSource>(
      () => CountryRemoteDataSourceImpl(sl()),
    );
  }
}
