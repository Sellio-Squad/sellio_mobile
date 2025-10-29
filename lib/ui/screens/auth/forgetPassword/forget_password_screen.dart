import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/ui/screens/auth/component/phoneField.dart';
import 'package:sellio_mobile/ui/screens/auth/country.dart';
import 'package:sellio_mobile/ui/screens/auth/forgetPassword/widget/lock_icon.dart';

import '../../../../core/design_system/widgets/sellio_back_app_bar.dart';
import 'forget_password_otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _phoneController = TextEditingController();
  bool _isPhoneFilled = false;
  final List<Country> _countries = mockCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.firstWhere((c) => c.code == '+964');
    _phoneController.addListener(() {
      setState(() {
        _isPhoneFilled = _phoneController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
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
                        AppStrings.titleForgetPassword,
                        style: textTheme.headlineSmall.copyWith(color: colors.title),
                      ),
                      const Gap(8),
                      Text(
                        AppStrings.subtitleForgetPassword,
                        style: textTheme.bodyMedium.copyWith(color: colors.body),
                      ),
                      const Gap(24),
                      Phonefield(
                        phoneController: _phoneController,
                        selectedCountry: _selectedCountry,
                        countries: _countries,
                        onChanged: (c) => setState(() => _selectedCountry = c),
                        textTheme: textTheme,
                        colors: colors,
                        flag: Assets.flagIraq,
                      ),
                    ],
                  ),
                ),
              ),
              SellioButton(
                text: AppStrings.send,
                onTap: _isPhoneFilled
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ForgetPasswordOTPScreen(),
                          ),
                        );
                      }
                    : null,
                backgroundColor: _isPhoneFilled
                    ? colors.primary
                    : colors.disabled,
                textColor: _isPhoneFilled ? colors.onPrimary : colors.hint,
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
