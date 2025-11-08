import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/constants/app_icons.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';
class AccountOptionsBottomSheet extends StatelessWidget {
  final Function() onLogout;
  final Function() onDeleteAccount;

  const AccountOptionsBottomSheet(
      {super.key, required this.onLogout, required this.onDeleteAccount});

  @override
  Widget build(BuildContext context) {
    return SellioBottomSheet(
        content: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.accountOptions,
                    style: context.theme.typography.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  SellioButton(
                    text: AppStrings.logout,
                    backgroundColor: context.theme.colors.errorVariant,
                    suffixIconColor: context.theme.colors.red,
                    suffixSvgPath: AppIcons.logout,
                    onTap: onLogout,
                  ),
                  const SizedBox(height: 12),
                  SellioButton(
                    text: AppStrings.deleteAccount,
                    backgroundColor: context.theme.colors.errorVariant,
                    suffixIconColor: context.theme.colors.red,
                    suffixSvgPath: AppIcons.deleteAccount,
                    onTap: onDeleteAccount,
                  ),
                ])));
  }
}
