import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../themes/sellio_theme_provider.dart';
import '../constants/app_images.dart';

class SellioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool showBackButton;
  final String? title;
  final String? subtitle;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? customTitle;

  static const double _backIconSize = 24;
  static const double _leadingPadding = 16;

  const SellioAppBar({
    super.key,
    this.leading,
    this.showBackButton = false,
    this.title,
    this.subtitle,
    this.centerTitle = false,
    this.actions,
    this.customTitle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      leadingWidth: leading !=null ? 56: showBackButton ? 56 : 110,
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
        padding: const EdgeInsetsDirectional.only(start: _leadingPadding),
        child: IconButton(
          icon: SvgPicture.asset(AppImages.arrowLeft, matchTextDirection: true),
          onPressed: (){
            Navigator.of(context).pop();
          },
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