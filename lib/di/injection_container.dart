import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/network/network_info.dart';
import '../data/datasources/remote/api_service/api_service.dart';
import '../data/datasources/local/user_local_datasource.dart';
import '../data/datasources/local/cart_local_datasource.dart';
import '../data/datasources/local/category_local_datasource.dart';
import '../data/datasources/local/product_local_datasource.dart';
import '../data/datasources/local/store_local_datasource.dart';
import '../data/datasources/remote/auth_remote_datasource.dart';
import '../data/datasources/remote/cart_remote_datasource.dart';
import '../data/datasources/remote/category_remote_datasource.dart';
import '../data/datasources/remote/product_remote_datasource.dart';
import '../data/datasources/remote/store_remote_datasource.dart';
import '../data/datasources/remote/user_remote_datasource.dart';
import '../data/datasources/remote/order_remote_datasource.dart';
import '../data/repository_impl/auth_repository_impl.dart';
import '../data/repository_impl/cart_repository_impl.dart';
import '../data/repository_impl/category_repository_impl.dart';
import '../data/repository_impl/product_repository_impl.dart';
import '../data/repository_impl/store_repository_impl.dart';
import '../data/repository_impl/user_repository_impl.dart';
import '../data/repository_impl/order_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/cart_repository.dart';
import '../domain/repositories/category_repository.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/repositories/store_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/repositories/order_repository.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  await _initCoreModule();

  _initDataSourcesModule();

  _initRepositoriesModule();
}

Future<void> _initCoreModule() async {
  if (!instance.isRegistered<SharedPreferences>()) {
    final sharedPreferences = await SharedPreferences.getInstance();
    instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }

  if (!instance.isRegistered<InternetConnectionChecker>()) {
    instance.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker(),
    );
  }

  if (!instance.isRegistered<NetworkInfo>()) {
    instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(instance<InternetConnectionChecker>()),
    );
  }

  if (!instance.isRegistered<UserLocalDataSource>()) {
    instance.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(instance<SharedPreferences>()),
    );
  }

  if (!instance.isRegistered<ApiService>()) {
    instance.registerLazySingleton<ApiService>(
      () => ApiService(),
    );
  }
}

void _initDataSourcesModule() {

  if (!instance.isRegistered<AuthRemoteDataSource>()) {
    instance.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(instance<ApiService>()),
    );
  }

  if (!instance.isRegistered<CartRemoteDataSource>()) {
    instance.registerFactory<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(instance<ApiService>()),
    );
  }

  if (!instance.isRegistered<CategoryRemoteDataSource>()) {
    instance.registerFactory<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(instance<ApiService>()),
    );
  }

  if (!instance.isRegistered<ProductRemoteDataSource>()) {
    instance.registerFactory<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(instance<ApiService>()),
    );
  }

  if (!instance.isRegistered<StoreRemoteDataSource>()) {
    instance.registerFactory<StoreRemoteDataSource>(
      () => StoreRemoteDataSourceImpl(instance<ApiService>()),
    );
  }

  if (!instance.isRegistered<UserRemoteDataSource>()) {
    instance.registerFactory<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(instance<ApiService>()),
    );
  }

  if (!instance.isRegistered<OrderRemoteDataSource>()) {
    instance.registerFactory<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(instance<ApiService>()),
    );
  }

  if (!instance.isRegistered<CartLocalDataSource>()) {
    instance.registerFactory<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(),
    );
  }

  if (!instance.isRegistered<CategoryLocalDataSource>()) {
    instance.registerFactory<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(),
    );
  }

  if (!instance.isRegistered<ProductLocalDataSource>()) {
    instance.registerFactory<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(),
    );
  }

  if (!instance.isRegistered<StoreLocalDataSource>()) {
    instance.registerFactory<StoreLocalDataSource>(
      () => StoreLocalDataSourceImpl(),
    );
  }
}

void _initRepositoriesModule() {

  if (!instance.isRegistered<AuthRepository>()) {
    instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        instance<AuthRemoteDataSource>(),
        instance<UserLocalDataSource>(),
      ),
    );
  }

  if (!instance.isRegistered<CartRepository>()) {
    instance.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(
        instance<CartRemoteDataSource>(),
        instance<CartLocalDataSource>(),
      ),
    );
  }

  if (!instance.isRegistered<CategoryRepository>()) {
    instance.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(
        instance<CategoryRemoteDataSource>(),
        instance<CategoryLocalDataSource>(),
      ),
    );
  }

  if (!instance.isRegistered<ProductRepository>()) {
    instance.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        instance<ProductRemoteDataSource>(),
        instance<ProductLocalDataSource>(),
      ),
    );
  }

  if (!instance.isRegistered<StoreRepository>()) {
    instance.registerLazySingleton<StoreRepository>(
      () => StoreRepositoryImpl(
        instance<StoreRemoteDataSource>(),
        instance<StoreLocalDataSource>(),
      ),
    );
  }

  if (!instance.isRegistered<UserRepository>()) {
    instance.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        instance<UserRemoteDataSource>(),
        instance<UserLocalDataSource>(),
      ),
    );
  }

  if (!instance.isRegistered<OrderRepository>()) {
    instance.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(
        instance<OrderRemoteDataSource>(),
      ),
    );
  }
}

