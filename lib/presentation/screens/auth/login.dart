import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/app_management/route/routing.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/AuthBackgroundWrapper.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';
import '../../../core/design_system/themes/sellio_colors.dart';
import '../../../core/design_system/themes/sellio_typography.dart';
import '../../../core/design_system/widgets/buttons/button.dart';
import '../../../core/design_system/widgets/textField.dart';
import 'package:flutter/services.dart';
import 'country.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isLoginValid = false;

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<Country> _countries = mockCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.firstWhere((c) => c.code == '+964');
    _phoneController.addListener(_loginValidation);
    _passwordController.addListener(_loginValidation);
  }

  void _loginValidation() {
    final isValid =
        _passwordController.text.trim().isNotEmpty &&
            _phoneController.text.trim().isNotEmpty;

    if (isValid != _isLoginValid) {
      setState(() {
        _isLoginValid = isValid;
      });
    }
  }

  void _handleLogin() {
    if (_isLoginValid) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        context.navigator.goToHome();
      });
    }
  }

  void _handleGuestLogin() {
    // Navigate to home tab as guest
    context.navigator.goToHome();
  }

  void _handleForgotPassword() {
    context.navigator.pushForgetPassword();
  }

  void _handleCreateAccount() {
    context.navigator.pushCreateAccount();
  }

  List<Widget> _buildLoginHeader(
      SellioTextTheme textTheme,
      SellioColorScheme colors,
      String title,
      String subtitle,
      ) {
    return [
      const Gap(24),
      Text(title, style: textTheme.headlineSmall.copyWith(color: colors.title)),
      const Gap(8),
      Text(subtitle, style: textTheme.bodyMedium.copyWith(color: colors.body)),
      const Gap(40),
    ];
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return AuthBackgroundWrapper(
      showLogo: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildLoginHeader(
            textTheme,
            colors,
            AppStrings.titleLogin,
            AppStrings.subtitleLogin,
          ),

          SellioTextField(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: SvgPicture.asset(
                Assets.phone,
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
            controller: _phoneController,
              selectedCountry: _selectedCountry,
              countries: _countries,
              onChangeCountry: (c) => setState(() => _selectedCountry = c),
          ),

          const Gap(16),

          SellioTextField(
            controller: _passwordController,
            hintText: context.local.password,
            hintStyle: textTheme.labelMedium.copyWith(color: colors.body),
            inputType: TextInputType.visiblePassword,
            prefixIcon: SvgPicture.asset(
              Assets.password,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                colors.body,
                BlendMode.srcIn,
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
              onTap: _handleForgotPassword,
            ),
          ),

          const Gap(175),
          SellioButton(
            text: AppStrings.login,
            onTap: _handleLogin,
            textColor: _isLoginValid ? colors.onPrimary : colors.hint,
            backgroundColor: _isLoginValid
                ? colors.primary
                : colors.disabled,
            isLoading: _isLoading,
            suffixSvgPath: Assets.outlineArrow,
            iconWidth: 10,
            iconHeight: 10,
            suffixIconColor: _isLoginValid ? colors.onPrimary : colors.hint,
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
                  onTap: _handleCreateAccount,
                ),
              ),
              const Gap(16),

              Expanded(
                child: SellioButton(
                  text: AppStrings.continueAsGuest,
                  backgroundColor: colors.primaryVariant,
                  textColor: colors.primary,
                  onTap: _handleGuestLogin,
                ),
              ),
            ],
          ),
          Gap(16),
        ],
      ),
    );
  }
}