import 'package:flutter/material.dart';

import '../../../../core/design_system/themes/sellio_theme.dart';
import 'store_discount_frame.dart';

class StoreHeader extends StatelessWidget {
  final String coverImage;
  final String profileImage;
  final String storeName;
  final String discount;

  const StoreHeader({
    super.key,
    required this.coverImage,
    required this.profileImage,
    required this.storeName,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(coverImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Floating Profile Image
            Positioned(
              bottom: -35,
              left: 32,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage(profileImage),
                ),
              ),
            ),

            Positioned(
              bottom: 16,
              right: 24,
              child: Transform.scale(
                scale: 1.25,
                child: StoreDiscountTag(discount: discount),
              ),
            ),
          ],
        ),

        const SizedBox(height: 44),

        // Store Name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              storeName,
              style: textTheme.titleMedium.copyWith(
                color: colors.title,
              ),
            ),
          ),
        ),
      ],
    );
  }
}