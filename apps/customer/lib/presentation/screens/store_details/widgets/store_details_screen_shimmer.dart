import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class StoreDetailsShimmer extends StatelessWidget {
  const StoreDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return SizedBox.expand(
      child: Shimmer.fromColors(
        baseColor: colors.surface,
        highlightColor: colors.surfaceLow,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _box(180, double.infinity, colors),
                  const SizedBox(height: 16),
                  _line(18, 220, colors),
                  const SizedBox(height: 8),
                  _line(14, 140, colors),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _box(20, 60, colors),
                      const SizedBox(width: 8),
                      _box(20, 60, colors),
                      const SizedBox(width: 8),
                      _box(20, 60, colors),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 6),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 6),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 6),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 6),
                  _line(14, 260, colors),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _line(18, 160, colors),
                      const Spacer(),
                      _line(18, 24, colors),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Row(
              children: [
                _productCard(colors),
                const SizedBox(width: 12),
                _productCard(colors),
                const SizedBox(width: 12),
                _partialProductCard(colors),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _productCard(colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _box(140, 140, colors),
        const SizedBox(height: 8),
        _line(14, 120, colors),
        const SizedBox(height: 6),
        _line(14, 60, colors),
      ],
    );
  }

  Widget _partialProductCard(colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _box(140, 90, colors),
        const SizedBox(height: 8),
        _line(14, 70, colors),
        const SizedBox(height: 6),
        _line(14, 40, colors),
      ],
    );
  }

  Widget _box(double height, double width, colors) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: colors.surfaceHigh,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _line(double height, double width, colors) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: colors.surfaceHigh,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
