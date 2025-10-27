import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          child: Stack(
            fit: StackFit.expand,
            children: [
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
                    alignment: AlignmentGeometry.bottomCenter,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: context.theme.typography.textTheme.titleSmall
                          .copyWith(color: context.theme.colors.onPrimary),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: SvgPicture.asset(
                    Assets.likeIcon,
                    width: 32,
                    height: 32,
                  ),
                  onPressed: onLikePressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
