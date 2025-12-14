import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'package:design_system/design_system.dart';
import '../../../../../core/enums/form_field_type.dart';
import '../../shared/widgets/phone_input_with_country.dart';
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

  @override
  void initState() {
    super.initState();
    _setupListeners();
  }

  void _setupListeners() {
    _phoneController.addListener(_onPhoneChanged);
    _passwordController.addListener(_onPasswordChanged);
    _phoneFocusNode.addListener(_onPhoneFocusChanged);
    _passwordFocusNode.addListener(_onPasswordFocusChanged);
  }

  void _onPhoneChanged() {
    context.read<LoginFormCubit>().updatePhoneNumber(_phoneController.text);
  }

  void _onPasswordChanged() {
    context.read<LoginFormCubit>().updatePassword(_passwordController.text);
  }

  void _onPhoneFocusChanged() {
    if (!_phoneFocusNode.hasFocus && _phoneController.text.isNotEmpty) {
      context.read<LoginFormCubit>().validateFieldOnFocusChange(
        FormFieldType.phone,
        _phoneController.text,
      );
    }
  }

  void _onPasswordFocusChanged() {
    if (!_passwordFocusNode.hasFocus && _passwordController.text.isNotEmpty) {
      context.read<LoginFormCubit>().validateFieldOnFocusChange(
        FormFieldType.password,
        _passwordController.text,
      );
    }
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
        if (state is! LoginFormLoaded) {
          return const SizedBox.shrink();
        }

        final colors = context.theme.colors;

        return Column(
          children: [
            PhoneInputWithCountry(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              selectedCountry: state.selectedCountry,
              onCountrySelected: (country) {
                context.read<LoginFormCubit>().updateSelectedCountry(country);
              },
            ),
            const Gap(16),
            _buildPasswordField(colors),
            _buildForgetPasswordButton(colors),
          ],
        );
      },
    );
  }

  Widget _buildPasswordField(dynamic colors) {
    return Focus(
      focusNode: _passwordFocusNode,
      child: SellioTextField(
        controller: _passwordController,
        hintText: context.local.password,
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
    );
  }

  Widget _buildForgetPasswordButton(dynamic colors) {
    return Align(
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
    );
  }
}