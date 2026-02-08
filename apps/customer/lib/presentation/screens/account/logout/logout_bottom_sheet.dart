import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/cubits/auth/authentication_cubit.dart';

class LogoutBottomSheet extends StatelessWidget {
  final Function() onLogout;

  const LogoutBottomSheet({super.key, required this.onLogout});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onLogout,
  }) async {
    await SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: LogoutBottomSheet(onLogout: onLogout),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final isLoading = state is AuthenticationLoading;

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
              text: isLoading
                  ? context.local.logging_out
                  : context.local.logout,
              backgroundColor: context.theme.colors.errorVariant,
              suffixIconColor: context.theme.colors.red,
              onTap:
              isLoading ? null : () {
                context.read<AuthenticationCubit>().logout();
                onLogout();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              textColor: context.theme.colors.red,
              verticalPadding: 13,
              isEnabled: !isLoading,
            ),
          ],
        );
      },
    );
  }
}
