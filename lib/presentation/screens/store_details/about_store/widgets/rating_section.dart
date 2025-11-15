import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';
import 'rating_bar_item.dart';

class RatingSection extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingCounts;

  const RatingSection({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingCounts,
  });

  @override
  Widget build(BuildContext context) {
    final maxCount = ratingCounts.values.reduce((a, b) => a > b ? a : b);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side - Average rating
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: context.theme.typography.textTheme.headlineMedium
                    .copyWith(color: context.theme.colors.title),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  final isFilled = index < averageRating.round();
                  return Icon(
                    isFilled ? Icons.star : Icons.star_border,
                    color: context.theme.colors.secondary,
                    size: 12,
                  );
                }),
              ),
              const SizedBox(height: 8),
              Text(
                context.local.total_reviews(totalReviews),
                style: context.theme.typography.textTheme.labelXSmall.copyWith(
                  color: context.theme.colors.hint,
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: context.theme.colors.stroke,
            ),
          ),

          // Right side - Rating bars
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int star in [5, 4, 3, 2, 1])
                  RatingBarItem(
                    star: star,
                    count: ratingCounts[star] ?? 0,
                    maxCount: maxCount,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
