import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../core/design_system/constants/app_images.dart';
import '../../../../core/design_system/widgets/sellio_app_bar.dart';
import '../../../cubits/user/cubit/user_cubit.dart';
import '../../../cubits/user/cubit/user_state.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;

  const HomeAppBar({super.key, this.onNotificationTap});

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
          leading: _buildLogo(),
          centerTitle: true,
          customTitle: _buildUserInfo(context, userName, location),
          actions: [_buildNotificationButton()],
        );
      },
    );
  }

  Widget _buildLogo() => Padding(
    padding: const EdgeInsets.all(4),
    child: Image.asset(
      AppImages.sellio,
      fit: BoxFit.contain
    ),
  );
  Widget _buildUserInfo(BuildContext context, String userName, String? location) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${context.local.welcome}, $userName',
            style: textTheme.labelSmall.copyWith(color: colors.title)),
        if (location != null) ...[
          const SizedBox(height: 2),
          _buildLocation(context, location),
        ]
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
        Text(location, style: textTheme.labelXSmall.copyWith(color: colors.body)),
      ],
    );
  }

  Widget _buildNotificationButton() => IconButton(
    icon: SvgPicture.asset(AppImages.bell),
    onPressed: onNotificationTap,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    iconSize: 40,
  );
}
