import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/ui/screens/auth/signupOTP.dart';

import '../../../core/design_system/widgets/AuthBackgroundWrapper.dart';
import '../../../core/design_system/widgets/buttons/button.dart';
import '../../../core/design_system/widgets/textField.dart';
import 'country.dart';
import 'login.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final List<Country> _countries = mockCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.firstWhere((c) => c.code == '+964');
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundWrapper(
      showLogo: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create account',
              style: context.theme.typography.textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Enter your information to create account',
              style: context.theme.typography.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            SellioTextField(
              controller: phoneController,
              hintText: 'Phone number',
              hintStyle: context.theme.typography.textTheme.labelMedium
                  .copyWith(color: context.theme.colors.body),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.phone, width: 24, height: 24),
                    const Gap(8),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Country>(
                        value: _selectedCountry,
                        isDense: true,
                        icon: const SizedBox.shrink(),
                        onChanged: (Country? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedCountry = newValue;
                            });
                          }
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return _countries.map<Widget>((Country country) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  Assets.arrowDown,
                                  width: 16,
                                  height: 16,
                                ),
                                const Gap(8),
                                SvgPicture.asset(
                                  country.flagAsset,
                                  width: 24,
                                  height: 24,
                                ),
                                const Gap(8),
                                Text(
                                  country.code,
                                  style: context
                                      .theme
                                      .typography
                                      .textTheme
                                      .bodyMedium
                                      .copyWith(
                                        color: context.theme.colors.title,
                                      ),
                                ),
                              ],
                            );
                          }).toList();
                        },
                        items: _countries.map((Country country) {
                          return DropdownMenuItem<Country>(
                            value: country,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  country.flagAsset,
                                  width: 24,
                                  height: 24,
                                ),
                                const Gap(8),
                                Text(
                                  country.code,
                                  style: context
                                      .theme
                                      .typography
                                      .textTheme
                                      .bodyMedium
                                      .copyWith(
                                        color: context.theme.colors.title,
                                      ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Gap(8),
                    Container(
                      width: 1,
                      height: 24,
                      color: context.theme.colors.stroke,
                    ),
                  ],
                ),
              ),
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            // Full name
            SellioTextField(
              controller: nameController,
              hintText: 'Full name',
              hintStyle: context.theme.typography.textTheme.labelMedium
                  .copyWith(color: context.theme.colors.body),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: SvgPicture.asset(
                  Assets.account,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    context.theme.colors.body,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SellioTextField(
                    controller: countryController,
                    hintText: 'Country',
                    hintStyle: context.theme.typography.textTheme.labelMedium
                        .copyWith(color: context.theme.colors.body),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: SvgPicture.asset(
                        Assets.location,
                        colorFilter: ColorFilter.mode(
                          context.theme.colors.body,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SellioTextField(
                    controller: cityController,
                    hintText: 'City',
                    hintStyle: context.theme.typography.textTheme.labelMedium
                        .copyWith(color: context.theme.colors.body),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: SvgPicture.asset(
                        Assets.location,
                        colorFilter: ColorFilter.mode(
                          context.theme.colors.body,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SellioTextField(
              controller: passwordController,
              hintText: 'Password',
              hintStyle: context.theme.typography.textTheme.labelMedium
                  .copyWith(color: context.theme.colors.body),
              inputType: TextInputType.visiblePassword,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: SvgPicture.asset(
                  Assets.password,
                  colorFilter: ColorFilter.mode(
                    context.theme.colors.body,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SellioTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm password',
              hintStyle: context.theme.typography.textTheme.labelMedium
                  .copyWith(color: context.theme.colors.body),
              inputType: TextInputType.visiblePassword,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: SvgPicture.asset(
                  Assets.password,
                  colorFilter: ColorFilter.mode(
                    context.theme.colors.body,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Profile photo (optional)',
              style: context.theme.typography.textTheme.titleSmall.copyWith(
                color: context.theme.colors.title,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 144,
                height: 112,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.theme.colors.stroke,
                    width: 0.5,
                  ),
                  color: context.theme.colors.surface,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.imageUpload,
                      height: 48,
                      width: 48,
                      colorFilter: ColorFilter.mode(
                        context.theme.colors.body,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload',
                      style: context.theme.typography.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(
                color: context.theme.colors.surfaceLow,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, -4),
                    blurRadius: 8,
                  ),
                ],
              ),
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SellioButton(
                    text: 'Create account',
                    textStyle: context.theme.typography.textTheme.labelMedium,
                    isEnabled: true,
                    suffixSvgPath: Assets.outlineArrow,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConfirmAccountScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have account?',
                        style: context.theme.typography.textTheme.labelMedium
                            .copyWith(color: context.theme.colors.body),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );                        },
                        child: Text(
                          'Login',
                          style: context.theme.typography.textTheme.labelMedium
                              .copyWith(color: context.theme.colors.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
