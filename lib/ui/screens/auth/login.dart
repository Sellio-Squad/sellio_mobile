import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../../../core/design_system/widgets/buttons/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _handleLogin() {
    // Simulate a network request
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

    return Scaffold(
      backgroundColor: colors.primary,
      body: Column(
        children: [_buildTopSection(context), _buildBottomSection(context)],
      ),
    );
  }

  /// Top section containing the Sellio logo
  Widget _buildTopSection(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,

      padding: const EdgeInsets.only(top: 100, bottom: 40),
      child: Image.asset(Assets.sellio, width: 120),
    );
  }

  /// Bottom section with the white rounded form container
  Widget _buildBottomSection(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Expanded(
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
              // --- Middle Section (Form) ---
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

              // // Phone Field
              // SellioTextField(
              //   controller: _phoneController,
              //   hintText: 'Phone number',
              //   keyboardType: TextInputType.phone,
              //   prefixIcon: _buildPhonePrefix(context),
              // ),
              const Gap(16),

              // // Password Field
              // SellioTextField(
              //   controller: _passwordController,
              //   hintText: 'Password',
              //   obscureText: !_isPasswordVisible,
              //   prefixIconPath: Assets.password, // Assuming you add this
              //   suffixIconPath:
              //   _isPasswordVisible ? Assets.eyeOn : Assets.eyeOff, // Assuming
              //   onSuffixTap: _togglePasswordVisibility,
              // ),
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
