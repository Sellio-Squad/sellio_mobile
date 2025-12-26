import 'dart:ui';
import 'package:design_system/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../themes/sellio_theme.dart';
import '../utils/widgets_utils.dart';

class SellioProductVerticalCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final VoidCallback? onFavorite;
  final bool isFavorite;
  final VoidCallback? onTap;

  const SellioProductVerticalCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.onFavorite,
    this.isFavorite = false,
    this.onTap,
  });

  @override
  State<SellioProductVerticalCard> createState() =>
      _SellioProductVerticalCardState();
}

class _SellioProductVerticalCardState extends State<SellioProductVerticalCard> {
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
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap,
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
                    widget.title,
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
                    "\$${formatPrice(widget.price)}",
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
          widget.imageUrl,
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
              AppImages.placeholder,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}