import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/localization/auth_localization_service.dart';

class CreateAccountHeader extends StatelessWidget {
  const CreateAccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          context.authLocal.create_account,
          style: textTheme.headlineSmall.copyWith(color: colors.title),
        ),
        const SizedBox(height: 4),
        Text(
          context.authLocal.enter_your_information_to_create_account,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }
}
