import 'package:get_it/get_it.dart';
import 'modules/auth_module.dart';
import 'modules/core_module.dart';
import 'modules/storage_module.dart';
import 'modules/navigation_module.dart';
import 'modules/bloc_module.dart';
import 'modules/datasource_module.dart';
import 'modules/repository_module.dart';

final getIt = GetIt.instance;
final sl = getIt;

Future<void> initDI() async {
  await initStorageDI();
  await initCoreDI();
  initDataSourceDI();
  initRepositoryDI();
  initCubitDI();
  initNavigationDI();
  initAuthDI();
}
