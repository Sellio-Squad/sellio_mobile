import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';

import '../../../../../core/design_system/constants/app_strings.dart';
import '../../../../../core/design_system/constants/assets.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../../core/design_system/widgets/buttons/button.dart';
import '../cubits/form/login_form_cubit.dart';
import '../cubits/form/login_form_state.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        if (state is! LoginFormChanged) {
          return const SizedBox.shrink();
        }

        final colors = context.theme.colors;
        final textTheme = context.theme.typography.textTheme;

        return Column(
          children: [
            SellioButton(
              text: AppStrings.login,
              onTap: state.isFormValid && !state.isLoading
                  ? () => context.read<LoginFormCubit>().submitForm()
                  : null,
              textColor: state.isFormValid ? colors.onPrimary : colors.hint,
              backgroundColor:
                  state.isFormValid ? colors.primary : colors.disabled,
              isLoading: state.isLoading,
              suffixSvgPath: Assets.outlineArrow,
              iconWidth: 10,
              iconHeight: 10,
              suffixIconColor:
                  state.isFormValid ? colors.onPrimary : colors.hint,
            ),
            const Gap(12),
            Row(
              children: [
                Expanded(child: Divider(color: colors.stroke)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    AppStrings.or,
                    style: textTheme.labelSmall.copyWith(color: colors.body),
                  ),
                ),
                Expanded(child: Divider(color: colors.stroke)),
              ],
            ),
            const Gap(12),
            Row(
              children: [
                Expanded(
                  child: SellioButton(
                    text: AppStrings.createAccount,
                    backgroundColor: colors.primaryVariant,
                    textColor: colors.primary,
                    onTap: () => context.navigator.pushCreateAccount(),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: SellioButton(
                    text: AppStrings.continueAsGuest,
                    backgroundColor: colors.primaryVariant,
                    textColor: colors.primary,
                    onTap: () => context.navigator.goToHome(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
