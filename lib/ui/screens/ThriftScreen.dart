import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class ThriftScreen extends StatelessWidget {
  const ThriftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Thrift Screen',
        style: context.theme.typography.textTheme.headlineLarge.copyWith(
          color: context.theme.colors.primary,
        ),
      ),
    );
  }
}