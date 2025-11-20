import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';

import '../../../../../core/design_system/constants/app_images.dart';
import '../../../../../core/design_system/constants/app_strings.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../../core/design_system/widgets/buttons/sellio_button.dart';
import '../../../../../core/design_system/widgets/sellio_text_field.dart';
import '../../country.dart';
import '../cubits/form/login_form_cubit.dart';
import '../cubits/form/login_form_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  void _onFocusChange(String fieldType) {
    switch (fieldType) {
      case 'phone':
        if (!_phoneFocusNode.hasFocus && _phoneController.text.isNotEmpty) {
          context
              .read<LoginFormCubit>()
              .validateFieldOnFocusChange('phone', _phoneController.text);
        }
        break;
      case 'password':
        if (!_passwordFocusNode.hasFocus &&
            _passwordController.text.isNotEmpty) {
          context
              .read<LoginFormCubit>()
              .validateFieldOnFocusChange('password', _passwordController.text);
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      context.read<LoginFormCubit>().updatePhoneNumber(_phoneController.text);
    });

    _passwordController.addListener(() {
      context.read<LoginFormCubit>().updatePassword(_passwordController.text);
    });

    _phoneFocusNode.addListener(() => _onFocusChange('phone'));
    _passwordFocusNode.addListener(() => _onFocusChange('password'));
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
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        if (state is! LoginFormChanged) {
          return const SizedBox.shrink();
        }

        final colors = context.theme.colors;

        return Column(
          children: [
            Focus(
              focusNode: _phoneFocusNode,
              child: SellioTextField(
                controller: _phoneController,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: SvgPicture.asset(
                    AppImages.phone,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      colors.body,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                hintText: AppStrings.phoneNumber,
                inputType: TextInputType.phone,
                isPhoneNumber: true,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[+\d]')),
                  LengthLimitingTextInputFormatter(11),
                ],
                selectedCountry: state.selectedCountry,
                countries: mockCountries,
                onChangeCountry: (country) {
                  context.read<LoginFormCubit>().updateSelectedCountry(country);
                },
              ),
            ),

             const Gap(16),

             Focus(
              focusNode: _passwordFocusNode,
              child: SellioTextField(
                controller: _passwordController,
                hintText: 'Password',
                inputType: TextInputType.visiblePassword,
                prefixIcon: SvgPicture.asset(
                  AppImages.password,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    colors.body,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: SellioButton(
                text: 'Forget Password?',
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
}