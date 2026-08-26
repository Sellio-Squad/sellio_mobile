import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsShimmerLoading extends StatelessWidget {
  final int itemCount;

  const ProductsShimmerLoading({
    super.key,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: colors.surface,
            highlightColor: colors.surfaceLow,
            child: Container(
              height: 104,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: colors.surfaceLow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              height: 14,
                              decoration: BoxDecoration(
                                color: colors.surfaceLow,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 18,
                              decoration: BoxDecoration(
                                color: colors.surfaceLow,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 50,
                          height: 16,
                          decoration: BoxDecoration(
                            color: colors.surfaceLow,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 80,
                          height: 12,
                          decoration: BoxDecoration(
                            color: colors.surfaceLow,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
