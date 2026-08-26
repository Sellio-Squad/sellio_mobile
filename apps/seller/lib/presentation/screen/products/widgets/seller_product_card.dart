import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:seller/core/localization/l10n/localization_service.dart';
import 'package:seller/domain/entity/product.dart';

class SellerProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SellerProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SellioRemoteImage(
                  imageUrl: product.images.isNotEmpty ? product.images.first : '',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: textTheme.labelMedium.copyWith(color: colors.title),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _buildBadge(context, product.isUsed),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product.minPrice.toStringAsFixed(2)} ${product.currency}',
                      style: textTheme.labelSmall.copyWith(color: colors.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${context.local.stock}: ${product.stockQuantity}',
                      style: textTheme.labelXSmall.copyWith(color: colors.body),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SellioButton(
                  text: context.local.edit,
                  onTap: onEdit,
                  textStyle: textTheme.labelSmall,
                  backgroundColor: colors.surfaceLow,
                  textColor: colors.primary,
                  prefixSvgPath: AppImages.pencilEdit,
                  prefixIconColor: colors.primary,
                  iconWidth: 16,
                  iconHeight: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SellioButton(
                  text: context.local.delete,
                  onTap: onDelete,
                  textStyle: textTheme.labelSmall,
                  backgroundColor: colors.errorVariant,
                  textColor: colors.red,
                  prefixSvgPath: AppImages.delete,
                  prefixIconColor: colors.red,
                  iconWidth: 16,
                  iconHeight: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, bool isUsed) {
    final theme = SellioTheme.of(context);
    final label = isUsed ? context.local.thrift : context.local.regular;
    final bgColor = isUsed ? theme.colors.secondaryVariant : theme.colors.greenVariant;
    final textColor = isUsed ? theme.colors.secondary : theme.colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: theme.typography.textTheme.labelXSmall.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
