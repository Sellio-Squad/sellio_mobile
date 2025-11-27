import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import 'package:sellio_mobile/presentation/screens/account/logout/cubit/logout_cubit.dart';
import 'package:sellio_mobile/presentation/screens/account/logout/cubit/logout_state.dart';

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
      child: BlocProvider(
        create: (context) => LogoutCubit(
          context.read<AuthRepository>(),
        ),
        child: LogoutBottomSheet(onLogout: onLogout),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pop();
          onLogout();
        } else if (state is LogoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.theme.colors.hint,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is LogoutLoading;

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
                  ? context.local.logging_out ?? 'Logging out...'
                  : context.local.logout,
              backgroundColor: context.theme.colors.errorVariant,
              suffixIconColor: context.theme.colors.red,
              onTap:
                  isLoading ? null : () => context.read<LogoutCubit>().logout(),
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
