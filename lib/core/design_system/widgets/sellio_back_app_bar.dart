import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../constants/assets.dart';

class SellioBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;
  final List<Widget>? actions;

  const SellioBackAppBar({
    super.key,
    required this.title,
    this.onBackPress,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return AppBar(
      toolbarHeight: 68,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16, top: 14, bottom: 14),
        child: SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            icon: SvgPicture.asset(Assets.arrowLeft),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      title: Text(
        title,
        style: textTheme.titleMedium.copyWith(
          color: colors.title,
        ),
      ),
      actions: actions,
      centerTitle: false,
      titleSpacing: 8,
      backgroundColor: colors.surfaceLow,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(68.0);
}