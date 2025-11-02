import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import '../../core/design_system/themes/sellio_theme_provider.dart';

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
      title: 'Sellio Preview',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatefulWidget {

  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.surfaceLow,
      appBar: SellioAppBar(
        title: "Notifications",
        showBackButton: true,
      ),
      body: Column(),
    );
  }

}
