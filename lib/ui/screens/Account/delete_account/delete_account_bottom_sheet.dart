import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/constants/app_icons.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  final Function() onDeleteAccount;

  const DeleteAccountBottomSheet({super.key, required this.onDeleteAccount});

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
                    "${AppStrings.deleteAccount}?",
                    style: context.theme.typography.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.areYouSureToContinueDeletingAccount,
                    style: context.theme.typography.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
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
