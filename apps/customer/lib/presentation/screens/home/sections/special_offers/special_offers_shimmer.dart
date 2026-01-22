import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/section_header_shimmer.dart';

class SpecialOffersShimmer extends StatelessWidget {
  final double height;

  const SpecialOffersShimmer({super.key, this.height = 200});

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    return Column(children: [
      // Shimmer for Section Header
      const SectionHeaderShimmer(),
      const SizedBox(height: 8),
      SizedBox(
        height: height,
        width: double.infinity,
        child: Shimmer.fromColors(
          baseColor: colors.surface,
          highlightColor: colors.surfaceLow,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      )
    ]);
  }
}
