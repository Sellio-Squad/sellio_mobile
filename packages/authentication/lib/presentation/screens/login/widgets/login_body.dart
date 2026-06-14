import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_picker/country_picker.dart';
import '../../../../core/localization/auth_localization_service.dart';
import '../../../navigation/auth_navigator.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginBody extends StatefulWidget {
  final AuthNavigator navigator;

  const LoginBody({
    super.key,
    required this.navigator,
  });

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setupListeners();
  }

  void _setupListeners() {
    _phoneController.addListener(() =>
        context.read<LoginCubit>().updatePhoneNumber(_phoneController.text));
    _passwordController.addListener(() =>
        context.read<LoginCubit>().updatePassword(_passwordController.text));

    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus && _phoneController.text.isNotEmpty) {
        context
            .read<LoginCubit>()
            .validatePhoneOnFocusLost(_phoneController.text);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus && _passwordController.text.isNotEmpty) {
        context.read<LoginCubit>().validatePasswordOnFocusLost(
              _passwordController.text,
            );
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                const Gap(40),
                _buildForm(context),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildFooter(context),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.authLocal.title_login,
          style: textTheme.headlineSmall.copyWith(color: colors.title),
        ),
        const Gap(8),
        Text(
          context.authLocal.subtitle_login,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    Country? lastValidCountry;

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginIdle) {
          lastValidCountry = state.selectedCountry;
        }

        final selectedCountry = lastValidCountry;
        final colors = context.theme.colors;
        final typography = context.theme.typography;

        return Column(
          children: [
            SellioPhoneField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              hintText: context.authLocal.phone_number,
              searchHintText: context.authLocal.search_by_name_or_code,
              selectedCountry: selectedCountry,
              onCountrySelected: (country) {
                context.read<LoginCubit>().updateSelectedCountry(country);
              },
            ),
            const Gap(16),
            Focus(
              focusNode: _passwordFocusNode,
              child: SellioTextField(
                textStyle: typography.textTheme.labelSmall
                    .copyWith(color: colors.title),
                controller: _passwordController,
                hintText: context.authLocal.password,
                inputType: TextInputType.visiblePassword,
                isError: state is LoginIdle && state.passwordError != null,
                errorMessage: state is LoginIdle
                    ? state.passwordError?.toLocalizedString(context)
                    : null,
                prefixIcon: SvgPicture.asset(
                  AppImages.password,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SellioButton(
                text: context.authLocal.title_forget_password,
                textColor: colors.primary,
                backgroundColor: Colors.transparent,
                fullWidth: false,
                horizontalPadding: 0,
                verticalPadding: 8,
                onTap: () => widget.navigator.pushForgotPassword(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isFormValid = (state is LoginIdle) && state.isFormValid;
        final isLoading = state is LoginSubmitting;

        return SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SellioButton(
                text: context.authLocal.login,
                onTap: isFormValid && !isLoading
                    ? () => context.read<LoginCubit>().login()
                    : null,
                textColor: isFormValid ? colors.onPrimary : colors.hint,
                backgroundColor: isFormValid ? colors.primary : colors.disabled,
                isLoading: isLoading,
                suffixSvgPath: AppImages.outlineArrow,
                iconWidth: 10,
                iconHeight: 10,
                suffixIconColor: isFormValid ? colors.onPrimary : colors.hint,
              ),
              const Gap(12),
              Row(
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
              ),
              const Gap(12),
              Row(
                children: [
                  Expanded(
                    child: SellioButton(
                      text: context.authLocal.create_account,
                      backgroundColor: colors.primaryVariant,
                      textColor: colors.primary,
                      onTap: () => widget.navigator.pushCreateAccount(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
