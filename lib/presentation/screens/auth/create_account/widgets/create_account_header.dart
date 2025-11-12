import 'package:flutter/material.dart';

import '../../../../../core/design_system/constants/app_strings.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';

Widget buildCreateAccountHeader(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppStrings.createAccount,
        style: context.theme.typography.textTheme.headlineSmall,
      ),
      const SizedBox(height: 4),
      Text(
        AppStrings.enterYourInformationToCreateAccount,
        style: context.theme.typography.textTheme.bodyMedium,
      ),
    ],
  );
}
