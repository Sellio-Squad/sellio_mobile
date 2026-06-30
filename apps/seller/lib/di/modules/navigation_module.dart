import 'package:authentication/authentication.dart';
import 'package:get_it/get_it.dart';
import '../../core/navigate/app_navigator.dart';
import '../../core/navigate/app_navigator_impl.dart';

void initNavigationDI() {
  final sl = GetIt.instance;
  sl.registerLazySingleton<AppNavigator>(() => AppNavigatorImpl());
  sl.registerLazySingleton<AuthNavigator>(() => sl<AppNavigator>());
}
