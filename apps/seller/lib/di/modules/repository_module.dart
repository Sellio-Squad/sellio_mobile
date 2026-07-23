import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:seller/data/repository/seller_order_repository_impl.dart';
import 'package:seller/domain/repository/seller_order_repository.dart';

import '../../data/repository/category_repository_impl.dart';
import '../../data/repository/product_repository_impl.dart';
import '../../data/repository/store_repository_impl.dart';
import '../../domain/repository/category_repository.dart';
import '../../domain/repository/product_repository.dart';
import '../../domain/repository/store_repository.dart';

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

    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(dataSource: sl()),
    );

    sl.registerLazySingleton<StoreRepository>(
      () => StoreRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(remoteDataSource: sl()),
    );
  }
}
