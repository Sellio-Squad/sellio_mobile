import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class RatingBarItem extends StatelessWidget {
  final int star;
  final int count;
  final int maxCount;

  const RatingBarItem({
    super.key,
    required this.star,
    required this.count,
    required this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = maxCount > 0 ? count / maxCount : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$star',
            style: context.theme.typography.textTheme.labelXSmall.copyWith(
              color: context.theme.colors.body,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: context.theme.colors.stroke,
                borderRadius: BorderRadius.circular(100),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.theme.colors.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}