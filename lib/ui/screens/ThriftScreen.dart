import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class ThriftScreen extends StatelessWidget {
  const ThriftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thrift',
          style: context.theme.typography.textTheme.titleMedium.copyWith(
            color: context.theme.colors.title,
          ),
        ),
      ),
    );
  }
}