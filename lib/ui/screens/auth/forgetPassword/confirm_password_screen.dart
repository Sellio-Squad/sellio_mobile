import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/ui/screens/auth/forgetPassword/widget/lock_icon.dart';

import '../../../../core/design_system/constants/assets.dart';
import '../../../../core/design_system/widgets/sellio_back_app_bar.dart';
import '../../../../core/design_system/widgets/textField.dart';
import '../../main_screen/MainScreen.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final isValid = password.isNotEmpty && confirmPassword.isNotEmpty;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  void _handleSave() {
    if (!_isFormValid) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Scaffold(
      appBar: SellioBackAppBar(title: AppStrings.titleParForgetPassword),
      backgroundColor: colors.surfaceLow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Center(child: buildLockIcon(colors)),
                      const SizedBox(height: 40),
                      Text(
                        AppStrings.setNewPassword,
                        style: textTheme.headlineSmall.copyWith(color: colors.title),
                      ),
                      const Gap(8),
                      Text(
                        AppStrings.subtitleSetNewPassword,
                        style: textTheme.bodyMedium.copyWith(color: colors.body),
                      ),
                      const Gap(32),

                      // Use the new reusable PasswordField
                      SellioTextField(
                        controller: _passwordController,
                        hintText: AppStrings.password,
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 12),
                          child: SvgPicture.asset(Assets.password, width: 24, height: 24),
                        ),
                      ),
                      const Gap(16),

                      SellioTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 12),
                          child: SvgPicture.asset(Assets.password, width: 24, height: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SellioButton(
                text: AppStrings.send,
                onTap: _isFormValid ? _handleSave : null,
                isEnabled: _isFormValid,
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
