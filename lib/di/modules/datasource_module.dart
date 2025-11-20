import 'package:get_it/get_it.dart';
import '../../../data/datasource/remote/auth_remote_datasource.dart';
import '../../../data/datasource/remote/cart_remote_datasource.dart';
import '../../../data/datasource/remote/category_remote_datasource.dart';
import '../../../data/datasource/remote/favorites_remote_datasource.dart';
import '../../../data/datasource/remote/offers_remote_datasource.dart';
import '../../../data/datasource/remote/order_remote_datasource.dart';
import '../../../data/datasource/remote/product_remote_datasource.dart';
import '../../../data/datasource/remote/store_remote_datasource.dart';
import '../../../data/datasource/remote/user_remote_datasource.dart';

class DataSourceModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<ProductRemoteDataSource>(
          () => ProductRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<StoreRemoteDataSource>(
          () => StoreRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<CategoryRemoteDataSource>(
          () => CategoryRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<CartRemoteDataSource>(
          () => CartRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<OrderRemoteDataSource>(
          () => OrderRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<UserRemoteDataSource>(
          () => UserRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<FavoritesRemoteDataSource>(
          () => FavoritesRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<OffersRemoteDataSource>(
          () => OffersRemoteDataSourceImpl(sl()),
    );
  }
}