import 'package:get_it/get_it.dart';

import 'modules/auth_module.dart';
import 'modules/bloc_module.dart';
import 'modules/core_module.dart';
import 'modules/datasource_module.dart';
import 'modules/navigation_module.dart';
import 'modules/repository_module.dart';
import 'modules/storage_module.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  await initStorageDI(sl);
  await initCoreDI(sl);
  initDataSourceDI(sl);
  initRepositoryDI(sl);
  initCubitDI(sl);
  initNavigationDI(sl);
  initAuthDI(sl);
}
