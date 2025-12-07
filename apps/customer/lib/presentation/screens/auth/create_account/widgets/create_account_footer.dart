import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import 'package:design_system/design_system.dart';
import '../../../../../core/navigate/routing.dart';

Widget buildCreateAccountFooter(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        context.local.already_have_account,
        style: context.theme.typography.textTheme.labelMedium
            .copyWith(color: context.theme.colors.body),
      ),
      const SizedBox(width: 4),
      GestureDetector(
        onTap: () {
          context.navigator.replaceWithLogin();
        },
        child: Text(
          context.local.login,
          style: context.theme.typography.textTheme.labelMedium
              .copyWith(color: context.theme.colors.primary),
        ),
      ),
    ],
  );
}
