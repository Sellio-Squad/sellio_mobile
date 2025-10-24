import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sellio app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: Center(
          child: Text(
            'Welcome to Sellio!',
            style: context.theme.typography.textTheme.headlineLarge.copyWith(
              color: context.theme.colors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

