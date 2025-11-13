import 'package:get_it/get_it.dart';
import 'modules/core_module.dart';
import 'modules/datasource_module.dart';
import 'modules/repository_module.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await CoreModule.register(sl);
  DataSourceModule.register(sl);
  RepositoryModule.register(sl);
}