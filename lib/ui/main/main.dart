import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/ui/screens/home/home_screen.dart';
import '../screens/main_screen/MainScreen.dart';

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
      home: const MainScreen(),
    );
  }
}