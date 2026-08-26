import 'package:flutter/material.dart';

class ProductDetailsShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final colors;
  final double radius;

  const ProductDetailsShimmerBox({
    super.key,
    required this.height,
    required this.width,
    required this.colors,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: colors.surfaceHigh,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
