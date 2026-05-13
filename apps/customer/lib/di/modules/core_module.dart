import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/network/network_info.dart';
import '../../../data/core/api/api_client.dart';
import '../../../data/core/api/api_endpoints.dart';
import '../../../data/core/api/dio_client.dart';
import '../../core/services/image_picker_service.dart';
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
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }
}
