import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/cubits/auth/authentication_cubit.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;

  const HomeAppBar({
    super.key,
    this.onNotificationTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(68.0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        String userName = context.local.guest;
        String? location;

        if (state is LoggedIn) {
          final address = state.user.address;
          userName = state.user.fullName;
          location = '${address.city}, ${address.country}';
        }

        return SellioAppBar(
          leading: _buildLogo(),
          customTitle: _buildUserInfo(context, userName, location),
          actions: [_buildNotificationButton()],
        );
      },
    );
  }

  Widget _buildLogo() => Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Image.asset(AppImages.sellio, fit: BoxFit.contain, width: 40, height: 40),
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(AppImages.location, width: 14, height: 14),
        const SizedBox(width: 4),
        Text(
          location,
          style: textTheme.labelXSmall.copyWith(color: colors.body),
        ),
      ],
    );
  }

  Widget _buildNotificationButton() => Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: SvgPicture.asset(AppImages.bell, width: 24, height: 24),
              onPressed: onNotificationTap,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );
}
