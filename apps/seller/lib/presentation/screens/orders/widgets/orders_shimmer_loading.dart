import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrdersShimmerLoading extends StatelessWidget {
  final int itemCount;

  const OrdersShimmerLoading({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: colors.surface,
            highlightColor: colors.surfaceLow,
            child: Container(
              height: 196,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: colors.surfaceLow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 14,
                          decoration: BoxDecoration(
                            color: colors.surfaceLow,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 72,
                        height: 24,
                        decoration: BoxDecoration(
                          color: colors.surfaceLow,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 140,
                    height: 12,
                    decoration: BoxDecoration(
                      color: colors.surfaceLow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 12,
                              decoration: BoxDecoration(
                                color: colors.surfaceLow,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 72,
                              height: 10,
                              decoration: BoxDecoration(
                                color: colors.surfaceLow,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 48,
                        height: 12,
                        decoration: BoxDecoration(
                          color: colors.surfaceLow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colors.surfaceLow,
                      borderRadius: BorderRadius.circular(8),
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
