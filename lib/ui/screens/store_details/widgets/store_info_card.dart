import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/design_system/constants/assets.dart';
import '../../../../core/design_system/themes/sellio_theme.dart';

class StoreInfoOverview extends StatelessWidget {
  final String location;
  final double rating;
  final List<String> tags;
  final String description;

  const StoreInfoOverview({
    super.key,
    required this.location,
    required this.rating,
    required this.tags,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(Assets.locationPin, width: 20, height: 20),
            SizedBox(width: 4),
            Text(
              location,
              style: textTheme.labelSmall.copyWith(color: colors.body),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Row(
              children: [
                Text(
                  rating.toString(),
                  style: textTheme.labelSmall.copyWith(color: colors.body),
                ),
                const SizedBox(width: 4),
                SvgPicture.asset(Assets.rate, width: 12, height: 12),
              ],
            ),

            const SizedBox(width: 8),

            ...tags.asMap().entries.map((entry) {
              final index = entry.key;
              final tag = entry.value;
              return Row(
                children: [
                  Text(
                    tag,
                    style: textTheme.labelSmall.copyWith(color: colors.body),
                  ),
                  if (index != tags.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "•",
                        style: textTheme.labelSmall.copyWith(
                          color: colors.stroke,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),

        SizedBox(height: 8),
        Text(
          description,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }
}
