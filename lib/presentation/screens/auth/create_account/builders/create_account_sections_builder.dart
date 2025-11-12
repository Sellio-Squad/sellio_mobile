import 'package:flutter/material.dart';

import '../../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../widgets/create_account_footer.dart';
import '../widgets/create_account_header.dart';
import 'create_account_button_builder.dart';
import 'create_account_form_builder.dart' show CreateAccountFormWidget;

Widget buildCreateAccountContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: buildCreateAccountHeader(context)),
      const SizedBox(height: 24),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const CreateAccountFormWidget(),
      ),
      Container(
        decoration: BoxDecoration(
          color: context.theme.colors.surfaceLow,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CreateAccountButtonBuilder(),
            const SizedBox(height: 12),
            buildCreateAccountFooter(context),
          ],
        ),
      ),
    ],
  );
}
