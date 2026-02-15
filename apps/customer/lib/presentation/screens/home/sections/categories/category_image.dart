import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  final String imageUrl;
  final bool isMore;

  const CategoryImage({
    super.key,
    required this.imageUrl,
    required this.isMore,
  });

  @override
  Widget build(BuildContext context) {
    if (isMore) {
      return const Icon(
        Icons.more_horiz,
        size: 28,
        color: Colors.black87,
      );
    }

    if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          return progress == null
              ? child
              : Container(
                  width: double.infinity,
                  color: context.theme.colors.surface,
                  child: const Center(child: CircularProgressIndicator()),
                );
        },
        errorBuilder: (context, error, stackTrace) {
          return Expanded(
            child: Image.asset(
              AppImages.placeholder,
              width: double.infinity,
              fit: BoxFit.scaleDown,
            ),
          );
        },
      );
    }

    return Expanded(
      child: Image.asset(
        AppImages.placeholder,
        width: double.infinity,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
