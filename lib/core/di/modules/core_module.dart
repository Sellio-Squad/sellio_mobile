import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/network_info.dart';
import '../../../data/core/api/api_client.dart';
import '../../../data/core/api/api_endpoints.dart';
import '../../../data/core/api/dio_client.dart';

class CoreModule {
  static Future<void> register(GetIt sl) async {

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    sl.registerLazySingleton<InternetConnectionChecker>(
          () => InternetConnectionChecker(),
    );

    sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(sl()),
    );

    sl.registerLazySingleton<ApiClient>(
          () => DioClient(
        baseUrl: ApiEndpoints.baseUrl,
        authStorage: sl(),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }
}