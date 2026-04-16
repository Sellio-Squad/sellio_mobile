import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../sellio_remote_image.dart';

abstract class _Colors {
  static const Color frostedWhite = Color(0x99FFFFFF);
}

abstract class _Dimensions {
  static const double cardRadius = 12;
  static const double thumbnailSize = 44;
  static const double counterHeight = 40;
  static const double iconButtonSize = 32;
  static const double contentPadding = 10;
  static const double overlayPadding = 10;
  static const double spacingSmall = 6;
  static const double spacingMedium = 8;
  static const double spacingLarge = 10;
  static const double thumbnailSeparator = 5;
  static const double smallRadius = 4;
  static const double mediumRadius = 6;
  static const double buttonRadius = 8;
  static const double iconSize = 16;
  static const double favIconSize = 20;
}

abstract class _Strings {
  static const String addToCart = 'ADD TO CART';
  static const String outOfStock = 'Out of Stock';
  static const String removeFavorite = 'Remove from favourites';
  static const String addFavorite = 'Add to favourites';
}

/// This widget must be placed inside a parent with bounded height
/// (e.g., [SizedBox], [GridView] with fixed cross-axis extent) because
/// the image section uses [Expanded] to fill available vertical space.
class SellioProductVerticalCard extends StatefulWidget {
  // ── Required ─────────────────────────────────────────────────────────────
  final String imageUrl;
  final String title;
  final String price;
  // ── Optional – gallery ────────────────────────────────────────────────────
  final List<String>? thumbnailImages;
  final int selectedThumbnailIndex;
  final ValueChanged<int>? onThumbnailSelected;

  // ── Optional – pricing ───────────────────────────────────────────────────
  final String? originalPrice;
  final String? discountText;

  // ── Optional – metadata ──────────────────────────────────────────────────
  final String? category;

  // ── Optional – stock status ──────────────────────────────────────────────
  final bool isOutOfStock;

  // ── Optional – interaction ───────────────────────────────────────────────
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onAddToCart;

  // ── Optional – in-cart counter ───────────────────────────────────────────
  final int? count;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const SellioProductVerticalCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.thumbnailImages,
    this.selectedThumbnailIndex = 0,
    this.onThumbnailSelected,
    this.originalPrice,
    this.discountText,
    this.category,
    this.isOutOfStock = false,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
    this.onAddToCart,
    this.count,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  State<SellioProductVerticalCard> createState() =>
      _SellioProductVerticalCardState();
}

class _SellioProductVerticalCardState extends State<SellioProductVerticalCard> {
  String get _activeImageUrl {
    final thumbs = widget.thumbnailImages;
    if (thumbs != null && thumbs.isNotEmpty) {
      final maxIndex = thumbs.length - 1;
      final clampedIndex = widget.selectedThumbnailIndex.clamp(
        0,
        maxIndex.clamp(0, maxIndex),
      );
      return thumbs[clampedIndex];
    }
    return widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    final int effectiveCount = widget.count ?? 0;
    final bool showCounter = effectiveCount > 0;

    return Material(
      color: colors.surfaceLow,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colors.stroke, width: 1),
        borderRadius: BorderRadius.circular(_Dimensions.cardRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Main image + overlays ─────────────────────────────────
            Expanded(
              child: RepaintBoundary(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildMainImage(theme),
                    if (widget.discountText != null)
                      Positioned(
                        top: _Dimensions.overlayPadding,
                        left: _Dimensions.overlayPadding,
                        child: DiscountTag(discountText: widget.discountText!),
                      ),
                    if (widget.onFavoriteToggle != null)
                      Positioned(
                        top: _Dimensions.overlayPadding,
                        right: _Dimensions.overlayPadding,
                        child: _buildFavoriteButton(colors),
                      ),
                  ],
                ),
              ),
            ),

            // ── Content below image ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(_Dimensions.contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.thumbnailImages != null &&
                      widget.thumbnailImages!.isNotEmpty) ...[
                    _buildThumbnailStrip(colors),
                    const SizedBox(height: _Dimensions.spacingMedium),
                  ],

                  Text(
                    widget.title,
                    style: textTheme.labelMedium.copyWith(color: colors.title),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  if (widget.category != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      widget.category!.toUpperCase(),
                      style: textTheme.labelXSmall.copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  const SizedBox(height: _Dimensions.spacingSmall),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildPriceRow(colors, textTheme)),
                      if (showCounter)
                        RepaintBoundary(
                          child: _buildCounter(
                            colors,
                            textTheme,
                            effectiveCount,
                          ),
                        )
                      else
                        _buildAddToCartButton(colors),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainImage(SellioTheme theme) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SellioRemoteImage(
          key: ValueKey(_activeImageUrl),
          imageUrl: _activeImageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        if (widget.isOutOfStock)
          ColoredBox(
            color: theme.colors.surfaceHigh.withOpacity(0.7),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: _Dimensions.spacingMedium,
                  vertical: _Dimensions.smallRadius,
                ),
                decoration: BoxDecoration(
                  color: theme.colors.title.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(_Dimensions.smallRadius),
                ),
                child: Semantics(
                  label: _Strings.outOfStock,
                  child: Text(
                    _Strings.outOfStock,
                    style: theme.typography.textTheme.labelSmall.copyWith(
                      color: theme.colors.onPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildThumbnailStrip(SellioColorScheme colors) {
    final thumbs = widget.thumbnailImages!;
    return SizedBox(
      height: _Dimensions.thumbnailSize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: thumbs.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: _Dimensions.thumbnailSeparator),
        itemBuilder: (context, index) {
          final isSelected = index == widget.selectedThumbnailIndex;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              widget.onThumbnailSelected?.call(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: _Dimensions.thumbnailSize,
              height: _Dimensions.thumbnailSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_Dimensions.mediumRadius),
                border: Border.all(
                  color: isSelected ? colors.secondary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_Dimensions.smallRadius),
                child: SellioRemoteImage(
                  imageUrl: thumbs[index],
                  width: _Dimensions.thumbnailSize,
                  height: _Dimensions.thumbnailSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceRow(SellioColorScheme colors, SellioTextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // Trusting caller formats currency directly moving forward
        Text(
          widget.price,
          style: textTheme.titleSmall.copyWith(color: colors.primary),
        ),
        if (widget.originalPrice != null) ...[
          const SizedBox(width: 6),
          Text(
            widget.originalPrice!,
            style: textTheme.labelXSmall.copyWith(
              color: colors.hint,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAddToCartButton(SellioColorScheme colors) {
    return Semantics(
      label: widget.isOutOfStock ? _Strings.outOfStock : _Strings.addToCart,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.isOutOfStock ? null : widget.onAddToCart,
        child: Container(
          width: _Dimensions.iconButtonSize,
          height: _Dimensions.iconButtonSize,
          decoration: BoxDecoration(
            color: widget.isOutOfStock ? colors.disabled : colors.primary,
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: Center(
            child: SvgPicture.asset(
              AppImages.cartSmall,
              colorFilter: ColorFilter.mode(
                widget.isOutOfStock ? colors.hint : colors.onPrimary,
                BlendMode.srcIn,
              ),
              width: _Dimensions.iconSize,
              height: _Dimensions.iconSize,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(
    SellioColorScheme colors,
    SellioTextTheme textTheme,
    int effectiveCount,
  ) {
    return SizedBox(
      height: _Dimensions.iconButtonSize,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCounterButton(
            icon: effectiveCount == 1 ? AppImages.delete : AppImages.remove,
            iconColor: colors.body,
            bgColor: colors.surface,
            onTap: widget.onDecrement,
            semanticLabel: 'Decrease quantity',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              effectiveCount.toString().padLeft(2, '0'),
              style: textTheme.labelMedium.copyWith(color: colors.title),
            ),
          ),
          _buildCounterButton(
            icon: AppImages.add,
            iconColor: colors.primary,
            bgColor: colors.primaryVariant,
            onTap: widget.onIncrement,
            semanticLabel: 'Increase quantity',
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required String icon,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback? onTap,
    required String semanticLabel,
  }) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: _Dimensions.iconButtonSize,
          height: _Dimensions.iconButtonSize,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(_Dimensions.mediumRadius),
          ),
          clipBehavior: Clip.antiAlias,
          child: Center(
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: _Dimensions.iconSize,
              height: _Dimensions.iconSize,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(SellioColorScheme colors) {
    return Semantics(
      label: widget.isFavorite ? _Strings.removeFavorite : _Strings.addFavorite,
      button: true,
      child: ClipOval(
        child: ColoredBox(
          color: _Colors.frostedWhite,
          child: SizedBox(
            width: _Dimensions.iconButtonSize,
            height: _Dimensions.iconButtonSize,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: widget.onFavoriteToggle,
                child: Center(
                  child: SvgPicture.asset(
                    widget.isFavorite
                        ? AppImages.favorite
                        : AppImages.unselectedFavorite,
                    colorFilter: ColorFilter.mode(
                      colors.primary,
                      BlendMode.srcIn,
                    ),
                    width: _Dimensions.favIconSize,
                    height: _Dimensions.favIconSize,
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
