import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'di/injection_container.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/navigate/route_manager.dart';
import 'core/navigate/navigation_extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDI();

  runApp(
    BlocProvider(
      create: (context) => LocaleCubit(sl<SharedPreferences>()),
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AuthenticationCubit>()),
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
                    return BlocListener<AuthenticationCubit,
                        AuthenticationState>(
                      listener: (context, state) {
                        if (state is RequireLogin || state is Guest) {
                          context.navigator.pushLogin();
                        } else if (state is LoggedIn) {
                          context.navigator.goToHome();
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
