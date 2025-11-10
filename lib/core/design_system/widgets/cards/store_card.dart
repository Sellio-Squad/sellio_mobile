import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../../constants/assets.dart';
import '../discount_tag.dart';

class StoreCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? discountText;
  final VoidCallback? onLikePressed;
  final VoidCallback? onCardPressed;
  final bool isFavorite;

  const StoreCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.discountText,
    this.onLikePressed,
    this.onCardPressed,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
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
                onTap: onCardPressed,
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
                      if (imageUrl.startsWith('assets/'))
                        Image.asset(imageUrl, fit: BoxFit.cover)
                      else
                        Image.network(imageUrl, fit: BoxFit.cover),
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
                              title,
                              textAlign: TextAlign.center,
                              style: context
                                  .theme
                                  .typography
                                  .textTheme
                                  .titleSmall
                                  .copyWith(
                                    color: context.theme.colors.onPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: IconButton(
                          icon: isFavorite
                              ? SvgPicture.asset(
                                  Assets.favouriteIcon,
                                  width: 24,
                                  height: 24,
                                )
                              : SvgPicture.asset(
                                  Assets.favorite,
                                  width: 24,
                                  height: 24,
                                ),
                          onPressed: onLikePressed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (discountText != null)
              Positioned(
                top: 8,
                left: 0,
                child: DiscountTag(discountText: discountText!),
              ),
          ],
        ),
      ),
    );
  }
}
