import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/constants/app_icons.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';

class AccountOptionsBottomSheet extends StatelessWidget {
  final Function() onLogout;
  final Function() onDeleteAccount;

  const AccountOptionsBottomSheet(
      {super.key, required this.onLogout, required this.onDeleteAccount});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onLogout,
    required VoidCallback onDeleteAccount,
    required VoidCallback onDismiss,
  }) {
    return SellioBottomSheet.show(
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
            prefixSvgPath: AppIcons.logout,
            textColor: context.theme.colors.red,
            onTap: onLogout,
            contentAlignment: MainAxisAlignment.start,
          ),
          const SizedBox(height: 12),
          SellioButton(
            text: context.local.delete_account,
            backgroundColor: context.theme.colors.errorVariant,
            prefixIconColor: context.theme.colors.red,
            textColor: context.theme.colors.red,
            prefixSvgPath: AppIcons.deleteAccount,
            onTap: onDeleteAccount,
            contentAlignment: MainAxisAlignment.start,
          ),
        ]);
  }
}
