import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SellioProductHorizontalCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? description;
  final String price;
  final String? originalPrice;
  final int? count;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const SellioProductHorizontalCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.description,
    this.originalPrice,
    this.count,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Material(
      color: colors.surfaceLow,
      borderRadius: BorderRadius.circular(8),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 89,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(colors),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: textTheme.titleSmall.copyWith(color: colors.title),
                              maxLines: (description == null) ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                if (originalPrice != null)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Text(
                                      "\$${formatPrice(originalPrice!)}",
                                      style: textTheme.titleSmall.copyWith(
                                        color: colors.hint,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                                Text(
                                  "\$${formatPrice(price)}",
                                  style: textTheme.titleSmall.copyWith(color: colors.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            description!,
                            style: textTheme.labelXSmall.copyWith(color: colors.body),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Show counter if count and callbacks are provided, otherwise single button placeholder
                            if (count != null && onIncrement != null && onDecrement != null)
                              _buildCounter(context)
                            else if (onIncrement != null)
                              _buildSingleCartButton(context),

                            if (onRemove != null) _buildRemoveProductButton(context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSingleCartButton(BuildContext context) {
    final colors = SellioTheme.of(context).colors;
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
            AppImages.cart,
            colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: colors.surfaceLow,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onDecrement,
                child: SvgPicture.asset(
                  AppImages.remove,
                  colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
                  width: 16,
                  height: 16,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Text(
            count?.toString().padLeft(2, '0') ?? '00',
            style: textTheme.labelSmall.copyWith(color: colors.title),
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
                  AppImages.add,
                  colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
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

  Widget _buildRemoveProductButton(BuildContext context) {
    final colors = SellioTheme.of(context).colors;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: colors.primaryVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onRemove,
          child: Center(
            child: SvgPicture.asset(
              AppImages.delete,
              colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
              width: 20,
              height: 20,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(SellioColorScheme colors) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        width: 89,
        height: 89,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          return progress == null
              ? child
              : Container(
            width: 88,
            height: 88,
            color: colors.surface,
            child: const Center(child: CircularProgressIndicator()),
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