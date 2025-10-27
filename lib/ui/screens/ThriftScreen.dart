import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';

class ThriftScreen extends StatefulWidget {
  const ThriftScreen({super.key});

  @override
  State<ThriftScreen> createState() => _ThriftScreenState();
}

class _ThriftScreenState extends State<ThriftScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SellioAppBar(
            title: 'Thrift',
          showNotificationIcon: false,
        ),

    );
  }
}
