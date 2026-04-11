import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppImages.locationPin, width: 20, height: 20),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                location,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall.copyWith(color: colors.body),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colors.surfaceHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tag,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall.copyWith(color: colors.body),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }
}