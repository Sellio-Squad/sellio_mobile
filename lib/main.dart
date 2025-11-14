import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sellio_mobile/core/app_management/route/route_manager.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'core/di/injection_container.dart' as di;
import 'package:sellio_mobile/presentation/screens/order_history/order_history_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CartCubit>()),
        BlocProvider(create: (_) => di.sl<FavoritesCubit>()),
        BlocProvider(create: (_) => di.sl<OrderHistoryCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
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
    );
  }
}
