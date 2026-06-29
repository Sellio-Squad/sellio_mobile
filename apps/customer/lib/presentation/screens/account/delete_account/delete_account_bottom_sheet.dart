import 'package:authentication/authentication.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/screens/account/delete_account/cubit/delete_account_cubit.dart';
import 'package:sellio_mobile/presentation/screens/account/delete_account/cubit/delete_account_state.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

  static Future<bool?> show({
    required BuildContext context,
  }) {
    return SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: BlocProvider<DeleteAccountCubit>(
        create: (context) => DeleteAccountCubit(
          userRepository: context.read<UserRepository>(),
          authRepository: context.read<AuthRepository>(),
        ),
        child: const DeleteAccountBottomSheet(),
      ),
    ).then((value) {
      return value as bool?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          Navigator.of(context).pop(true);
        } else if (state is DeleteAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.theme.colors.hint,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is DeleteAccountLoading;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.local.delete_account}?",
              style: context.theme.typography.textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Text(
              context.local.are_you_sure_to_continue_deleting_account,
              style: context.theme.typography.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.theme.colors.errorVariant.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.theme.colors.hint,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: context.theme.colors.hint,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      context.local.this_action_cannot_be_undone,
                      style: context.theme.typography.textTheme.labelSmall
                          .copyWith(
                        color: context.theme.colors.hint,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SellioButton(
              text: isLoading
                  ? context.local.deleting_account
                  : context.local.delete_account,
              backgroundColor: context.theme.colors.errorVariant,
              textColor: context.theme.colors.red,
              onTap: isLoading
                  ? null
                  : () {
                      context.read<DeleteAccountCubit>().deleteAccount();
                    },
              fullWidth: true,
              verticalPadding: 13,
              isEnabled: !isLoading,
            ),
          ],
        );
      },
    );
  }
}
