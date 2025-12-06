import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class CustomProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onClickProduct;

  const CustomProductCard({
  super.key,
  required this.imageUrl,
  required this.title,
  required this.onClickProduct,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickProduct,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.theme.typography.textTheme.labelMedium.copyWith(
                color: context.theme.colors.surfaceLow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
