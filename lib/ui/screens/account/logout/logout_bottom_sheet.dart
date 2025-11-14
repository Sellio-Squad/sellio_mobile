import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

class LogoutBottomSheet extends StatelessWidget {
  final Function() onLogout;

  const LogoutBottomSheet({super.key, required this.onLogout});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onLogout,
  }) {
    return SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: LogoutBottomSheet(onLogout: onLogout),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.local.logout,
            style: context.theme.typography.textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          Text(
            context.local.are_you_sure_to_continue_logout,
            style: context.theme.typography.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          SellioButton(
            text: context.local.logout,
            backgroundColor: context.theme.colors.errorVariant,
            suffixIconColor: context.theme.colors.red,
            onTap: onLogout,
            textColor: context.theme.colors.red,
          ),
        ]);
  }
}
