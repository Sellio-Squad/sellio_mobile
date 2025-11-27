import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../../../core/design_system/constants/app_images.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../../core/design_system/widgets/buttons/sellio_button.dart';
import '../cubits/form/create_account_form_cubit.dart';
import '../cubits/form/create_account_form_state.dart';

class CreateAccountButtonBuilder extends StatelessWidget {
  const CreateAccountButtonBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountFormCubit, CreateAccountFormState>(
      builder: (context, state) {
        if (state is! CreateAccountFormChanged) {
          return const SizedBox.shrink();
        }

        return SellioButton(
          text: context.local.create_account,
          textStyle: context.theme.typography.textTheme.labelMedium,
          isEnabled: state.isFormValid && !state.isLoading,
          isLoading: state.isLoading,
          suffixSvgPath: AppImages.outlineArrow,
          iconWidth: 10,
          iconHeight: 10,
          suffixIconColor: state.isFormValid
              ? context.theme.colors.onPrimary
              : context.theme.colors.hint,
          loadingColors: context.theme.colors.loadingLightColors,
          backgroundColor: state.isFormValid
              ? context.theme.colors.primary
              : context.theme.colors.disabled,
          onTap: () {
            context.read<CreateAccountFormCubit>().createAccount();
          },
        );
      },
    );
  }
}
