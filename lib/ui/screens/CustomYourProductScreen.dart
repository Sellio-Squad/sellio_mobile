import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class CostumYourProductScreen extends StatefulWidget {
  const CostumYourProductScreen({super.key});

  @override
  State<CostumYourProductScreen> createState() =>
      _CostumYourProductScreenState();
}

class _CostumYourProductScreenState extends State<CostumYourProductScreen> {
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
