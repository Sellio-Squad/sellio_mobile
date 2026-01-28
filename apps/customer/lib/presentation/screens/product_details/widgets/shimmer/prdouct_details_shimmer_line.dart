import 'package:flutter/material.dart';

class ProductDetailsShimmerLine extends StatelessWidget {
  final double height;
  final double width;
  final colors;
  final double radius;

  const ProductDetailsShimmerLine({
    super.key,
    required this.height,
    required this.width,
    required this.colors,
    this.radius = 6,
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
