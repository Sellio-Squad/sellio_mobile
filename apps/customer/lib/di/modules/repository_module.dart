import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:sellio_mobile/data/repositories/favorites_repository_impl.dart';

import '../../../data/repositories/store_repository_impl.dart';
import '../../../domain/repositories/store_repository.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../data/repositories/category_details_repository_impl.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../data/repositories/category_section_repository_impl.dart';
import '../../data/repositories/offers_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/category_details_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/category_section_repository.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../../domain/repositories/offers_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/search_repository.dart';

class RepositoryModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<CategorySectionRepository>(
      () => CategorySectionRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
          remoteDataSource: sl(),
          favoritesRemoteDataSource: sl(),
          searchRemoteDataSource: sl()),
    );
    //
    sl.registerLazySingleton<StoreRepository>(
      () => StoreRepositoryImpl(
          remoteDataSource: sl(), favoritesRemoteDataSource: sl()),
    );
    //
    sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(remoteDataSource: sl()),
    );
    //
    sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(
        localDataSource: sl(),
      ),
    );
    //
    sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(remoteDataSource: sl()),
    );

    sl.registerLazySingleton<FavoritesRepository>(() => FavoritesRepositoryImpl(
          remoteDataSource: sl(),
          productRemoteDataSource: sl(),
          storeRemoteDataSource: sl(),
        ));

    sl.registerLazySingleton<OffersRepository>(
      () => OffersRepositoryImpl(remoteDataSource: sl()),
    );

    sl.registerLazySingleton<SearchRepository>(() =>
        SearchRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));
    sl.registerLazySingleton<CountryRepository>(
      () => CountryRepositoryImpl(
        initialCountryLocalDataSource: sl(),
        countryRemoteDataSource: sl(),
      ),
    );

    sl.registerLazySingleton<CategoryDetailsRepository>(
      () => CategoryDetailsRepositoryImpl(remoteDataSource: sl()),
    );

    // sl.registerLazySingleton<OffersRepository>(
    //       () => OffersRepositoryImpl(
    //     remoteDataSource: sl()
    //   ),
    // );
    //
    // sl.registerLazySingleton<NotificationRepository>(
    //       () => NotificationRepositoryImpl()
    // );
  }
}
