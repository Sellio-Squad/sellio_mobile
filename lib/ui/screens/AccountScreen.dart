import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Account Screen',
        style: context.theme.typography.textTheme.headlineLarge.copyWith(
          color: context.theme.colors.primary,
        ),
      ),
    );
  }
}