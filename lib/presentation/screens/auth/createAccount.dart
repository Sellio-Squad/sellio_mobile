import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../../../core/design_system/widgets/AuthBackgroundWrapper.dart';
import '../../../core/design_system/widgets/buttons/button.dart';
import '../../../core/design_system/widgets/textField.dart';
import 'country.dart';
import 'login.dart';
import 'signupOTP.dart';

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
  bool _isFormValid = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.firstWhere((c) => c.code == '+964');
    phoneController.addListener(_validateForm);
    nameController.addListener(_validateForm);
    countryController.addListener(_validateForm);
    cityController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid =
          phoneController.text.isNotEmpty &&
              nameController.text.isNotEmpty &&
              countryController.text.isNotEmpty &&
              cityController.text.isNotEmpty &&
              passwordController.text.isNotEmpty &&
              confirmPasswordController.text.isNotEmpty &&
              passwordController.text == confirmPasswordController.text;
    });
  }

  void _handleCreateAccount() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ConfirmAccountScreen()),
    );
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
      containerPadding: const EdgeInsets.symmetric(horizontal: 0),
      showLogo: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.createAccount,
                  style: context.theme.typography.textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.enterYourInformationToCreateAccount,
                  style: context.theme.typography.textTheme.bodyMedium,
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
                  prefixIconPadding: EdgeInsets.only(left:16, right: 8),
                  prefixIcon: SvgPicture.asset(Assets.account,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      context.theme.colors.body,
                      BlendMode.srcIn,
                    ),
                ),),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: SellioTextField(
                        controller: countryController,
                        hintText: AppStrings.country,
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                        ],
                        prefixIconPadding: EdgeInsets.only(left:16, right: 8),
                        prefixIcon:SvgPicture.asset(
                            Assets.location,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              context.theme.colors.body,
                              BlendMode.srcIn,
                            ),
                          ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SellioTextField(
                        controller: cityController,
                        hintText: AppStrings.city,
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                        ],
                        prefixIconPadding: EdgeInsets.only(left:16, right: 8),
                        prefixIcon: SvgPicture.asset(
                            Assets.location,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              context.theme.colors.body,
                              BlendMode.srcIn,
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SellioTextField(
                  controller: passwordController,
                  hintText: AppStrings.password,
                  prefixIconPadding: EdgeInsets.only(left:16, right: 8),
                  inputType: TextInputType.visiblePassword,
                  prefixIcon:  SvgPicture.asset(
                      Assets.password,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        context.theme.colors.body,
                        BlendMode.srcIn,
                      ),
                    ),
                ),
                const SizedBox(height: 6),
                SellioTextField(
                  controller: confirmPasswordController,
                  hintText: AppStrings.confirmPassword,
                  prefixIconPadding: EdgeInsets.only(left:16, right: 8),
                  inputType: TextInputType.visiblePassword,
                  prefixIcon:SvgPicture.asset(
                      Assets.password,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        context.theme.colors.body,
                        BlendMode.srcIn,
                      ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 8),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SellioButton(
                    text: AppStrings.createAccount,
                    textStyle: context.theme.typography.textTheme.labelMedium,
                    isEnabled: _isFormValid && !_isLoading,
                    isLoading: _isLoading,
                    suffixSvgPath: Assets.outlineArrow,
                    iconWidth: 10,
                    iconHeight: 10,
                    suffixIconColor: _isFormValid
                        ? context.theme.colors.onPrimary
                        : context.theme.colors.hint,
                    loadingColors: context.theme.colors.loadingLightColors,
                    backgroundColor: _isFormValid
                        ? context.theme.colors.primary
                        : context.theme.colors.disabled,
                    onTap: _isFormValid ? _handleCreateAccount : null,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
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
                        );
                      },
                      child: Text(
                        AppStrings.login,
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
    );
  }
}