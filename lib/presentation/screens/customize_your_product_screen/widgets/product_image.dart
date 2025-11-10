import 'dart:io';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final File? overlayImage;

  const ProductImage({super.key, this.overlayImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 260,
        color: Colors.grey[200],
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/product_3.webp',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            if (overlayImage != null)
              Positioned(
                bottom: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    overlayImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
