import 'package:core/data/network/api_client.dart';
import 'package:core/data/network/dio_client.dart';
import 'package:core/data/network/network_info.dart';
import 'package:core/services/image_picker_service.dart';
import 'package:core/services/image_picker_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../data/core/api/api_endpoints.dart';
import '../../data/core/api/seller_auth_configuration.dart';

class CoreModule {
  static Future<void> register(GetIt sl) async {
    final authConfig = SellerAuthConfiguration();

    sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker(),
    );

    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl()),
    );

    sl.registerLazySingleton<ImagePickerService>(
      () => ImagePickerServiceImpl(),
    );

    sl.registerLazySingleton<ApiClient>(
      () => DioClient(
        baseUrl: ApiEndpoints.baseUrl,
        storageService: sl(),
        refreshTokenPath: authConfig.refreshToken,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }
}
