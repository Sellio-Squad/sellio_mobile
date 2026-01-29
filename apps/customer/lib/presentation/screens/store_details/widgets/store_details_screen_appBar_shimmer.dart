import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class StoreAppbarShimmer extends StatelessWidget {
  final double height;
  final double width;

  const StoreAppbarShimmer(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Shimmer.fromColors(
      baseColor: colors.surface,
      highlightColor: colors.surfaceLow,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: colors.surfaceHigh,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
