import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:design_system/design_system.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(24),
        Text(
          context.local.title_login,
          style: textTheme.headlineSmall.copyWith(color: colors.title),
        ),
        const Gap(8),
        Text(
          context.local.subtitle_login,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }
}
