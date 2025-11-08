import 'package:flutter/material.dart';
import 'package:sellio_mobile/ui/screens/account/account_settings/account_settings_content.dart';
import '../../../../core/design_system/widgets/sellio_bottom_sheet.dart';

class AccountSettingsBottomSheet extends StatelessWidget {
  final VoidCallback? onSave;
  final VoidCallback? onDismiss;
  const AccountSettingsBottomSheet({super.key, this.onSave, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return SellioBottomSheet(
      content:
      Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 24.0),
        child: AccountSettingsContent(
          onSave: onSave,
        ),
      ),
    );
  }
}
