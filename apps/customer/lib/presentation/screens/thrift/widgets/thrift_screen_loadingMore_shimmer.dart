import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ThriftLoadingMoreShimmer extends StatelessWidget {
  final int count;
  const ThriftLoadingMoreShimmer({super.key, this.count = 2});

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Shimmer.fromColors(
              baseColor: colors.surface,
              highlightColor: colors.surfaceLow,
              child: Container(
                decoration: BoxDecoration(
                  color: colors.surfaceLow,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            );
          },
          childCount: count,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
      ),
    );
  }
}
