import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import '../../../../presentation/screens/auth/country.dart';

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
            context.local.account_settings,
            style: context.theme.typography.textTheme.titleMedium,
          ),
          const SizedBox(height: 24),

          SellioTextField(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: SvgPicture.asset(
                AppImages.phone,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.body,
                  BlendMode.srcIn,
                ),
              ),
            ),
            hintText: context.local.phone_number,
            inputType: TextInputType.phone,
            isPhoneNumber: true,
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(r'[+\d]')),
              LengthLimitingTextInputFormatter(11),
            ],
            controller: phoneController,
       /*     selectedCountry: _selectedCountry,
            countries: _countries,
            onChangeCountry: (c) => setState(() => _selectedCountry = c),*/
          ),
          const SizedBox(height: 6),

          SellioTextField(
            controller: nameController,
            hintText: context.local.full_name,
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
            ],
            prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
            prefixIcon: SvgPicture.asset(
              AppImages.account,
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
            text: context.local.save_changes,
            onTap: _isFormValid ? _handleSave : null,
            isEnabled: _isFormValid,
            verticalPadding: 13,
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
