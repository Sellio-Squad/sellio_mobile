import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:sellio_mobile/presentation/screens/store_details/widgets/shimmer/store_screen_shimmer_box.dart';
import 'package:sellio_mobile/presentation/screens/store_details/widgets/shimmer/store_screen_shimmer_line.dart';
import 'package:sellio_mobile/presentation/screens/store_details/widgets/shimmer/store_screen_shimmer_part_product_card.dart';
import 'package:sellio_mobile/presentation/screens/store_details/widgets/shimmer/store_screen_shimmer_product_card.dart';
import 'package:shimmer/shimmer.dart';

class StoreDetailsShimmer extends StatelessWidget {
  const StoreDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox.expand(
      child: Shimmer.fromColors(
        baseColor: colors.surface,
        highlightColor: colors.surfaceLow,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _spacingXLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _storeHeader(colors, screenWidth),
                  const SizedBox(height: _spacingXLarge),
                  _titleBoxes(colors, screenWidth),
                  const SizedBox(height: _spacingXLarge),
                  _descriptionLines(colors, linesCount: _descLinesCount),
                  const SizedBox(height: _spacingXLarge),
                  _productsTitle(colors, screenWidth),
                  const SizedBox(height: _spacingXLarge),
                ],
              ),
            ),
            _productsCards(colors),
          ],
        ),
      ),
    );
  }

  Widget _descriptionLines(
    colors, {
    required int linesCount,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
          linesCount,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: _spacingSmall),
            child: StoreScreenShimmerLine(
              height: _lineHeight,
              width: double.infinity,
              colors: colors,
            ),
          ),
        ),
        StoreScreenShimmerLine(
          height: _lineHeight,
          width: double.infinity,
          colors: colors,
        ),
      ],
    );
  }

  Widget _productsCards(colors) {
    return Row(children: [
      StoreShimmerProductCard(colors: colors),
      const SizedBox(width: _spacingLarge),
      StoreShimmerProductCard(colors: colors),
      const SizedBox(width: _spacingLarge),
      StoreShimmerPartialProductCard(colors: colors),
    ]);
  }

  Widget _titleBoxes(colors, double screenWidth) {
    return Row(
      children: [
        StoreScreenShimmerLine(
            height: _lineHeight,
            width: screenWidth * _titleBoxWidthRatio,
            colors: colors),
        const SizedBox(width: _spacingMedium),
        StoreScreenShimmerLine(
            height: _lineHeight,
            width: screenWidth * _titleBoxWidthRatio,
            colors: colors),
        const SizedBox(width: _spacingMedium),
        StoreScreenShimmerLine(
            height: _lineHeight,
            width: screenWidth * _titleBoxWidthRatio,
            colors: colors),
      ],
    );
  }

  Widget _productsTitle(colors, double screenWidth) {
    return Row(
      children: [
        StoreScreenShimmerLine(
            height: _lineHeight,
            width: screenWidth * _productTitleWidthRatio,
            colors: colors),
        const Spacer(),
        StoreScreenShimmerLine(
            height: _lineHeight,
            width: screenWidth * _productTitleTwoWidthRatio,
            colors: colors),
      ],
    );
  }

  Widget _storeHeader(colors, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StoreScreenShimmerBox(
            height: _storeBoxHeight, width: double.infinity, colors: colors),
        const SizedBox(height: _spacingXLarge),
        StoreScreenShimmerLine(
            height: _lineHeight,
            width: screenWidth * _storeHeaderWidthRatio,
            colors: colors),
        const SizedBox(height: _spacingMedium),
        StoreScreenShimmerLine(
            height: _lineHeight,
            width: screenWidth * _storeHeaderTwoWidthRatio,
            colors: colors),
      ],
    );
  }

  static const double _spacingSmall = 6;
  static const double _spacingMedium = 8;
  static const double _spacingLarge = 12;
  static const double _spacingXLarge = 16;

  static const int _descLinesCount = 4;
  static const double _titleBoxWidthRatio = 0.20;
  static const double _productTitleWidthRatio = 0.40;
  static const double _productTitleTwoWidthRatio = 0.10;

  static const double _storeBoxHeight = 180;
  static const double _storeHeaderWidthRatio = 0.50;
  static const double _storeHeaderTwoWidthRatio = 0.30;

  static const double _lineHeight = 14;
}
