import 'package:authentication/domain/repository/auth_repository.dart';
import 'package:authentication/domain/repository/user_repository.dart';
import 'package:authentication/l10n/auth_localizations.dart';
import 'package:authentication/presentation/cubits/auth/authentication_cubit.dart';
import 'package:authentication/presentation/cubits/auth/authentication_state.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/l10n/app_localizations.dart';
import 'core/navigate/route_manager.dart';
import 'di/injection_container.dart';
import 'domain/repository/category_repository.dart';
import 'domain/repository/favorites_repository.dart';
import 'domain/repository/product_repository.dart';
import 'domain/repository/store_repository.dart';
import 'firebase_options.dart';
import 'presentation/cubits/cart/cubit/cart_cubit.dart';
import 'presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'presentation/screen/order_history/cubit/order_history_cubit.dart';
import 'presentation/screen/store_details/cubit/store_details_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final prefs = await SharedPreferences.getInstance();
  await init();

  runApp(
    BlocProvider(
      create: (context) => LocaleCubit(prefs),
      child: SellioThemeProvider(
        brightness: Brightness.light,
        child: const MyApp(),
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
                    AuthLocalizations.delegate,
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
