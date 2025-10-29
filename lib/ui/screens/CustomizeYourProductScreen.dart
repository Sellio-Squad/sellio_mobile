import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class CustomizeYourProductScreen extends StatefulWidget {
  const CustomizeYourProductScreen({super.key});

  @override
  State<CustomizeYourProductScreen> createState() =>
      _CustomizeYourProductScreenState();
}

class _CustomizeYourProductScreenState
    extends State<CustomizeYourProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Custom Yuor Product Screen',
        style: context.theme.typography.textTheme.headlineLarge.copyWith(
          color: context.theme.colors.primary,
        ),
      ),
    );
  }
}
