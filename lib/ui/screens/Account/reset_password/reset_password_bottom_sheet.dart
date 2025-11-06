import 'package:flutter/material.dart';
import 'package:sellio_mobile/ui/screens/account/reset_password/reset_password_content.dart';

import '../../../../core/design_system/widgets/sellio_bottom_sheet.dart';

class ResetPasswordBottomSheet extends StatelessWidget {
  final VoidCallback? onSave;
  final VoidCallback? onDismiss;
  const ResetPasswordBottomSheet({super.key, this.onSave, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return SellioBottomSheet(
      content:
      Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 24.0),
        child: ResetPasswordContent(
          onSave: onSave,
        ),
      ),
    );
  }
}
