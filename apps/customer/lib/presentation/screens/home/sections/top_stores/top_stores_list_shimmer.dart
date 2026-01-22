import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:design_system/design_system.dart';
import '../../widgets/section_header_shimmer.dart';

class TopStoresShimmer extends StatelessWidget {
  final int itemCount;


  const TopStoresShimmer({
    super.key,
    this.itemCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
      return Column(
        children: [
          // Shimmer for Section Header
          const SectionHeaderShimmer(),
          const SizedBox(height: 8),
          // Shimmer for 2 Store Cards
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                child: SizedBox(
                  width: double.infinity,
                  height: 133,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        left: 8,
                        child: Shimmer.fromColors(
                          baseColor: colors.surface,
                          highlightColor: colors.surfaceLow,
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            child: Container(
                              width: double.infinity,
                              height: 133,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    }
}
