import 'package:design_system/themes/sellio_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:seller/core/localization/l10n/localization_service.dart';

class CreateStoreHeader extends StatelessWidget {
  const CreateStoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          context.local.create_store,
          style: textTheme.headlineSmall.copyWith(color: colors.title),
        ),
        const SizedBox(height: 4),
        Text(
          context.local.enter_your_store_information,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }
}
