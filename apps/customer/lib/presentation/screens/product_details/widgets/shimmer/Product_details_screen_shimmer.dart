import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/shimmer/prdouct_details_shimmer_line.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/shimmer/product_details_shimmer_box.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/shimmer/product_details_shimmer_desc_lines.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: colors.surface,
          highlightColor: colors.surfaceLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          ProductDetailsShimmerBox(
                              height: _boxOneHeight,
                              width: screenWidth * _boxOneWidthRatio,
                              colors: colors),
                          const SizedBox(height: 8),
                          ProductDetailsShimmerBox(
                              height: _boxTwoHeight,
                              width: screenWidth * _boxTwoWidthRatio,
                              colors: colors),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ProductDetailsShimmerBox(
                            height: _boxThreeHeight,
                            width: screenWidth * _boxThreeWidthRatio,
                            colors: colors),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ProductDetailsShimmerLine(
                          height: _linesHeight,
                          width: screenWidth * _lineWidthRatio,
                          colors: colors),
                      const SizedBox(width: 12),
                      ProductDetailsShimmerLine(
                          height: _linesHeight,
                          width: screenWidth * _lineWidthRatio,
                          colors: colors),
                      const Spacer(),
                      ProductDetailsShimmerLine(
                          height: _linesHeight,
                          width: screenWidth * _lineWidthRatio,
                          colors: colors),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProductDetailsShimmerDescLines(
                      lines: _descLinesNumber, colors: colors),
                  ProductDetailsShimmerLine(
                      height: _linesHeight,
                      width: screenWidth * _lineDescWidthRatio,
                      colors: colors),
                  const SizedBox(height: 24),
                  ProductDetailsShimmerBox(
                      height: _boxFourHeight,
                      width: double.infinity,
                      colors: colors),
                ],
              ),
              ProductDetailsShimmerBox(
                  height: _boxFiveHeight,
                  width: double.infinity,
                  colors: colors),
            ],
          ),
        ),
      ),
    );
  }

  static const _boxOneHeight = 100.0;
  static const _boxOneWidthRatio = 0.35;
  static const _boxTwoHeight = 100.0;
  static const _boxTwoWidthRatio = 0.35;
  static const _boxThreeHeight = 200.0;
  static const _boxThreeWidthRatio = 0.6;
  static const _boxFourHeight = 120.0;
  static const _boxFiveHeight = 80.0;
  static const _descLinesNumber = 7;
  static const _linesHeight = 18.0;
  static const _lineWidthRatio = 0.2;
  static const _lineDescWidthRatio = 0.65;
}
