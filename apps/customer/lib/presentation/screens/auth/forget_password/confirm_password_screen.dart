import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'widgets/lock_icon.dart';

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
    // TODO: Call API to reset password
    context.navigator.goToHome();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Scaffold(
      appBar: SellioAppBar(
        title: context.local.title_par_forget_password,
        showBackButton: true,
      ),
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
                        context.local.set_new_password,
                        style: textTheme.headlineSmall.copyWith(color: colors.title),
                      ),
                      const Gap(8),
                      Text(
                        context.local.subtitle_set_new_password,
                        style: textTheme.bodyMedium.copyWith(color: colors.body),
                      ),
                      const Gap(32),
                      _buildPasswordField(colors),
                      const Gap(16),
                      _buildConfirmPasswordField(colors),
                    ],
                  ),
                ),
              ),
              SellioButton(
                text: context.local.send,
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

  Widget _buildPasswordField(dynamic colors) {
    return SellioTextField(
      controller: _passwordController,
      hintText: context.local.password,
      inputType: TextInputType.visiblePassword,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 16, right: 12),
        child: SvgPicture.asset(
          AppImages.password,
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField(dynamic colors) {
    return SellioTextField(
      controller: _confirmPasswordController,
      hintText: context.local.confirm_password,
      inputType: TextInputType.visiblePassword,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 16, right: 12),
        child: SvgPicture.asset(
          AppImages.password,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}