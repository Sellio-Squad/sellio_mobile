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
    final colors = context.theme.colors;

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: colors.surfaceLow,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
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
        errorBuilder: (context, error, stackTrace) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              AppImages.placeholder,
              fit: BoxFit.scaleDown,
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Image.asset(
        AppImages.placeholder,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
