import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'package:design_system/design_system.dart';

Widget buildCreateAccountFooter(BuildContext context) {
  final colors = context.theme.colors;
  final textTheme = context.theme.typography.textTheme;

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        context.local.already_have_account,
        style: textTheme.labelMedium.copyWith(color: colors.body),
      ),
      const SizedBox(width: 4),
      GestureDetector(
        onTap: () {
          context.navigator.pushReplacementLogin();
        },
        child: Text(
          context.local.login,
          style: textTheme.labelMedium.copyWith(color: colors.primary),
        ),
      ),
    ],
  );
}