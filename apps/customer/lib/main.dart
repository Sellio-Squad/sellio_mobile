import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:network_inspector/network_inspector.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import 'package:sellio_mobile/presentation/cubits/auth/authentication_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/localization/cubit/locale_cubit.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/navigate/route_manager.dart';
import 'di/injection_container.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/favorites_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/repositories/store_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'presentation/cubits/cart/cubit/cart_cubit.dart';
import 'presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'presentation/screens/order_history/cubit/order_history_cubit.dart';
import 'presentation/screens/store_details/cubit/store_details_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  await init();

  runApp(
    BlocProvider(
      create: (context) => LocaleCubit(prefs),
      child: SellioThemeProvider(
        brightness: Brightness.light,
        child: NetworkInspector(
          enabled: const bool.fromEnvironment('NETWORK_INSPECTOR_ENABLED', defaultValue: false),
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => sl<AuthRepository>()),
        RepositoryProvider(create: (_) => sl<FavoritesRepository>()),
        RepositoryProvider(create: (_) => sl<ProductRepository>()),
        RepositoryProvider(create: (_) => sl<CategoryRepository>()),
        RepositoryProvider(create: (_) => sl<StoreRepository>()),
        RepositoryProvider(create: (_) => sl<UserRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AuthenticationCubit>()),
          BlocProvider(create: (_) => sl<CartCubit>()),
          BlocProvider(create: (_) => sl<FavoritesCubit>()),
          BlocProvider(create: (_) => sl<OrderHistoryCubit>()),
          BlocProvider(create: (_) => sl<StoreDetailsCubit>()),
        ],
        child: Builder(
          builder: (context) {
            return BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, localeState) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  routerConfig: RouteGenerator.router,
                  title: 'Sellio app',
                  locale: localeState.locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: LocaleCubit.supportedLocales,
                  localeResolutionCallback: (locale, supportedLocales) {
                    if (locale != null) {
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode ==
                            locale.languageCode) {
                          return supportedLocale;
                        }
                      }
                    }

                    return supportedLocales.first;
                  },
                  builder: (context, child) {
                    return BlocListener<AuthenticationCubit,
                        AuthenticationState>(
                      listener: (context, state) {
                        if (state is RequireLogin) {
                          if (context.mounted) {
                            context.navigator.pushLogin();
                          }
                        }
                      },
                      child: child!,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}