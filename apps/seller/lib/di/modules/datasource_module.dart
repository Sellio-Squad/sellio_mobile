import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:seller/data/datasource/fake/seller_order_fake_datasource.dart';
import 'package:seller/data/datasource/seller_order_datasource.dart';

class DataSourceModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<InitialCountryLocalDataSource>(
      () => InitialCountryLocalDataSourceImpl(),
    );
    sl.registerLazySingleton<CountryRemoteDataSource>(
      () => CountryRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<SellerOrderDataSource>(
      () => SellerOrderFakeDataSource(),
    );
  }
}
