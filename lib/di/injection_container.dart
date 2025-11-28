import 'package:get_it/get_it.dart';
import 'mock/MockRepositoryModule.dart';
import 'modules/bloc_module.dart';
import 'modules/core_module.dart';
import 'modules/datasource_module.dart';
import 'modules/repository_module.dart';
import 'modules/storage_module.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await CoreModule.register(sl);
  StorageModule.register(sl);
  DataSourceModule.register(sl);
  RepositoryModule.register(sl);
  // MockRepositoryModule.register(sl);
  BlocModule.register(sl);
}
