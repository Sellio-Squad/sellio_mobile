import 'package:flutter/material.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';
import 'create_account_button_builder.dart';
import 'create_account_form_builder.dart' show CreateAccountFormWidget;
import '../widgets/create_account_footer.dart';
import '../widgets/create_account_header.dart';

Widget buildCreateAccountContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      // Header Section
      buildCreateAccountHeader(context),
      const SizedBox(height: 24),

      // Form Section
      const CreateAccountFormWidget(),
      const SizedBox(height: 24),

      // Bottom Section with Button and Footer
      Container(
        decoration: BoxDecoration(
          color: context.theme.colors.surfaceLow,
          borderRadius: BorderRadius.circular(12),
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