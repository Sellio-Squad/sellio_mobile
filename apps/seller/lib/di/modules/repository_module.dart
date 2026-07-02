import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/category_repository_impl.dart';
import '../../data/repositories/store_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/store_repository.dart';

class RepositoryModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<CountryRepository>(
      () => CountryRepositoryImpl(
        initialCountryLocalDataSource: sl(),
        countryRemoteDataSource: sl(),
      ),
    );

    sl.registerLazySingleton<StoreRepository>(
      () => StoreRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(remoteDataSource: sl()),
    );
  }
}
