import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/app_management/route/route_manager.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'data/repositories/category_repository_impl.dart';
import 'data/repositories/favorites_repository_impl.dart';
import 'data/repositories/offers_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/store_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/repositories/store_repository.dart';
import 'domain/repositories/offers_repository.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/repositories/favorites_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'presentation/features/cart/cubit/cart_cubit.dart';
import 'presentation/features/favorites/cubit/favorites_cubit.dart';
import 'presentation/features/user/cubit/user_cubit.dart';

void main() {
  runApp(
    SellioThemeProvider(
      brightness: Brightness.light,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
     // Register all repositories
        RepositoryProvider<CategoryRepository>(
          create: (context) => CategoryRepositoryImpl(),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(),
        ),
        RepositoryProvider<StoreRepository>(
          create: (context) => StoreRepositoryImpl(),
        ),
        RepositoryProvider<OffersRepository>(
          create: (context) => OffersRepositoryImpl(),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepositoryImpl(),
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (context) => FavoritesRepositoryImpl(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Global cubits that persist across screens
          BlocProvider(
            create: (context) => CartCubit(
              context.read<CartRepository>(),
            )..loadCart(),
          ),
          BlocProvider(
            create: (context) => FavoritesCubit(
              context.read<FavoritesRepository>(),
            )..loadFavorites(),
          ),
          BlocProvider(
            create: (context) => UserCubit(
              context.read<UserRepository>(),
            )..loadUserInfo(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: RouteGenerator.router,
          debugShowCheckedModeBanner: false,
          title: 'Sellio app',
        ),
      ),
    );
  }
}