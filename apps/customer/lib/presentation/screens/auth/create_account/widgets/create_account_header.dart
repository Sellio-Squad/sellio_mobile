import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:design_system/design_system.dart';

Widget buildCreateAccountHeader(BuildContext context) {
  final colors = context.theme.colors;
  final textTheme = context.theme.typography.textTheme;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 8),
      Text(
        context.local.create_account,
        style: textTheme.headlineSmall.copyWith(color: colors.title),
      ),
      const SizedBox(height: 4),
      Text(
        context.local.enter_your_information_to_create_account,
        style: textTheme.bodyMedium.copyWith(color: colors.body),
      ),
    ],
  );
}
