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
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? context.theme.colors.surfaceLow,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLeading(context),
              Expanded(
                child: _buildCenter(context),
              ),
              _buildTrailing(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    if (leading != null) {
      return leading!;
    }
    if (showBack) {
      return IconButton(
        icon: SvgPicture.asset(Assets.arrowLeft),
        onPressed: () => Navigator.of(context).pop(),
      );
    } else {
      return Image.asset(
        Assets.sellio,
        height: 58,
        width: 61,
      );
    }
  }

  Widget _buildCenter(BuildContext context) {
    if (centerWidget != null) {
      return centerWidget!;
    }
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
              SvgPicture.asset(
                Assets.location,
                width: 20,
                height: 20,
              ),
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
      return Text(
        title ?? '',
        style: context.theme.typography.textTheme.titleMedium.copyWith(
          color: context.theme.colors.title,
        ),
        textAlign: TextAlign.start,
      );
    }
  }

  Widget _buildTrailing(BuildContext context) {
    if (trailing != null) {
      return trailing!;
    }
    return IconButton(
      icon: SvgPicture.asset(Assets.bell),
      onPressed: onNotificationTap,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}