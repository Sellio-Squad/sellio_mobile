import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../core/design_system/widgets/sellio_app_bar.dart';

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
  Size get preferredSize => const Size.fromHeight(68.0);

  @override
  Widget build(BuildContext context) {
    return SellioAppBar(
      leading: _buildLogo(),
      centerTitle: true,
      customTitle: _buildUserInfo(context),
      actions: [_buildNotificationButton()],
    );
  }

  // Logo
  Widget _buildLogo() {
    return Image.asset(
      Assets.sellio,
      fit: BoxFit.contain,
    );
  }

  // User Info Section
  Widget _buildUserInfo(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${context.local.welcome}, $userName',
          style: textTheme.labelSmall.copyWith(color: colors.title),
        ),
        if (location != null) ...[
          const SizedBox(height: 2),
          _buildLocation(context),
        ],
      ],
    );
  }

  // Location Row
  Widget _buildLocation(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.location, width: 16, height: 16),
        const SizedBox(width: 4),
        Text(
          location!,
          style: textTheme.labelXSmall.copyWith(color: colors.body),
        ),
      ],
    );
  }

  // Notification Button
  Widget _buildNotificationButton() {
    return IconButton(
      icon: SvgPicture.asset(Assets.bell),
      onPressed: onNotificationTap,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      iconSize: 40,
    );
  }
}