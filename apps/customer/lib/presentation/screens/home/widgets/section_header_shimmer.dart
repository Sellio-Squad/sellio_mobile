import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:design_system/design_system.dart';


class SectionHeaderShimmer extends StatelessWidget {
  const SectionHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8,horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: colors.surfaceLow,
            highlightColor: colors.surface,
            child: Container(
              width: 120,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: colors.surfaceLow,
            highlightColor: colors.surface,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
