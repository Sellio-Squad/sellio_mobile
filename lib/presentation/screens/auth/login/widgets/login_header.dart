import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../../../../../core/design_system/constants/app_strings.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';

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
          AppStrings.titleLogin,
          style: textTheme.headlineSmall.copyWith(color: colors.title),
        ),
        const Gap(8),
        Text(
          AppStrings.subtitleLogin,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }
}
