import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/l10n/app_localizations.dart';
import 'core/navigate/route_manager.dart';
import 'di/injection_container.dart';
import 'domain/repository/category_repository.dart';
import 'domain/repository/product_repository.dart';
import 'domain/repository/store_repository.dart';
import 'presentation/screen/main/cubit/store_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        RepositoryProvider(create: (_) => sl<UserRepository>()),
        RepositoryProvider(create: (_) => sl<CountryRepository>()),
        RepositoryProvider(create: (_) => sl<StoreRepository>()),
        RepositoryProvider(create: (_) => sl<CategoryRepository>()),
        RepositoryProvider(create: (_) => sl<ProductRepository>()),
        RepositoryProvider(create: (_) => sl<ImagePickerService>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AuthenticationCubit>()),
          BlocProvider(create: (_) => sl<StoreCubit>()),
        ],
        child: Builder(
          builder: (context) {
            return BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, localeState) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  routerConfig: RouteGenerator.router,
                  title: 'Sellio Seller',
                  locale: localeState.locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    AuthLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: LocaleCubit.supportedLocales,
                  builder: (context, child) {
                    return child!;
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
