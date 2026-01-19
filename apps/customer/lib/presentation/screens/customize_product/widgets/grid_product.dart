import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import '../design_editor_screen.dart';
import 'custom_product_card.dart';

class GridProduct extends StatefulWidget {
  const GridProduct({super.key});

  @override
  State<GridProduct> createState() => _GridProductState();
}

class _GridProductState extends State<GridProduct> {
  final List<Map<String, dynamic>> _products = [
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 1'},
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 2'},
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 3'},
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 4'},
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 5'},
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 6'},
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 7'},
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 8'},
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 9'},
    {'imageUrl': AppImages.cartProduct, 'label': 'Product 10'},
  ];

  void _navigateToDesignEditor(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DesignEditorScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 8,
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              childAspectRatio: 160 / 191,
            ),
            itemBuilder: (context, index) {
              final product = _products[index];
              return CustomProductCard(
                imageUrl: product['imageUrl'],
                title: product['label'],
                onClickProduct: () => _navigateToDesignEditor(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
