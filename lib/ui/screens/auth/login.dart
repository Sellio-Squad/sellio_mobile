import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../../../core/design_system/themes/sellio_colors.dart';
import '../../../core/design_system/themes/sellio_typography.dart';
import '../../../core/design_system/widgets/buttons/button.dart';
import '../../../core/design_system/widgets/textField.dart';
import 'country.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final List<Country> _countries =
      mockCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.firstWhere((c) => c.code == '+964');
  }

  void _handleLogin() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      print('Login Tapped');
      print('Phone: ${_phoneController.text}');
      print('Password: ${_passwordController.text}');
    });
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
        body:
        GestureDetector(
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
        height: 207, // Specific height
        fit: BoxFit.fill,
      ),
    );
  }

  // *** Just the logo, in a SafeArea ***
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

  /// Bottom section with the white rounded form container
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
              Text(
                'Welcome Back!',
                style: textTheme.headlineSmall.copyWith(color: colors.title),
              ),
              const Gap(8),
              Text(
                'Enter your information to login',
                style: textTheme.bodyMedium.copyWith(color: colors.body),
              ),
              const Gap(24),

              SellioTextField(
                controller: _phoneController,
                hintText: 'Phone number',
                inputType: TextInputType.phone,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(Assets.phone, width: 24, height: 24),
                      const Gap(8),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<Country>(
                          value: _selectedCountry,
                          isDense: true,
                          icon: const SizedBox.shrink(),
                          onChanged: (Country? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedCountry = newValue;
                              });
                            }
                          },
                          selectedItemBuilder: (BuildContext context) {
                            return _countries.map<Widget>((Country country) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(Assets.arrowDown,
                                      width: 16, height: 16),
                                  const Gap(8),
                                  SvgPicture.asset(country.flagAsset,
                                      width: 24, height: 24),
                                  const Gap(8),
                                  Text(
                                    country.code,
                                    style: textTheme.bodyMedium
                                        .copyWith(color: colors.title),
                                  ),
                                ],
                              );
                            }).toList();
                          },
                          items: _countries.map((Country country) {
                            return DropdownMenuItem<Country>(
                              value: country,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(country.flagAsset,
                                      width: 24, height: 24),
                                  const Gap(8),
                                  Text(
                                    country.code,
                                    style: textTheme.bodyMedium
                                        .copyWith(color: colors.title),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const Gap(8),
                      Container(width: 1, height: 24, color: colors.stroke),
                    ],
                  ),
                ),
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
              const Gap(12),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: textTheme.labelMedium.copyWith(color: colors.primary),
                ),
              ),
              const Gap(24),

              // --- Bottom Section (Guest/Create) ---
              // Login Button
              SellioButton(
                text: 'Login',
                onTap: _handleLogin,
                isLoading: _isLoading,
                suffixSvgPath: Assets.arrowRight,
              ),
              const Gap(24),

              Row(
                children: [
                  Expanded(child: Divider(color: colors.stroke)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: textTheme.labelSmall.copyWith(color: colors.hint),
                    ),
                  ),
                  Expanded(child: Divider(color: colors.stroke)),
                ],
              ),
              const Gap(24),

              Row(
                children: [
                  // Create Account Button
                  Expanded(
                    child: SellioButton(
                      text: 'Create Account',
                      backgroundColor: colors.surfaceLow,
                      textColor: colors.primary,
                      onTap: () {
                        print('Create Account');
                      },
                    ),
                  ),
                  const Gap(16),
                  // Continue as Guest Button
                  Expanded(
                    child: SellioButton(
                      text: 'Continue as guest',
                      backgroundColor: colors.surfaceLow,
                      textColor: colors.primary,
                      onTap: () {
                        print('Continue as Guest');
                      },
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