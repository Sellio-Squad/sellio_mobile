import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import 'screens/auth/login.dart';


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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sellio app',
      home: const LoginScreen(),
    );
  }
}