import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import '../../data/datasource/remote/auth_endpoints.dart';
import '../../data/datasource/remote/auth_remote_datasource.dart';
import '../../data/datasource/remote/auth_remote_datasource_impl.dart';
import '../../data/datasource/remote/user_remote_datasource.dart';
import '../../data/datasource/remote/user_remote_datasource_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../presentation/cubits/auth/authentication_cubit.dart';

class AuthPackage {
  static void init({
    required GetIt sl,
    required AuthEndpoints endpoints,
  }) {
    // Endpoints
    sl.registerSingleton<AuthEndpoints>(endpoints);

    // DataSources
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<ApiClient>(), sl<AuthEndpoints>()),
    );
    sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl<ApiClient>(), sl<AuthEndpoints>()),
    );

    // Repositories
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        storageService: sl<StorageService>(),
      ),
    );
    sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        remoteDataSource: sl<UserRemoteDataSource>(),
      ),
    );

    // Cubits
    sl.registerLazySingleton<AuthenticationCubit>(
      () => AuthenticationCubit(sl<AuthRepository>(), sl<UserRepository>()),
    );
  }
}
