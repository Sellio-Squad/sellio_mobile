import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_images.dart';
import '../../themes/sellio_theme_provider.dart';
import '../discount_tag.dart';

class SellioStoreCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String? discountText;
  final VoidCallback? onLikePressed;
  final VoidCallback? onCardPressed;
  final bool isFavorite;

  const SellioStoreCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.discountText,
    this.onLikePressed,
    this.onCardPressed,
    this.isFavorite = false,
  });

  @override
  State<SellioStoreCard> createState() => _SellioStoreCardState();
}

class _SellioStoreCardState extends State<SellioStoreCard> {
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
    widget.onLikePressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: SizedBox(
        width: double.infinity,
        height: 133,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              left: 8,
              child: GestureDetector(
                onTap: widget.onCardPressed,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (widget.imageUrl.startsWith('assets/'))
                        Image.asset(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          height: 133,
                        )
                      else if (widget.imageUrl.isNotEmpty)
                        Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          height: 133,
                        ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0x00000000),
                              Color(0xFF000000),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              style: theme.typography.textTheme.titleSmall
                                  .copyWith(color: colors.onPrimary),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 4,
                        right: 4,
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 12.0,
                              sigmaY: 12.0,
                            ),
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
                ),
              ),
            ),
            if (widget.discountText != null)
              Positioned(
                top: 8,
                left: 0,
                child: DiscountTag(discountText: widget.discountText!),
              ),
          ],
        ),
      ),
    );
  }
}
