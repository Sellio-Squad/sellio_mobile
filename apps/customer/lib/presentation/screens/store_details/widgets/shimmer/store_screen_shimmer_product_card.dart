import 'package:flutter/widgets.dart';
import 'package:sellio_mobile/presentation/screens/store_details/widgets/shimmer/store_screen_shimmer_box.dart';
import 'package:sellio_mobile/presentation/screens/store_details/widgets/shimmer/store_screen_shimmer_line.dart';

class StoreShimmerProductCard extends StatelessWidget {
  const StoreShimmerProductCard({
    super.key,
    required this.colors,
  });

  final colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StoreScreenShimmerBox(
          height: _imageHeight,
          width: _imageWidth,
          colors: colors,
        ),
        const SizedBox(height: _spacingSmall),
        StoreScreenShimmerLine(
          height: _lineHeight,
          width: _titleWidth,
          colors: colors,
        ),
        const SizedBox(height: _spacingXSmall),
        StoreScreenShimmerLine(
          height: _lineHeight,
          width: _priceWidth,
          colors: colors,
        ),
      ],
    );
  }

  static const double _imageHeight = 140;
  static const double _imageWidth = 140;

  static const double _lineHeight = 14;
  static const double _titleWidth = 120;
  static const double _priceWidth = 60;

  static const double _spacingSmall = 8;
  static const double _spacingXSmall = 6;
}
