import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:sellio_mobile/data/repository/favorites_repository_impl.dart';

import '../../../data/repository/store_repository_impl.dart';
import '../../../domain/repository/store_repository.dart';
import '../../data/repository/cart_repository_impl.dart';
import '../../data/repository/category_details_repository_impl.dart';
import '../../data/repository/category_repository_impl.dart';
import '../../data/repository/category_section_repository_impl.dart';
import '../../data/repository/offers_repository_impl.dart';
import '../../data/repository/order_repository_impl.dart';
import '../../data/repository/product_repository_impl.dart';
import '../../data/repository/search_repository_impl.dart';
import '../../domain/repository/cart_repository.dart';
import '../../domain/repository/category_details_repository.dart';
import '../../domain/repository/category_repository.dart';
import '../../domain/repository/category_section_repository.dart';
import '../../domain/repository/favorites_repository.dart';
import '../../domain/repository/offers_repository.dart';
import '../../domain/repository/order_repository.dart';
import '../../domain/repository/product_repository.dart';
import '../../domain/repository/search_repository.dart';

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
        remoteDataSource: sl(),
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
