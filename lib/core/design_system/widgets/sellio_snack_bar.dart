import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../constants/app_images.dart';

class SellioSnackBar extends StatelessWidget {
  final bool isError;
  final String message;
  final String? title;
  final VoidCallback onCancelTap;

  const SellioSnackBar({
    super.key,
    required this.isError,
    required this.message,
    required this.onCancelTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = context.theme.colors;
    final snackBarTitle = title ?? (isError ? 'Error' : 'Success');
    final iconPath = isError ? AppImages.alertDiamond : AppImages.checkmarkBadge;
    final iconColor = isError
        ? themeColor.errorVariant
        : themeColor.greenVariant;
    final shadowColor = isError
        ? themeColor.red.withAlpha(35)
        : themeColor.green.withAlpha(35);

    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: context.theme.colors.surfaceLow,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          snackBarIcon(iconPath, iconColor),
          const SizedBox(width: 8),
          Expanded(child: snackBarText(context, snackBarTitle, message)),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onCancelTap,
            child: SvgPicture.asset(AppImages.cancelCircle, width: 20, height: 20),
          ),
        ],
      ),
    );
  }

  Widget snackBarIcon(String iconPath, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: iconColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: SvgPicture.asset(iconPath, width: 28, height: 28),
    );
  }

  Widget snackBarText(BuildContext context, String title, String message) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.theme.typography.textTheme.labelLarge.copyWith(
            color: context.theme.colors.title,
          ),
        ),
        Text(
          message,
          style: context.theme.typography.textTheme.bodySmall.copyWith(
            color: context.theme.colors.body,
          ),
        ),
      ],
    );
  }
}
