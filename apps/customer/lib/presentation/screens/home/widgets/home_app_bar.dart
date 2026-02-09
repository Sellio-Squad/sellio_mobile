import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import '../../../cubits/user/cubit/user_cubit.dart';
import '../../../cubits/user/cubit/user_state.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSearchTap;

  const HomeAppBar({
    super.key,
    this.onNotificationTap,
    this.onSearchTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(68.0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        String userName = context.local.guest;
        String? location;

        if (state is UserLoaded) {
          userName = state.name;
          location = state.location;
        }

        return SellioAppBar(
          leading: _buildUserInfo(context, userName, location),
          actions: [_buildNotificationButton()],
        );
      },
    );
  }

  Widget _buildLogo() => Padding(
        padding: const EdgeInsets.all(4),
        child: Image.asset(AppImages.sellio, fit: BoxFit.contain),
      );

  Widget _buildUserInfo(
    BuildContext context,
    String userName,
    String? location,
  ) {
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
          _buildLocation(context, location),
        ],
      ],
    );
  }

  Widget _buildLocation(BuildContext context, String location) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppImages.location, width: 16, height: 16),
        const SizedBox(width: 4),
        Text(
          location,
          style: textTheme.labelXSmall.copyWith(color: colors.body),
        ),
      ],
    );
  }

  Widget _buildNotificationButton() => Padding(
        padding: const EdgeInsetsGeometry.only(right: 16),
        child: Row(
          spacing: 12,
          children: [
            IconButton(
              icon: SvgPicture.asset(AppImages.bell),
              onPressed: onNotificationTap,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 40,
            ),
            IconButton(
              icon: SvgPicture.asset(AppImages.search),
              onPressed: onSearchTap,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 40,
            ),
          ],
        ),
      );
}
