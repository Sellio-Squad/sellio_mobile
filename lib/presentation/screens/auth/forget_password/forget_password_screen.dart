import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';

import '../../../../core/design_system/constants/app_images.dart';
import '../../../../core/design_system/widgets/sellio_app_bar.dart';
import '../../../../core/design_system/widgets/sellio_text_field.dart';
import 'package:sellio_mobile/domain/entities/country.dart';
import 'package:sellio_mobile/domain/services/country_service.dart';
import 'package:sellio_mobile/di/injection_container.dart';
import 'widget/lock_icon.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _phoneController = TextEditingController();
  bool _isPhoneFilled = false;
  late final List<Country> _countries;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    final countryService = sl<CountryService>();
    _countries = countryService.getAvailableCountries();
    _selectedCountry = countryService.getDefaultCountry() ?? _countries.first;
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
      appBar: SellioAppBar(title: context.local.title_par_forget_password,showBackButton: true,),
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
                      SellioTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: SvgPicture.asset(
                            AppImages.phone,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              colors.body,
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
                        controller: _phoneController,
                        selectedCountry: _selectedCountry,
                        countries: _countries,
                        onChangeCountry: (c) => setState(() => _selectedCountry = c),
                      ),
                    ],
                  ),
                ),
              ),
              SellioButton(
                text: context.local.send,
                onTap: _isPhoneFilled
                    ? () {
                        final phoneNumber =
                            '${_selectedCountry.code}${_phoneController.text}';
                        context.navigator.pushForgetPasswordOtp(
                          ForgetPasswordOtpArgs(
                            phoneNumber: phoneNumber,
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
