import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';

Widget buildCreateAccountHeader(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        context.local.create_account,
        style: context.theme.typography.textTheme.headlineSmall,
      ),
      const SizedBox(height: 4),
      Text(
        context.local.enter_your_information_to_create_account,
        style: context.theme.typography.textTheme.bodyMedium,
      ),
    ],
  );
}
