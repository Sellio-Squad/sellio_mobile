import 'package:design_system/constants/app_images.dart' show AppImages;
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
      child: Image.asset(
        AppImages.offerPlaceholder,
      ),
    );
  }
}

Widget oldContent(
  String imageUrl,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error);
      },
    ),
  );
}
