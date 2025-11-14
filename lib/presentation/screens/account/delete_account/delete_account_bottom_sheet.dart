import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';
import '../cubits/BottomSheetType.dart';
import '../cubits/account_cubit.dart';
import '../cubits/account_state.dart';

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
        child: BlocProvider.value(
          value: context.read<AccountCubit>(),
          child: DeleteAccountBottomSheet(onDeleteAccount: onDeleteAccount),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountState>(
        listenWhen: (previous, current) {
          if (current is AccountLoaded &&
              current.activeBottomSheet == BottomSheetType.none) {
            if (previous is AccountLoaded) {
              return previous.activeBottomSheet != BottomSheetType.none;
            }
            if (previous is AccountActionLoading) {
              return previous.previousState.activeBottomSheet !=
                  BottomSheetType.none;
            }
          }
          return false;
        },
        listener: (context, state) {
          Navigator.of(context).pop();
        },
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
              textColor: context.theme.colors.red,
              onTap: onDeleteAccount,
              fullWidth: true,
            ),
          ],
        ));
  }
}
