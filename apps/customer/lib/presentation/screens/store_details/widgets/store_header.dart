import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'store_discount_frame.dart';

class StoreHeader extends StatelessWidget {
  final String coverImage;
  final String profileImage;
  final String storeName;
  final String discount;
  final String description;
  final List<String> address;
  final double rating;
  final List<String> subcategories;

  const StoreHeader({
    super.key,
    required this.coverImage,
    required this.profileImage,
    required this.storeName,
    required this.discount,
    required this.description,
    required this.address,
    required this.rating,
    required this.subcategories,
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
                    image: coverImage.startsWith('http')
                        ? NetworkImage(coverImage)
                        : AssetImage(coverImage) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -35,
              left: 32,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: profileImage.startsWith('http')
                      ? NetworkImage(profileImage)
                      : AssetImage(profileImage) as ImageProvider,
                ),
              ),
            ),
            if (discount.isNotEmpty) _buildDiscountTag(),

          ],
        ),
        const SizedBox(height: 44),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              storeName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium.copyWith(
                color: colors.title,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildInfoSection(context),
        ),
      ],
    );
  }

  Widget _buildDiscountTag() {
    return Positioned(
      bottom: 16,
      right: 24,
      child: Transform.scale(
        scale: 1.25,
        child: StoreDiscountTag(discount: discount),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppImages.location, width: 20, height: 20),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                "${address[0]}, ${address[1]}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall.copyWith(
                  color: colors.body,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  rating.toString(),
                  style: textTheme.labelMedium.copyWith(
                    color: colors.body,
                  ),
                ),
                const SizedBox(width: 2),
                SvgPicture.asset(AppImages.rate),
              ],
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                subcategories.join(' • '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall.copyWith(
                  color: colors.body,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: context.theme.typography.textTheme.bodyMedium.copyWith(
            color: context.theme.colors.body,
          ),
        ),
      ],
    );
  }
}