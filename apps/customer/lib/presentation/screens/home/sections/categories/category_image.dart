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
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isMore ? Colors.grey.shade100 : colors.surfaceLow,
        shape: BoxShape.circle,
        border:
            isMore ? Border.all(color: Colors.grey.shade300, width: 1.5) : null,
      ),
      child: ClipOval(
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isMore) {
      return Center(
        child: Icon(
          Icons.more_horiz,
          size: 32,
          color: Colors.grey.shade700,
        ),
      );
    }

    if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              AppImages.placeholder,
              fit: BoxFit.scaleDown,
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        AppImages.placeholder,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
