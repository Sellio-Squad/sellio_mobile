import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/core/storage/shared_prefs_storage_impl.dart';

class StorageModule {
  static Future<void> register(GetIt sl) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(sharedPreferences);

    sl.registerLazySingleton<StorageService>(
      () => SharedPrefsStorageImpl(sl()),
    );
  }
}
