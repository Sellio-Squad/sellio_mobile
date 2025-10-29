import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../constants/assets.dart';

class SellioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBack;
  final String? title;
  final String? userName;
  final String? location;
  final VoidCallback? onNotificationTap;
  final bool showGreeting;
  final Color? backgroundColor;

  final Widget? leading;
  final Widget? centerWidget;
  final Widget? trailing;
  final bool showActionIcon;
  final bool showLeading;
  final String? subtitle;
  final String? actionIcon;

  const SellioAppBar({
    super.key,
    this.showBack = false,
    this.title,
    this.userName,
    this.location,
    this.onNotificationTap,
    this.showGreeting = false,
    this.backgroundColor,
    this.leading,
    this.centerWidget,
    this.trailing,
    this.showActionIcon = true,
    this.showLeading = true,
    this.subtitle,
    this.actionIcon = Assets.bell,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? context.theme.colors.surfaceLow,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showLeading) _buildLeading(context),
              Expanded(child: _buildCenter(context)),
              if (showActionIcon) _buildTrailing(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    if (leading != null) return leading!;
    if (showBack) {
      return IconButton(
        icon: SvgPicture.asset(Assets.arrowLeft),
        onPressed: () => Navigator.of(context).pop(),
      );
    } else {
      return Image.asset(Assets.sellio, height: 58, width: 61);
    }
  }

  Widget _buildCenter(BuildContext context) {
    if (centerWidget != null) return centerWidget!;

    if (showGreeting) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome, $userName',
            style: context.theme.typography.textTheme.labelSmall.copyWith(
              color: context.theme.colors.title,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.location, width: 20, height: 20),
              const SizedBox(width: 4),
              Text(
                location ?? '',
                style: context.theme.typography.textTheme.labelXSmall.copyWith(
                  color: context.theme.colors.body,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? '',
            style: context.theme.typography.textTheme.titleMedium.copyWith(
              color: context.theme.colors.title,
            ),
          ),
          if (subtitle != null && subtitle!.isNotEmpty)
            Text(
              subtitle!,
              style: context.theme.typography.textTheme.labelSmall.copyWith(
                color: context.theme.colors.body,
              ),
            ),
        ],
      );
    }
  }

  Widget _buildTrailing(BuildContext context) {
    if (trailing != null) return trailing!;
    return IconButton(
      icon: SvgPicture.asset(actionIcon!),
      onPressed: onNotificationTap,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}