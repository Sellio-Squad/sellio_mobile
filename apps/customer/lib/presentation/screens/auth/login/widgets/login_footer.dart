import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'package:design_system/design_system.dart';
import '../cubits/form/login_form_cubit.dart';
import '../cubits/form/login_form_state.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        if (state is! LoginFormLoaded) {
          return const SizedBox.shrink();
        }

        final colors = context.theme.colors;
        final textTheme = context.theme.typography.textTheme;

        return Column(
          children: [
            _buildLoginButton(context, state, colors),
            const Gap(12),
            _buildDivider(colors, textTheme),
            const Gap(12),
            _buildSecondaryButtons(context, colors),
          ],
        );
      },
    );
  }

  Widget _buildLoginButton(
      BuildContext context,
      LoginFormLoaded state,
      dynamic colors,
      ) {
    final isEnabled = state.isFormValid && !state.isLoading;

    return SellioButton(
      text: context.local.login,
      onTap: isEnabled
          ? () => context.read<LoginFormCubit>().submitForm()
          : null,
      textColor: state.isFormValid ? colors.onPrimary : colors.hint,
      backgroundColor: state.isFormValid ? colors.primary : colors.disabled,
      isLoading: state.isLoading,
      suffixSvgPath: AppImages.outlineArrow,
      iconWidth: 10,
      iconHeight: 10,
      suffixIconColor: state.isFormValid ? colors.onPrimary : colors.hint,
    );
  }

  Widget _buildDivider(dynamic colors, SellioTextTheme textTheme) {
    return Row(
      children: [
        Expanded(child: Divider(color: colors.stroke)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: textTheme.labelSmall.copyWith(color: colors.body),
          ),
        ),
        Expanded(child: Divider(color: colors.stroke)),
      ],
    );
  }

  Widget _buildSecondaryButtons(BuildContext context, dynamic colors) {
    return Row(
      children: [
        Expanded(
          child: SellioButton(
            text: context.local.create_account,
            backgroundColor: colors.primaryVariant,
            textColor: colors.primary,
            onTap: () => context.navigator.pushCreateAccount(),
          ),
        ),
        const Gap(16),
        Expanded(
          child: SellioButton(
            text: context.local.continue_as_guest,
            backgroundColor: colors.primaryVariant,
            textColor: colors.primary,
            onTap: () => context.navigator.goToHome(),
          ),
        ),
      ],
    );
  }
}