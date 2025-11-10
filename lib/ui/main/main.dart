import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/app_management/route/route_manager.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/di/injection_container.dart' as di;

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  await di.initAppModule();

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