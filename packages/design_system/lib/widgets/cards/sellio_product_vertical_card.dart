import 'package:design_system/constants/app_images.dart';
import 'package:flutter/material.dart';
import '../../themes/sellio_theme.dart';
import '../buttons/favorite_toggle_button.dart';
import '../utils/widgets_utils.dart';

class SellioProductVerticalCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productId;
  final Future<bool> Function()? onFavoriteToggle;
  final bool isFavorite;
  final VoidCallback? onTap;

  const SellioProductVerticalCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productId,
    this.onFavoriteToggle,
    this.isFavorite = false,
    this.onTap,
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
        child: SizedBox(
          width: 160,
          height: 272,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: _buildImage(colors),
                  ),
                  if (onFavoriteToggle != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: FavoriteToggleButton(
                        productId: productId,
                        isFavorite: isFavorite,
                        onToggle: onFavoriteToggle!,
                        size: 32,
                        showBackground: true,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: Text(
                    title,
                    style: textTheme.labelMedium.copyWith(color: colors.title),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: double.infinity,
                  height: 23,
                  child: Text(
                    "\$${formatPrice(price)}",
                    style: textTheme.titleSmall.copyWith(color: colors.primary),
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(colors) {
    return AspectRatio(
      aspectRatio: 1.05,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            return progress == null
                ? child
                : Container(
              width: double.infinity,
              color: colors.surface,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              AppImages.imgEmptyStoreImage,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}