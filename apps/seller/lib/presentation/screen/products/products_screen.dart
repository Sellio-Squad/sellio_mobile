import 'package:flutter/material.dart';

import '../../../core/localization/l10n/localization_service.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(context.local.products)),
    );
  }
}
