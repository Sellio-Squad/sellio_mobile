import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  final VoidCallback onDeleteAccount;

  const DeleteAccountBottomSheet({super.key, required this.onDeleteAccount});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onDeleteAccount,
  }) {
    return SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: DeleteAccountBottomSheet(onDeleteAccount: onDeleteAccount),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.local.delete_account}?",
              style: context.theme.typography.textTheme.titleMedium,
            ),
            const SizedBox(height: 24),

            Text(
              context.local.are_you_sure_to_continue_deleting_account,
              style: context.theme.typography.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            SellioButton(
              text: context.local.delete_account,
              backgroundColor: context.theme.colors.errorVariant,
              textColor: context.theme.colors.red,
              onTap: onDeleteAccount,
              fullWidth: true,
            ),
          ],
        );
  }
}
