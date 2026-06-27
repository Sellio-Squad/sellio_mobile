import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/localization/auth_localization_service.dart';
import '../../../navigation/auth_navigator.dart';

class CreateAccountFooter extends StatelessWidget {
  final AuthNavigator navigator;

  const CreateAccountFooter({
    super.key,
    required this.navigator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.authLocal.already_have_account,
          style: textTheme.labelMedium.copyWith(color: colors.body),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            navigator.pop();
          },
          child: Text(
            context.authLocal.login,
            style: textTheme.labelMedium.copyWith(color: colors.primary),
          ),
        ),
      ],
    );
  }
}
