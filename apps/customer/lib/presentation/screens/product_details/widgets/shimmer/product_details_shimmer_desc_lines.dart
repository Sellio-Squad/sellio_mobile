import 'package:flutter/material.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/shimmer/prdouct_details_shimmer_line.dart';

class ProductDetailsShimmerDescLines extends StatelessWidget {
  final colors;
  final int lines;

  const ProductDetailsShimmerDescLines({
    super.key,
    required this.colors,
    this.lines = 7,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        lines,
        (_) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ProductDetailsShimmerLine(
              height: 14, width: double.infinity, colors: colors),
        ),
      ),
    );
  }
}
