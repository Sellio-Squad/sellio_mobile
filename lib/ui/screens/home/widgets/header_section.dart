import 'package:flutter/material.dart';

import '../../../../core/design_system/themes/sellio_theme.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return SliverAppBar(
      floating: true,
      backgroundColor: colors.surface,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: textTheme.labelSmall.copyWith(color: colors.body),
          ),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: colors.primary),
              const SizedBox(width: 4),
               Text(
                'New York, USA',
                style: textTheme.labelMedium.copyWith(color: colors.title),
              ),
               Icon(Icons.keyboard_arrow_down, size: 20, color: colors.body),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
          color: colors.title,
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            // Navigate to cart screen
          },
          color: colors.title,
        ),
      ],
    );
  }
}
