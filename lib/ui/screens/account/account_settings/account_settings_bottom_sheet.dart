import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../../../../core/design_system/constants/app_strings.dart';
import '../../../../core/design_system/constants/assets.dart';
import '../../../../core/design_system/widgets/buttons/button.dart';
import '../../../../core/design_system/widgets/sellio_bottom_sheet.dart';
import '../../../../core/design_system/widgets/textField.dart';
import '../../auth/country.dart';

class AccountSettingsBottomSheet extends StatefulWidget {
  final VoidCallback? onSave;

  const AccountSettingsBottomSheet({super.key, this.onSave});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onSave,
  }) {
    return SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: AccountSettingsBottomSheet(onSave: onSave),
    );
  }

  @override
  State<AccountSettingsBottomSheet> createState() => _AccountSettingsBottomSheetState();
}

class _AccountSettingsBottomSheetState extends State<AccountSettingsBottomSheet> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final List<Country> _countries = mockCountries;
  late Country _selectedCountry;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.firstWhere((c) => c.code == '+964');
    phoneController.addListener(_validateForm);
    nameController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = phoneController.text.isNotEmpty && nameController.text.isNotEmpty;
    });
  }

  void _handleSave() {
    if (!_isFormValid) return;
    widget.onSave?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.accountSettings,
            style: context.theme.typography.textTheme.titleMedium,
          ),
          const SizedBox(height: 24),

          SellioTextField(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: SvgPicture.asset(
                Assets.phone,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.body,
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
            controller: phoneController,
            selectedCountry: _selectedCountry,
            countries: _countries,
            onChangeCountry: (c) => setState(() => _selectedCountry = c),
          ),
          const SizedBox(height: 6),

          SellioTextField(
            controller: nameController,
            hintText: AppStrings.fullName,
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
            ],
            prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
            prefixIcon: SvgPicture.asset(
              Assets.account,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                context.theme.colors.body,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 12),

          SellioButton(
            text: AppStrings.saveChanges,
            onTap: _isFormValid ? _handleSave : null,
            isEnabled: _isFormValid,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
