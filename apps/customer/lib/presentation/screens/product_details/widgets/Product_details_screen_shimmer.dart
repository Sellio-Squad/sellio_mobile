import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

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
                          _box(100, 100, colors),
                          const SizedBox(height: 8),
                          _box(100, 100, colors),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _box(200, 200, colors),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _line(18, 80, colors),
                      const SizedBox(width: 12),
                      _line(18, 80, colors),
                      const Spacer(),
                      _line(18, 80, colors),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 8),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 8),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 8),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 8),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 8),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 8),
                  _line(14, double.infinity, colors),
                  const SizedBox(height: 8),
                  _line(14, 250, colors),
                  const SizedBox(height: 24),
                  _box(120, double.infinity, colors),
                ],
              ),
              _box(80, double.infinity, colors),
            ],
          ),
        ),
      ),
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
