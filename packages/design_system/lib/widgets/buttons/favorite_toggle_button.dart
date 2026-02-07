import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_images.dart';
import '../../themes/sellio_theme.dart';

/// A reusable favorite toggle button that handles:
/// - Toggle between filled/outlined heart icons
/// - Loading state with CircularProgressIndicator
/// - Disabled state during API requests
/// - Async API call to toggle favorite status
class FavoriteToggleButton extends StatefulWidget {
  /// The product ID to toggle favorite status for
  final String productId;

  /// Whether the product is currently favorited
  final bool isFavorite;

  /// Callback that performs the API call to toggle favorite status
  final VoidCallback? onToggle;

  /// The size of the button (default: 32)
  final double size;

  /// Whether to show the background blur effect (default: true)
  final bool showBackground;

  /// Custom icon color (defaults to theme primary color)
  final Color? iconColor;

  /// Custom background color (defaults to semi-transparent white)
  final Color? backgroundColor;

  const FavoriteToggleButton({
    super.key,
    required this.productId,
    required this.isFavorite,
    this.onToggle,
    this.size = 32,
    this.showBackground = true,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  State<FavoriteToggleButton> createState() => _FavoriteToggleButtonState();
}

class _FavoriteToggleButtonState extends State<FavoriteToggleButton> {
  late bool _isFavorite;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(FavoriteToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _isFavorite = widget.isFavorite;
    }
  }

  Future<void> _handleToggle() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      if (widget.onToggle != null) {
        await Future.microtask(widget.onToggle!); // just call it, no return needed
      }

      if (mounted) {
        setState(() {
          _isFavorite = !_isFavorite;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final iconColor = widget.iconColor ?? colors.primary;

    if (widget.showBackground) {
      return _buildWithBackground(iconColor);
    } else {
      return _buildWithoutBackground(iconColor);
    }
  }

  Widget _buildWithBackground(Color iconColor) {
    final backgroundColor = widget.backgroundColor ?? const Color(0x99FFFFFF);

    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _isLoading ? null : _handleToggle,
              child: _buildIconContent(iconColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWithoutBackground(Color iconColor) {
    return IconButton(
      icon: _buildIconContent(iconColor),
      onPressed: _isLoading ? null : _handleToggle,
      iconSize: widget.size,
    );
  }

  Widget _buildIconContent(Color iconColor) {
    return Center(
      child: _isLoading
          ? SizedBox(
        width: widget.size * 0.5,
        height: widget.size * 0.5,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(iconColor),
        ),
      )
          : SvgPicture.asset(
        _isFavorite ? AppImages.favorite : AppImages.unselectedFavorite,
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
        width: widget.size * 0.625,
        height: widget.size * 0.625,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}