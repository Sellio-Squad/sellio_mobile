import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../sellio_remote_image.dart';

// Frosted-glass tint used by the favourite button overlay.
const Color _kFrostedWhite = Color(0x99FFFFFF);

abstract class _Dimensions {
  static const double cardRadius = 12;
  static const double thumbnailSize = 44;
  static const double counterHeight = 40;
  static const double iconButtonSize = 32;
  static const double contentPadding = 10;
  static const double overlayPadding = 10;
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
  final String productId;

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
    required this.productId,
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

class _SellioProductVerticalCardState
    extends State<SellioProductVerticalCard> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedThumbnailIndex;
  }

  @override
  void didUpdateWidget(covariant SellioProductVerticalCard old) {
    super.didUpdateWidget(old);
    if (old.selectedThumbnailIndex != widget.selectedThumbnailIndex) {
      _selectedIndex = widget.selectedThumbnailIndex;
    }
  }

  String get _activeImageUrl {
    final thumbs = widget.thumbnailImages;
    if (thumbs != null && thumbs.isNotEmpty) {
      final clampedIndex = _selectedIndex.clamp(0, thumbs.length - 1);
      return thumbs[clampedIndex];
    }
    return widget.imageUrl;
  }

  void _handleAddToCart() => widget.onAddToCart?.call();
  void _handleIncrement() => widget.onIncrement?.call();
  void _handleDecrement() => widget.onDecrement?.call();

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    final int effectiveCount = widget.count ?? 0;
    final bool showCounter = effectiveCount > 0;

    return Material(
      color: colors.surfaceLow,
      borderRadius: BorderRadius.circular(_Dimensions.cardRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
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
                    const SizedBox(height: 8),
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

                  const SizedBox(height: 6),
                  _buildPriceRow(colors, textTheme),
                  const SizedBox(height: 10),

                  showCounter
                      ? _buildCounter(colors, textTheme, effectiveCount)
                      : _buildAddToCartButton(),
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
          imageUrl: _activeImageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        if (widget.isOutOfStock)
          ColoredBox(
            color: theme.colors.surfaceHigh.withValues(alpha: 0.7),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colors.title.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(_Dimensions.smallRadius),
                ),
                child: Text(
                  _Strings.outOfStock,
                  style: theme.typography.textTheme.labelSmall
                      .copyWith(color: theme.colors.onPrimary),
                  textAlign: TextAlign.center,
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
        separatorBuilder: (_, _) => const SizedBox(width: 5),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
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

  Widget _buildAddToCartButton() {
    return SellioButton(
      text: _Strings.addToCart,
      onTap: widget.isOutOfStock ? null : _handleAddToCart,
      prefixSvgPath: AppImages.cart,
      verticalPadding: 10,
      horizontalPadding: 8,
      fullWidth: true,
      borderRadius: _Dimensions.buttonRadius,
    );
  }

  Widget _buildCounter(
      SellioColorScheme colors, SellioTextTheme textTheme, int effectiveCount) {
    return Container(
      width: double.infinity,
      height: _Dimensions.counterHeight,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCounterButton(
            icon: effectiveCount == 1 ? AppImages.delete : AppImages.remove,
            iconColor: colors.body,
            bgColor: colors.surface,
            onTap: _handleDecrement,
          ),
          Text(
            effectiveCount.toString().padLeft(2, '0'),
            style: textTheme.labelMedium.copyWith(color: colors.title),
          ),
          _buildCounterButton(
            icon: AppImages.add,
            iconColor: colors.primary,
            bgColor: colors.primaryVariant,
            onTap: _handleIncrement,
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
  }) {
    return Container(
      width: _Dimensions.iconButtonSize,
      height: _Dimensions.iconButtonSize,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(_Dimensions.mediumRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
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
      label: widget.isFavorite
          ? _Strings.removeFavorite
          : _Strings.addFavorite,
      button: true,
      child: ClipOval(
        child: ColoredBox(
          color: _kFrostedWhite,
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
