import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/sellio_remote_image.dart';
import 'package:flutter/material.dart';

class SpecialOfferCard extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTap;

  const SpecialOfferCard({
    super.key,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: imageUrl.isEmpty
              ? Image.asset(
                  AppImages.defaultHomeBanner,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                )
              : SellioRemoteImage(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                ),
        ),
      ),
    );
  }
}
