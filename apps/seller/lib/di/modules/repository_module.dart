import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:seller/data/repositories/seller_order_repository_impl.dart';
import 'package:seller/domain/repositories/seller_order_repository.dart';

class RepositoryModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<CountryRepository>(
      () => CountryRepositoryImpl(
        initialCountryLocalDataSource: sl(),
        countryRemoteDataSource: sl(),
      ),
    );

    sl.registerLazySingleton<SellerOrderRepository>(
      () => SellerOrderRepositoryImpl(dataSource: sl()),
    );
  }
}
