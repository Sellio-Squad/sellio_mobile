import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/section_header_shimmer.dart';

class ProductsListShimmer extends StatelessWidget {
  const ProductsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header shimmer
        const SectionHeaderShimmer(),
        const SizedBox(height: 8),
        // Products list shimmer
        SizedBox(
          height: 272,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return const SellioProductVerticalCardShimmer();
            },
          ),
        ),
      ],
    );
  }
}

class ProductsListShimmerVertical extends StatelessWidget {
  const ProductsListShimmerVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
        childAspectRatio: 170 / 272,
      ),
      itemBuilder: (context, index) {
        return SellioProductVerticalCardShimmer();
      },
    );
  }
}

class SellioProductVerticalCardShimmer extends StatelessWidget {
  const SellioProductVerticalCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;

    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image shimmer with favorite button
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                child: AspectRatio(
                  aspectRatio: 1.05,
                  child: Shimmer.fromColors(
                    baseColor: colors.surfaceLow,
                    highlightColor: colors.surface,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              // Favorite button shimmer
              Positioned(
                top: 8,
                right: 8,
                child: Shimmer.fromColors(
                  baseColor: colors.surfaceLow,
                  highlightColor: colors.surface,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Title shimmer (2 lines)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: colors.surfaceLow,
                  highlightColor: colors.surface,
                  child: Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: colors.surfaceLow,
                  highlightColor: colors.surface,
                  child: Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Price shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Shimmer.fromColors(
              baseColor: colors.surfaceLow,
              highlightColor: colors.surface,
              child: Container(
                height: 16,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const Spacer(),
          // Add button shimmer
          Padding(
            padding: const EdgeInsets.all(4),
            child: Shimmer.fromColors(
              baseColor: colors.surfaceLow,
              highlightColor: colors.surface,
              child: Container(
                width: double.infinity,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
