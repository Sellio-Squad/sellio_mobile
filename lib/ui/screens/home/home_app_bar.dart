import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../../../core/design_system/widgets/sellio_app_bar.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? location;
  final VoidCallback? onNotificationTap;

  const HomeAppBar({
    super.key,
    required this.userName,
    this.location,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return SellioAppBar(
      leading: Image.asset(
        Assets.sellio,
        fit: BoxFit.contain,
      ),
      centerTitle: true,
      customTitle: _buildGreeting(context),
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

  Widget _buildGreeting(BuildContext context) {
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
              SvgPicture.asset(Assets.location, width: 16, height: 16),
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

  @override
  Size get preferredSize => const Size.fromHeight(68.0);
}