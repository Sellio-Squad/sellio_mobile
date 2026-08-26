import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:seller/data/repository/category_repository_impl.dart';
import 'package:seller/data/repository/mock_product_repository.dart';
import 'package:seller/data/repository/product_repository_impl.dart';
import 'package:seller/data/repository/seller_order_repository_impl.dart';
import 'package:seller/data/repository/store_repository_impl.dart';
import 'package:seller/domain/repository/category_repository.dart';
import 'package:seller/domain/repository/product_repository.dart';
import 'package:seller/domain/repository/seller_order_repository.dart';
import 'package:seller/domain/repository/store_repository.dart';

void initRepositoryDI(GetIt sl) {
  sl.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(
      initialCountryLocalDataSource: sl(),
      countryRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<SellerOrderRepository>(
    () => SellerOrderRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<MockProductRepository>(
    () => MockProductRepository(),
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
