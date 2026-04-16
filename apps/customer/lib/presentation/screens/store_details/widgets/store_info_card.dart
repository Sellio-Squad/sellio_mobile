import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';

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
            SvgPicture.asset(AppImages.locationPin, width: 20, height: 20),
            const SizedBox(width: 4),
            Text(
              location,
              style: textTheme.labelSmall.copyWith(color: colors.body),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              rating.toString(),
              style: textTheme.labelSmall.copyWith(color: colors.body),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(AppImages.rate, width: 12, height: 12),
          ],
        ),
        const SizedBox(height: 8),
        // Tags Section using Wrap
        Wrap(
          spacing: 6, // horizontal spacing
          runSpacing: 4, // vertical spacing
          children: tags.asMap().entries.map((entry) {
            final index = entry.key;
            final tag = entry.value;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tag,
                  style: textTheme.labelSmall.copyWith(color: colors.body),
                ),
                if (index != tags.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "•",
                      style:
                          textTheme.labelSmall.copyWith(color: colors.stroke),
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }
}
