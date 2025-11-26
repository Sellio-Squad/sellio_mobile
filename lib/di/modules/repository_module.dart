import 'package:get_it/get_it.dart';
import 'package:sellio_mobile/domain/repositories/notification_repository.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../data/repositories/cart_repository_impl.dart';
import '../../../data/repositories/category_repository_impl.dart';
import '../../../data/repositories/favorites_repository_impl.dart';
import '../../../data/repositories/notification_repository_impl.dart';
import '../../../data/repositories/offers_repository_impl.dart';
import '../../../data/repositories/order_repository_impl.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../data/repositories/store_repository_impl.dart';
import '../../../data/repositories/user_repository_impl.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/cart_repository.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/favorites_repository.dart';
import '../../../domain/repositories/offers_repository.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/repositories/store_repository.dart';
import '../../../domain/repositories/user_repository.dart';

class RepositoryModule {
  static void register(GetIt sl) {
    // sl.registerLazySingleton<AuthRepository>(
    //       () => AuthRepositoryImpl(
    //     remoteDataSource: sl(),
    //     storageService: sl(),
    //   ),
    // );
    //
    // sl.registerLazySingleton<ProductRepository>(
    //       () => ProductRepositoryImpl(
    //     remoteDataSource: sl(),
    //     favoritesRemoteDataSource: sl(),
    //     storageService: sl()
    //   ),
    // );
    //
    // sl.registerLazySingleton<StoreRepository>(
    //       () => StoreRepositoryImpl(
    //     remoteDataSource: sl(),
    //     favoritesRemoteDataSource: sl(),
    //     storageService: sl()
    //   ),
    // );
    //
    sl.registerLazySingleton<CategoryRepository>(
          () => CategoryRepositoryImpl(
        remoteDataSource: sl()
      ),
    );
    //
    // sl.registerLazySingleton<CartRepository>(
    //       () => CartRepositoryImpl(
    //     remoteDataSource: sl(),
    //     storageService: sl()
    //   ),
    // );
    //
    // sl.registerLazySingleton<OrderRepository>(
    //       () => OrderRepositoryImpl(
    //     remoteDataSource: sl()
    //   ),
    // );

    sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(
        remoteDataSource: sl()
      ),
    );

    // sl.registerLazySingleton<FavoritesRepository>(
    //       () => FavoritesRepositoryImpl(
    //     remoteDataSource: sl()
    //   ),
    // );
    //
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