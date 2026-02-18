import 'package:flutter/material.dart';

import '../themes/sellio_theme.dart';

class DashedDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final double dashWidth;
  final double dashSpacing;

  const DashedDivider({
    super.key,
    this.height = 1,
    this.color,
    this.dashWidth = 12,
    this.dashSpacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final color = this.color ?? theme.colors.stroke.withAlpha(55);

    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount =
            (boxWidth / (dashWidth + dashSpacing)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
