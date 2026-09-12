import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final int starCount;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 14,
    this.starCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        final isFilled = index < rating.round();
        return Padding(
          padding: const EdgeInsets.only(right: 1),
          child: Icon(
            isFilled ? Icons.star : Icons.star_border,
            color: colors.secondary,
            size: size,
          ),
        );
      }),
    );
  }
}