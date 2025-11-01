import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';

class ProductVerticalCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const ProductVerticalCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.count = 0,
    required this.onIncrement,
    required this.onDecrement,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  State<ProductVerticalCard> createState() => _ProductVerticalCardState();
}

class _ProductVerticalCardState extends State<ProductVerticalCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavorite?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.imageUrl,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * 0.50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (widget.onFavorite != null)
                    Positioned(
                      top: 8,
                      right: 8,
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
                                onTap: _toggleFavorite,
                                child: Center(
                                  child: SvgPicture.asset(
                                    _isFavorite
                                        ? Assets.favorite
                                        : Assets.unselectedFavorite,
                                    colorFilter: ColorFilter.mode(
                                        colors.primary, BlendMode.srcIn),
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
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  widget.title,
                  style: textTheme.labelMedium.copyWith(color: colors.title),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  widget.price,
                  style: textTheme.titleSmall.copyWith(color: colors.primary),
                  maxLines: 1,
                ),
              ),
              Flexible(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: widget.count == 0
                      ? _buildSingleAddButton(context)
                      : _buildCounter(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSingleAddButton(BuildContext context) {
    final colors = SellioTheme.of(context).colors;
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: Material(
        color: colors.surfaceLow,
        borderRadius: BorderRadius.circular(4),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onIncrement,
          child: SvgPicture.asset(
            Assets.add,
            colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
            width: 16,
            height: 16,
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

    return SizedBox(
      width: double.infinity,
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAlias,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: widget.onDecrement,
                child: SvgPicture.asset(
                  Assets.remove,
                  colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
                  width: 16,
                  height: 16,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Text(
            widget.count.toString().padLeft(2, '0'),
            style: textTheme.labelSmall.copyWith(color: colors.title),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colors.primaryVariant,
              borderRadius: BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAlias,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: widget.onIncrement,
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
}
