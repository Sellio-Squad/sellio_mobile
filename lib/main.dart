import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/presentation/screens/order_history/cubit/order_history_cubit.dart';
import 'package:sellio_mobile/presentation/screens/store_details/cubit/store_details_cubit.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/navigate/route_manager.dart';
import 'di/injection_container.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/repositories/store_repository.dart';
import 'presentation/cubits/cart/cubit/cart_cubit.dart';
import 'presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'presentation/cubits/user/cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
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
        RepositoryProvider(create: (_) => sl<ProductRepository>()),
        RepositoryProvider(create: (_) => sl<CategoryRepository>()),
        RepositoryProvider(create: (_) => sl<StoreRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<CartCubit>()),
          BlocProvider(create: (_) => sl<FavoritesCubit>()),
          BlocProvider(create: (_) => sl<OrderHistoryCubit>()),
          BlocProvider(create: (_) => sl<UserCubit>()),
          BlocProvider(create: (_) => sl<StoreDetailsCubit>()),
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
        ),
      ),
    );
  }
}
