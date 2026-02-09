import 'package:get_it/get_it.dart';
import 'package:sellio_mobile/data/datasource/local/initial_country_local_datasource.dart';
import 'package:sellio_mobile/data/datasource/local/search_local_datasource.dart';
import 'package:sellio_mobile/data/datasource/remote/search_remote_datasource.dart';
import '../../data/datasource/remote/auth/auth_remote_datasource.dart';
import '../../../data/datasource/local/cart_local_datasource.dart';
import '../../../data/datasource/remote/category_remote_datasource.dart';
import '../../../data/datasource/remote/favorites_remote_datasource.dart';
import '../../../data/datasource/remote/offers_remote_datasource.dart';
import '../../../data/datasource/remote/order_remote_datasource.dart';
import '../../../data/datasource/remote/product_remote_datasource.dart';
import '../../../data/datasource/remote/store_remote_datasource.dart';
import '../../data/datasource/remote/auth/auth_remote_datasource_impl.dart';
import '../../data/datasource/remote/country_remote_datasource.dart';
import '../../data/datasource/remote/user/user_remote.dart';
import '../../data/datasource/remote/user/user_remote_impl.dart';

import '../../data/datasource/remote/category_section_remote_datasource.dart';

class DataSourceModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<CategorySectionRemoteDataSource>(
      () => CategorySectionRemoteDataSourceImpl(sl()),
    );
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

    sl.registerLazySingleton<CartLocalDataSource>(
          () => CartLocalDataSourceImpl(sl()),
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

    sl.registerLazySingleton<SearchRemoteDateSource>(
          () => SearchRemoteDatasourceImpl(sl()),
    );

    sl.registerLazySingleton<CountryRemoteDataSource>(
          () => CountryRemoteDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<SearchLocalDatasource>(
          () => SearchLocalDataSourceImpl(),
    );

    sl.registerLazySingleton<InitialCountryLocalDataSource>(
        () => InitialCountryLocalDataSourceImpl(),
    );
  }

}
