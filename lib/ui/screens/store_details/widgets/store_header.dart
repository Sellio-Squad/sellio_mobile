import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class StoreHeader extends StatelessWidget {
  final String imageUrl;
  final String storeName;

  const StoreHeader({
    super.key,
    required this.imageUrl,
    required this.storeName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Store Image
          _buildImage(),

          // Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0x00000000),
                  Color(0xFF000000),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Store Name
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Text(
              storeName,
              textAlign: TextAlign.center,
              style: theme.typography.textTheme.headlineSmall.copyWith(
                color: colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: const Color(0xFFE6E6E6),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFFE6E6E6),
            child: const Icon(Icons.broken_image, size: 48),
          );
        },
      );
    }
  }
}