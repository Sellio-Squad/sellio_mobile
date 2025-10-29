import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/ui/screens/auth/component/phoneField.dart';
import 'package:sellio_mobile/ui/screens/main_screen/MainScreen.dart';
import '../../../core/design_system/themes/sellio_colors.dart';
import '../../../core/design_system/themes/sellio_typography.dart';
import '../../../core/design_system/widgets/buttons/button.dart';
import '../../../core/design_system/widgets/textField.dart';
import 'package:flutter/services.dart';
import 'country.dart';
import 'createAccount.dart';
import 'forgetPassword/forget_password_screen.dart';

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
        _navigateWithAnimation(MainScreen());
      });
    }
  }

  void _handleGuestLogin() {
    _navigateWithAnimation(MainScreen());
  }

  void _handleForgotPassword() {
    _navigateWithAnimation(ForgetPasswordScreen());
  }

  void _handleCreateAccount() {
    _navigateWithAnimation(CreateAccountScreen());
  }

  void _navigateWithAnimation(Widget screenDestination) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            screenDestination,
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fade = CurvedAnimation(parent: animation, curve: Curves.easeIn);
          final slide = Tween<Offset>(
            begin: Offset.zero,
            end: Offset.zero,
          ).animate(fade);

          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      ),
    );
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF2C0113),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              _buildTopBackground(context),

              _buildBottomSection(context, colors, textTheme),

              _buildTopLogo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBackground(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        Assets.loginTopSection,
        width: double.infinity,
        height: 207,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildTopLogo(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 80, bottom: 40),
        child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset(Assets.sellioWhite, width: 120),
        ),
      ),
    );
  }

  Widget _buildBottomSection(
    BuildContext context,
    SellioColorScheme colors,
    SellioTextTheme textTheme,
  ) {
    const double topOverlap = 207 - 24;

    return Positioned(
      top: topOverlap,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfaceLow,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildLoginHeader(
                textTheme = textTheme,
                colors = colors,
                AppStrings.titleLogin,
                AppStrings.subtitleLogin,
              ),

              Phonefield(
                phoneController: _phoneController,
                selectedCountry: _selectedCountry,
                countries: _countries,
                onChanged: (c) => setState(() => _selectedCountry = c),
                textTheme: textTheme,
                colors: colors,
                flag: Assets.flagIraq,
              ),

              const Gap(16),

              SellioTextField(
                controller: _passwordController,
                hintText: 'Password',
                inputType: TextInputType.visiblePassword,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: SvgPicture.asset(
                    Assets.password,
                    width: 24,
                    height: 24,
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
                  onTap: _handleForgotPassword,
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.25),

              SellioButton(
                text: AppStrings.login,
                onTap: _handleLogin,
                textColor: _isLoginValid ? colors.onPrimary : colors.hint,
                backgroundColor: _isLoginValid
                    ? colors.primary
                    : colors.disabled,
                isLoading: _isLoading,
                suffixSvgPath: Assets.arrowRight,
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
            ],
          ),
        ),
      ),
    );
  }
}