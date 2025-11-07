import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 260,
        color: Colors.grey[800],
        child: Image.asset(
          'assets/images/product_3.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
