import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initStorageDI() async {
  final sl = GetIt.instance;
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<StorageService>(
    () => SharedPrefsStorageImpl(sl()),
  );
}
