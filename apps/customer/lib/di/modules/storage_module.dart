import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/core/storage/secure_storage_impl.dart';
import '../../../data/core/storage/shared_prefs_storage_impl.dart';
import '../../../data/core/storage/storage_service.dart';

class StorageModule {
  static void register(GetIt sl) async{

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    sl.registerLazySingleton<StorageService>(
          () => SharedPrefsStorageImpl(sl()),
    );
  }
}
