import 'package:apps_customer/data/core/api/api_client.dart';
import 'package:apps_customer/data/core/api/api_endpoints.dart';
import 'package:apps_customer/data/core/api/dio_client.dart';
import 'package:apps_customer/data/core/interceptors/auth_interceptor.dart';
import 'package:apps_customer/data/core/interceptors/error_interceptor.dart';
import 'package:apps_customer/data/datasource/local/cart_local_datasource.dart';
import 'package:apps_customer/data/datasource/local/initial_country_local_datasource.dart';
import 'package:apps_customer/data/datasource/local/search_local_datasource.dart';
import 'package:apps_customer/data/datasource/remote/auth/auth_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/auth/auth_remote_datasource_impl.dart';
import 'package:apps_customer/data/datasource/remote/category_details_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/category_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/category_section_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/country_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/favorites_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/offers_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/order_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/product_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/search_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/store_remote_datasource.dart';
import 'package:apps_customer/data/datasource/remote/user/user_remote.dart';
import 'package:apps_customer/data/datasource/remote/user/user_remote_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:network_inspector/network_inspector.dart';

void initDataSourceModule() {
  final GetIt getIt = GetIt.instance;

  getIt
    ..registerLazySingleton<Dio>(() {
      final dio = DioClient.createDio(
        baseUrl: ApiEndpoints.baseUrl,
        interceptors: [
          getIt<AuthInterceptor>(),
          getIt<ErrorInterceptor>(),
        ],
      );
      if (kDebugMode) {
        dio.interceptors.insert(0, NetworkInspectorDioInterceptor());
      }
      return dio;
    })
    ..registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(getIt<ApiClient>()))
    ..registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(getIt<ApiClient>()))
    ..registerLazySingleton<CategoryRemoteDataSource>(
        () => CategoryRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<CategorySectionRemoteDataSource>(
        () => CategorySectionRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<OffersRemoteDataSource>(
        () => OffersRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<StoreRemoteDataSource>(
        () => StoreRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<CategoryDetailsRemoteDataSource>(
        () => CategoryDetailsRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSource())
    ..registerLazySingleton<SearchLocalDataSource>(
        () => SearchLocalDataSource())
    ..registerLazySingleton<FavoritesRemoteDataSource>(
        () => FavoritesRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<OrderRemoteDataSource>(
        () => OrderRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<CountryRemoteDataSource>(
        () => CountryRemoteDataSource(getIt<ApiClient>()))
    ..registerLazySingleton<InitialCountryLocalDataSource>(
        () => InitialCountryLocalDataSource());
}