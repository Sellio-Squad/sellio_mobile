import 'dart:ui';
import 'package:design_system/widgets/sellio_remote_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/constants/app_images.dart';
import '../../themes/sellio_colors.dart';
import '../../themes/sellio_theme.dart';
import '../utils/widgets_utils.dart';

class SellioProductVerticalCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productId;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const SellioProductVerticalCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productId,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: _buildImage(colors),
                ),
                if (onFavoriteToggle != null) _buildFavoriteButton(colors),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                title,
                style: textTheme.labelMedium.copyWith(color: colors.title),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "\$${formatPrice(price)}",
                style: textTheme.titleSmall.copyWith(color: colors.primary),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(SellioColorScheme colors) {
    return AspectRatio(
      aspectRatio: 1.05,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SellioRemoteImage(imageUrl: imageUrl,width: double.infinity),
      ),
    );
  }

  Widget _buildFavoriteButton(SellioColorScheme colors) {
    return Positioned(
      top: 4,
      right: 4,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0x99FFFFFF),
              shape: BoxShape.circle,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onFavoriteToggle,
                child: Center(
                  child: SvgPicture.asset(
                    isFavorite
                        ? AppImages.favorite
                        : AppImages.unselectedFavorite,
                    colorFilter: ColorFilter.mode(
                      colors.primary,
                      BlendMode.srcIn,
                    ),
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
