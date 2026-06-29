import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageModule {
  static void register(GetIt sl) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    sl.registerLazySingleton<StorageService>(
      () => SharedPrefsStorageImpl(sl()),
    );
  }
}
