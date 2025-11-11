import 'package:flutter/material.dart';
import '../../../../../core/app_management/route/routing.dart';
import '../../../../../core/design_system/constants/app_strings.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';

Widget buildCreateAccountFooter(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        AppStrings.alreadyHaveAccount,
        style: context.theme.typography.textTheme.labelMedium
            .copyWith(color: context.theme.colors.body),
      ),
      const SizedBox(width: 4),
      GestureDetector(
        onTap: () {
          context.navigator.replaceWithLogin();
        },
        child: Text(
          AppStrings.login,
          style: context.theme.typography.textTheme.labelMedium
              .copyWith(color: context.theme.colors.primary),
        ),
      ),
    ],
  );
}