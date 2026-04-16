import 'package:flutter/material.dart';

import '../themes/sellio_theme.dart';

class SellioRemoteImage extends StatelessWidget {
  const SellioRemoteImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.errorWidget,
  }) : _isCircle = false;

  const SellioRemoteImage.circle({
    super.key,
    required this.imageUrl,
    required double size,
    this.errorWidget,
  }) : width = size,
       height = size,
       fit = BoxFit.cover,
       borderRadius = const BorderRadius.all(Radius.circular(999)),
       _isCircle = true;

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Widget? errorWidget;
  final bool _isCircle;

  Widget _buildError(BuildContext context) {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: Center(
            child: Icon(
              Icons.image_outlined,
              size: 40,
              color: Colors.grey[400],
            ),
          ),
        );
  }

  Widget _buildLoading(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;

    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      color: colors.surface,
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (_, child, progress) =>
          progress == null ? child : _buildLoading(context),
      errorBuilder: (_, _, _) => _buildError(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isCircle) {
      return ClipOval(child: _buildImage(context));
    }
    return ClipRRect(borderRadius: borderRadius, child: _buildImage(context));
  }
}
