import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sellio_mobile/core/app_management/route/route_manager.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'core/di/injection_container.dart' as di;
import 'package:sellio_mobile/presentation/screens/order_history/OrderHistoryCubit.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/favorites_repository.dart';
import 'domain/repositories/offers_repository.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/repositories/store_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'l10n/app_localizations.dart';
import 'presentation/cubits/cart/cubit/cart_cubit.dart';
import 'presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'presentation/cubits/user/cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
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
        RepositoryProvider<CategoryRepository>(
          create: (_) => di.sl<CategoryRepository>(),
        ),
        RepositoryProvider<ProductRepository>(
          create: (_) => di.sl<ProductRepository>(),
        ),
        RepositoryProvider<StoreRepository>(
          create: (_) => di.sl<StoreRepository>(),
        ),
        RepositoryProvider<OffersRepository>(
          create: (_) => di.sl<OffersRepository>(),
        ),
        RepositoryProvider<CartRepository>(
          create: (_) => di.sl<CartRepository>(),
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (_) => di.sl<FavoritesRepository>(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => di.sl<UserRepository>(),
        ),
        RepositoryProvider<OrderRepository>(
          create: (_) => di.sl<OrderRepository>(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
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
          BlocProvider<OrderHistoryCubit>(
            create: (context) => OrderHistoryCubit(
              context.read<OrderRepository>(),
            )..loadOrders(),
          ),
          BlocProvider(
            create: (context) => UserCubit(
              context.read<UserRepository>(),
            )..loadUserInfo(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: RouteGenerator.router,
          title: 'Sellio app',

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          locale: WidgetsBinding.instance.window.locale,
        )
        ,
      ),
    );
  }
}
