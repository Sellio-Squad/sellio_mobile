import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../data/core/api/api_endpoints.dart';
import '../../core/services/image_picker_service_impl.dart';

class CoreModule {
  static Future<void> register(GetIt sl) async {
    sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker(),
    );

    sl.registerLazySingleton<ImagePickerService>(
      () => ImagePickerServiceImpl(),
    );

    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl()),
    );

    sl.registerLazySingleton<ApiClient>(
      () => DioClient(
        baseUrl: ApiEndpoints.baseUrl,
        storageService: sl(),
        refreshTokenPath: ApiEndpoints.refreshToken,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }
}
