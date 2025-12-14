import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:country_picker/country_picker.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import '../shared/widgets/phone_input_with_country.dart';
import 'widgets/lock_icon.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _phoneController = TextEditingController();
  bool _isPhoneFilled = false;
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _initializeDefaultCountry();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _initializeDefaultCountry() {
    _selectedCountry = Country(
      phoneCode: '964',
      countryCode: 'IQ',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Iraq',
      example: '7912345678',
      displayName: 'Iraq (IQ) [+964]',
      displayNameNoCountryCode: 'Iraq (IQ)',
      e164Key: '964-IQ-0',
    );
  }

  void _onPhoneChanged() {
    setState(() {
      _isPhoneFilled = _phoneController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (!_isPhoneFilled) return;

    final phoneNumber = '+${_selectedCountry?.phoneCode ?? '964'}${_phoneController.text}';
    context.navigator.pushForgetPasswordOtp(
      ForgetPasswordOtpArgs(phoneNumber: phoneNumber),
    );
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
                        context.local.title_forget_password,
                        style: textTheme.headlineSmall.copyWith(color: colors.title),
                      ),
                      const Gap(8),
                      Text(
                        context.local.subtitle_forget_password,
                        style: textTheme.bodyMedium.copyWith(color: colors.body),
                      ),
                      const Gap(24),
                      PhoneInputWithCountry(
                        controller: _phoneController,
                        selectedCountry: _selectedCountry,
                        onCountrySelected: (country) {
                          setState(() => _selectedCountry = country);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SellioButton(
                text: context.local.send,
                onTap: _isPhoneFilled ? _handleSend : null,
                backgroundColor: _isPhoneFilled ? colors.primary : colors.disabled,
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