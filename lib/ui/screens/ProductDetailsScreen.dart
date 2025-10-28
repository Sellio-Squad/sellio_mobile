import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SellioAppBar(
        title: 'Fresh Lemon Cake',
      ),
    );
  }
}