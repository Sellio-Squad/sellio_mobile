import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../../../data/core/storage/auth/auth_storage.dart';
import '../../../data/core/storage/auth/secure_storage_impl.dart';
import '../../../data/core/storage/cache/cache_storage.dart';
import '../../../data/core/storage/cache/shared_prefs_storage_impl.dart';

class StorageModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<FlutterSecureStorage>(
          () => const FlutterSecureStorage(),
    );

    sl.registerLazySingleton<AuthStorage>(
          () => SecureStorageImpl(storage: sl()),
    );

    sl.registerLazySingleton<CacheStorage>(
          () => SharedPrefsStorageImpl(sl()),
    );
  }
}