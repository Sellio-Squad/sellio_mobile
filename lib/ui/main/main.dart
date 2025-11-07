import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/app_management/route/route_manager.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';


void main() {
  runApp(
      SellioThemeProvider(
        brightness: Brightness.light,
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig:  RouteGenerator.router,
      debugShowCheckedModeBanner: false,
      title: 'Sellio app',
    );
  }
}