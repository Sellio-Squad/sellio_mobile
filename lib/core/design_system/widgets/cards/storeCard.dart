import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../../../../ui/screens/home/widgets/discount_tag.dart';
import '../../constants/assets.dart';

class StoreCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onLikePressed;

  const StoreCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 133,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
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
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 8),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: context.theme.typography.textTheme.titleSmall
                            .copyWith(color: context.theme.colors.onPrimary),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        Assets.favouriteIcon,
                        width: 32,
                        height: 32,
                      ),
                      onPressed: onLikePressed,
                    ),
                  ),
                ],
              ),
            ),

            const Positioned(
              top: 8,
              left: 0,
              child: DiscountTag(discountText: '40%'),
            ),
          ],
        ),
      ),
    );
  }
}
