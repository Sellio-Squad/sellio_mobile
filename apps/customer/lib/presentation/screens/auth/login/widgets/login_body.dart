import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_intl_phone_field/countries.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'package:design_system/design_system.dart';
import '../../shared/enums/form_field_type.dart';
import '../../shared/widgets/phone_input_with_country.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

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
        context.read<LoginCubit>().validateFieldOnFocusChange(
            FormFieldType.phone, _phoneController.text);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus && _passwordController.text.isNotEmpty) {
        context.read<LoginCubit>().validateFieldOnFocusChange(
            FormFieldType.password, _passwordController.text);
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
          context.local.title_login,
          style: textTheme.headlineSmall.copyWith(color: colors.title),
        ),
        const Gap(8),
        Text(
          context.local.subtitle_login,
          style: textTheme.bodyMedium.copyWith(color: colors.body),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final selectedCountryCode =
            (state is LoginIdle) ? state.selectedCountryCode : null;
        final selectedCountry = selectedCountryCode != null ? Country.parse(selectedCountryCode) : null;

     //   final selectedCountry = state.selectedCountry;
        final colors = context.theme.colors;
        final typography = context.theme.typography;

        return Column(
          children: [
            PhoneInputWithCountry(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              selectedCountry: selectedCountry,
              onCountrySelected: (country) {
                context.read<LoginCubit>().updateSelectedCountryCode(country.countryCode);
              },
            ),
            const Gap(16),
            Focus(
              focusNode: _passwordFocusNode,
              child: SellioTextField(
                textStyle: typography.textTheme.labelSmall
                    .copyWith(color: colors.title),
                controller: _passwordController,
                hintText: context.local.password,
                inputType: TextInputType.visiblePassword,
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
              alignment: Alignment.centerRight,
              child: SellioButton(
                text: context.local.forget_password,
                textColor: colors.primary,
                backgroundColor: Colors.transparent,
                fullWidth: false,
                horizontalPadding: 0,
                verticalPadding: 8,
                onTap: () => context.navigator.pushForgetPassword(),
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
                text: context.local.login,
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
                      onTap: () {
                        context.read<LoginCubit>().loginAsGuest();
                      },
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
