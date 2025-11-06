import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../../../../core/design_system/constants/app_strings.dart';
import '../../../../core/design_system/constants/assets.dart';
import '../../../../core/design_system/widgets/buttons/button.dart';
import '../../../../core/design_system/widgets/textField.dart';

class ResetPasswordContent extends StatefulWidget {
  final VoidCallback? onSave;
  const ResetPasswordContent({super.key, this.onSave});

  @override
  State<ResetPasswordContent> createState() => _ResetPasswordContentState();
}

class _ResetPasswordContentState extends State<ResetPasswordContent> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(_validateForm);
    _newPasswordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final isValid = newPassword.isNotEmpty && confirmPassword.isNotEmpty;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.resetPassword,
          style: context.theme.typography.textTheme.titleMedium,
        ),
        SizedBox(height: 24.0),
        SellioTextField(
          controller: _currentPasswordController,
          hintText: AppStrings.currentPassword,
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
        SizedBox(height: 12.0),
        SellioTextField(
          controller: _newPasswordController,
          hintText: AppStrings.newPassword,
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
        SizedBox(height: 12.0),
        SellioTextField(
          controller: _confirmPasswordController,
          hintText: AppStrings.confirmNewPassword,
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
        SizedBox(height: 24.0),
        SellioButton(
          text: AppStrings.save,
          onTap: _isFormValid ? _handleSave : null,
          isEnabled: _isFormValid,
        )
      ],
    );
  }

  void _handleSave() {
    if (!_isFormValid) return;
    widget.onSave?.call();
    Navigator.of(context, rootNavigator: true).pop();
  }
}
