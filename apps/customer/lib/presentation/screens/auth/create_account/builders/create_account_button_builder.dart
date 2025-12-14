import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:design_system/design_system.dart';
import '../cubits/form/create_account_form_cubit.dart';
import '../cubits/form/create_account_form_state.dart';

class CreateAccountButtonBuilder extends StatelessWidget {
  const CreateAccountButtonBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountFormCubit, CreateAccountFormState>(
      builder: (context, state) {
        if (state is! CreateAccountFormLoaded) {
          return const SizedBox.shrink();
        }

        final colors = context.theme.colors;
        final isEnabled = state.isFormValid && !state.isLoading;

        return SellioButton(
          text: context.local.create_account,
          textStyle: context.theme.typography.textTheme.labelMedium,
          isEnabled: isEnabled,
          isLoading: state.isLoading,
          suffixSvgPath: AppImages.outlineArrow,
          iconWidth: 10,
          iconHeight: 10,
          suffixIconColor: state.isFormValid
              ? colors.onPrimary
              : colors.hint,
          loadingColors: colors.loadingLightColors,
          backgroundColor: state.isFormValid
              ? colors.primary
              : colors.disabled,
          onTap: () {
            context.read<CreateAccountFormCubit>().submitForm();
          },
        );
      },
    );
  }
}