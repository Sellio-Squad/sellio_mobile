import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import '../../../../core/design_system/constants/app_images.dart';
import '../../../../core/design_system/widgets/sellio_app_bar.dart';
import '../../../../core/design_system/widgets/sellio_text_field.dart';
import 'widget/lock_icon.dart';

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

    context.navigator.goToHome();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Scaffold(
      appBar: SellioAppBar(title: AppStrings.titleParForgetPassword,showBackButton: true,),
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
                        style: textTheme.headlineSmall.copyWith(
                          color: colors.title,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        AppStrings.subtitleSetNewPassword,
                        style: textTheme.bodyMedium.copyWith(
                          color: colors.body,
                        ),
                      ),
                      const Gap(32),

                      SellioTextField(
                        controller: _passwordController,
                        hintText: AppStrings.password,
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 12),
                          child: SvgPicture.asset(
                            AppImages.password,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      const Gap(16),

                      SellioTextField(
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
