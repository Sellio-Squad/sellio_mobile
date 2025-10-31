import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../constants/assets.dart';

class SellioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final String? title;
  final String? subtitle;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? customTitle;

  static const double _logoSize = 76;
  static const double _backIconSize = 24;
  static const double _leadingPadding = 16;

  const SellioAppBar({
    super.key,
    this.leading,
    this.showBackButton = false,
    this.onBackPressed,
    this.title,
    this.subtitle,
    this.centerTitle = false,
    this.actions,
    this.customTitle,
  });

  factory SellioAppBar.withGreeting({
    Key? key,
    required String userName,
    String? location,
    VoidCallback? onNotificationTap,
  }) {
    return SellioAppBar(
      key: key,
      leading: Image.asset(
        Assets.sellio,
        height: _logoSize,
        width: _logoSize,
        fit: BoxFit.contain,
      ),
      centerTitle: true,
      customTitle: _HomeGreeting(
        userName: userName,
        location: location,
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(Assets.bell),
          onPressed: onNotificationTap,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          iconSize: 40,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      leadingWidth: showBackButton
          ? _backIconSize + _leadingPadding
          : _logoSize + _leadingPadding,
      leading: _buildLeading(context),
      title: customTitle ?? _buildTitle(context, colors, textTheme),
      titleSpacing: 12,
      actions: actions,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) {
      return Padding(
        padding: const EdgeInsets.only(left: _leadingPadding),
        child: leading,
      );
    }

    if (showBackButton) {
      return Padding(
        padding: const EdgeInsets.only(left: _leadingPadding),
        child: IconButton(
          icon: SvgPicture.asset(Assets.arrowLeft),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          iconSize: _backIconSize,
        ),
      );
    }

    return null;
  }

  Widget? _buildTitle(BuildContext context, dynamic colors, dynamic textTheme) {
    if (title == null) return null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: centerTitle
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: textTheme.titleMedium.copyWith(color: colors.title),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style: textTheme.labelSmall.copyWith(color: colors.body),
          ),
        ],
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(68.0);
}

// Separate widget for home greeting section
class _HomeGreeting extends StatelessWidget {
  final String userName;
  final String? location;

  const _HomeGreeting({
    required this.userName,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome, $userName',
          style: textTheme.labelSmall.copyWith(
            color: colors.title,
          ),
        ),
        if (location != null) ...[
          const SizedBox(height: 2),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.location, width: 20, height: 20),
              const SizedBox(width: 4),
              Text(
                location!,
                style: textTheme.labelXSmall.copyWith(
                  color: colors.body,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}