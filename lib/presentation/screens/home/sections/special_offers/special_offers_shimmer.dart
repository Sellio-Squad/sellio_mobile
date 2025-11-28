import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/design_system/themes/sellio_theme.dart';
import '../../widgets/section_header_shimmer.dart';

class SpecialOffersShimmer extends StatelessWidget {
  const SpecialOffersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    return Column(
        children: [
          // Shimmer for Section Header
          const SectionHeaderShimmer(),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
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
        ]
    );
  }
}
