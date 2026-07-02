import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasource/remote/category_remote_datasource.dart';
import '../../data/datasource/remote/store_remote_datasource.dart';
import '../../data/datasource/remote/store_remote_datasource_impl.dart';

class DataSourceModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<InitialCountryLocalDataSource>(
      () => InitialCountryLocalDataSourceImpl(),
    );
    sl.registerLazySingleton<CountryRemoteDataSource>(
      () => CountryRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<StoreRemoteDataSource>(
      () => StoreRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(sl()),
    );
  }
}
