import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:design_system/design_system.dart';

class AccountOptionsBottomSheet extends StatelessWidget {
  final Function() onLogout;
  final Function() onDeleteAccount;

  const AccountOptionsBottomSheet({
    super.key,
    required this.onLogout,
    required this.onDeleteAccount,
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onLogout,
    required VoidCallback onDeleteAccount,
    required VoidCallback onDismiss,
  }) async {
    await SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      onDismiss: onDismiss,
      child: AccountOptionsBottomSheet(
        onLogout: onLogout,
        onDeleteAccount: onDeleteAccount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.local.account_options,
          style: context.theme.typography.textTheme.titleMedium,
        ),
        const SizedBox(height: 24),
        SellioButton(
          text: context.local.logout,
          backgroundColor: context.theme.colors.errorVariant,
          prefixIconColor: context.theme.colors.red,
          prefixSvgPath: AppImages.logout,
          textColor: context.theme.colors.red,
          onTap: () async { await onLogout(); },
          contentAlignment: MainAxisAlignment.start,
        ),
        const SizedBox(height: 12),
        SellioButton(
          text: context.local.delete_account,
          backgroundColor: context.theme.colors.errorVariant,
          prefixIconColor: context.theme.colors.red,
          textColor: context.theme.colors.red,
          prefixSvgPath: AppImages.deleteAccount,
          onTap: onDeleteAccount,
          contentAlignment: MainAxisAlignment.start,
        ),
      ],
    );
  }
}
