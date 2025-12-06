import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';

class CategoryTabsShimmer extends StatelessWidget {
  const CategoryTabsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Shimmer.fromColors(
              baseColor: colors.surface,
              highlightColor: colors.surfaceLow,
              child: Container(
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}