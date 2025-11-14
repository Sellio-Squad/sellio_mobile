import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';
import '../cubits/BottomSheetType.dart' show BottomSheetType;
import '../cubits/account_cubit.dart';
import '../cubits/account_state.dart';

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
      child: BlocProvider.value(
    value: context.read<AccountCubit>(),
    child: LogoutBottomSheet(onLogout: onLogout),
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
        child:  Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.logout,
                style: context.theme.typography.textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.areYouSureToContinueLogout,
                style: context.theme.typography.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              SellioButton(
                text: AppStrings.logout,
                backgroundColor: context.theme.colors.errorVariant,
                suffixIconColor: context.theme.colors.red,
                onTap: onLogout,
                textColor: context.theme.colors.red,
              ),
            ])
    );

  }
}
