import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';

class ProductHorizontalCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String? originalPrice;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductHorizontalCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    this.originalPrice,
    this.count = 0,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Material(
      color: colors.surfaceLow,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 89,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall.copyWith(color: colors.title),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: textTheme.labelXSmall.copyWith(color: colors.body),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      count == 0
                          ? _buildSingleCartButton(context)
                          : _buildCounter(context),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          if (originalPrice != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Text(
                                originalPrice!,
                                style: textTheme.titleSmall.copyWith(
                                  color: colors.hint,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                          Text(
                            price,
                            style: textTheme.titleSmall
                                .copyWith(color: colors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 12),
              child: _buildImage(colors),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleCartButton(BuildContext context) {
    final colors = SellioTheme
        .of(context)
        .colors;
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: colors.primaryVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onIncrement,
          child: SvgPicture.asset(
            Assets.cart,
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
    );
  }

  Widget _buildCounter(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Container(
      width: 104,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: colors.surfaceLow,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onDecrement,
                child: SvgPicture.asset(
                  Assets.remove,
                  colorFilter: ColorFilter.mode(
                    colors.body,
                    BlendMode.srcIn,
                  ),
                  width: 16,
                  height: 16,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Text(
            count.toString().padLeft(2, '0'),
            style: textTheme.labelSmall.copyWith(
              color: colors.title,
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: colors.primaryVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onIncrement,
                child: SvgPicture.asset(
                  Assets.add,
                  colorFilter: ColorFilter.mode(
                    colors.primary,
                    BlendMode.srcIn,
                  ),
                  width: 16,
                  height: 16,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(colors) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        width: 88,
        height: 88,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          return progress == null
              ? child
              : Container(
            width: 88,
            height: 88,
            color: colors.surface,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 88,
            height: 88,
            color: colors.surface,
            child: const Icon(Icons.broken_image),
          );
        },
      ),
    );
  }
}
