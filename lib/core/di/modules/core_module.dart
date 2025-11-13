import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/core/api/api_endpoints.dart';
import '../../../data/core/api/dio_client.dart';
import '../../../data/core/api/http_client.dart';
import '../../../data/core/storage/local_storage.dart';
import '../../../data/core/storage/secure_storage.dart';

class CoreModule {
  static Future<void> register(GetIt sl) async {
    // Shared Preferences
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    // Storage
    sl.registerLazySingleton<LocalStorage>(() => LocalStorage(sl()));
    sl.registerLazySingleton<SecureStorage>(() => SecureStorage());

    // HTTP Client
    sl.registerLazySingleton<HttpClient>(
          () => DioClient(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }
}