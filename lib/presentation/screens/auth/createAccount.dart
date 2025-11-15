import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/app_management/route/routing.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../../../core/design_system/constants/app_images.dart';
import '../../../core/design_system/widgets/AuthBackgroundWrapper.dart';
import '../../../core/design_system/widgets/buttons/button.dart';
import '../../../core/design_system/widgets/snack_bar.dart';
import '../../../core/design_system/widgets/textField.dart';
import 'country.dart';
import 'profile_picture_picker.dart';

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
  File? _selectedProfileImage;

  final phoneFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final countryFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  OverlayEntry? _overlayEntry;

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

    phoneFocusNode.addListener(() => _onFocusChange('phone'));
    nameFocusNode.addListener(() => _onFocusChange('name'));
    countryFocusNode.addListener(() => _onFocusChange('country'));
    cityFocusNode.addListener(() => _onFocusChange('city'));
    passwordFocusNode.addListener(() => _onFocusChange('password'));
    confirmPasswordFocusNode
        .addListener(() => _onFocusChange('confirmPassword'));
  }

  void _onFocusChange(String fieldType) {
    switch (fieldType) {
      case 'phone':
        if (!phoneFocusNode.hasFocus && phoneController.text.isNotEmpty) {
          _validateField('phone', phoneController.text);
        }
        break;
      case 'name':
        if (!nameFocusNode.hasFocus && nameController.text.isNotEmpty) {
          _validateField('name', nameController.text);
        }
        break;
      case 'country':
        if (!countryFocusNode.hasFocus && countryController.text.isNotEmpty) {
          _validateField('country', countryController.text);
        }
        break;
      case 'city':
        if (!cityFocusNode.hasFocus && cityController.text.isNotEmpty) {
          _validateField('city', cityController.text);
        }
        break;
      case 'password':
        if (!passwordFocusNode.hasFocus && passwordController.text.isNotEmpty) {
          _validateField('password', passwordController.text);
        }
        break;
      case 'confirmPassword':
        if (!confirmPasswordFocusNode.hasFocus &&
            confirmPasswordController.text.isNotEmpty) {
          _validateField('confirmPassword', confirmPasswordController.text);
        }
        break;
    }
  }

  void _validateField(String fieldType, String value) {
    String? error;
    switch (fieldType) {
      case 'phone':
        error = _validatePhoneNumber(value);
        break;
      case 'name':
        error = _validateFullName(value);
        break;
      case 'country':
        error = _validateCountry(value);
        break;
      case 'city':
        error = _validateCity(value);
        break;
      case 'password':
        error = _validatePassword(value);
        break;
      case 'confirmPassword':
        error = _validateConfirmPassword(passwordController.text, value);
        break;
    }

    if (error != null) {
      _showErrorSnackBar(error);
    }
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _validateAllFields(showErrors: false);
    });
  }

  void _showErrorSnackBar(String message) {
    _hideErrorSnackBar();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 26,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SellioSnackBar(
              isError: true,
              message: message,
              onCancelTap: () {
                _hideErrorSnackBar();
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Timer(const Duration(seconds: 4), () {
      _hideErrorSnackBar();
    });
  }

  void _hideErrorSnackBar() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  String? _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  String? _validateFullName(String fullName) {
    if (fullName.length < 2) return 'Full name must be at least 2 characters';
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(fullName)) {
      return 'Full name must contain only letters and spaces';
    }
    return null;
  }

  String? _validateCountry(String country) {
    if (country.length < 2) return 'Country must be at least 2 characters';
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(country)) {
      return 'Country must contain only letters and spaces';
    }
    return null;
  }

  String? _validateCity(String city) {
    if (city.length < 2) return 'City must be at least 2 characters';
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(city)) {
      return 'City must contain only letters and spaces';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.length < 6) return 'Password must be at least 6 characters';
    if (password.length > 20) return 'Password must be less than 20 characters';
    return null;
  }

  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) return 'Passwords does not match';
    return null;
  }

  bool _validateAllFields({bool showErrors = true}) {
    final phoneError = _validatePhoneNumber(phoneController.text);
    if (phoneError != null) {
      if (showErrors) _showErrorSnackBar(phoneError);
      return false;
    }
    final nameError = _validateFullName(nameController.text);
    if (nameError != null) {
      if (showErrors) _showErrorSnackBar(nameError);
      return false;
    }

    final countryError = _validateCountry(countryController.text);
    if (countryError != null) {
      if (showErrors) _showErrorSnackBar(countryError);
      return false;
    }

    final cityError = _validateCity(cityController.text);
    if (cityError != null) {
      if (showErrors) _showErrorSnackBar(cityError);
      return false;
    }

    final passwordError = _validatePassword(passwordController.text);
    if (passwordError != null) {
      if (showErrors) _showErrorSnackBar(passwordError);
      return false;
    }

    final confirmPasswordError = _validateConfirmPassword(
        passwordController.text, confirmPasswordController.text);
    if (confirmPasswordError != null) {
      if (showErrors) _showErrorSnackBar(confirmPasswordError);
      return false;
    }

    return true;
  }

  void _handleCreateAccount() async {
    if (!_validateAllFields(showErrors: true)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      final phoneNumber = '${_selectedCountry.code}${phoneController.text}';
      context.navigator.pushSignupOtp(
        SignupOtpArgs(
          phoneNumber: phoneNumber,
        ),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Failed to create account. Please try again.');
    }
  }

  @override
  void dispose() {
    _hideErrorSnackBar();

    phoneController.dispose();
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    phoneFocusNode.dispose();
    nameFocusNode.dispose();
    countryFocusNode.dispose();
    cityFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundWrapper(
        containerPadding: const EdgeInsets.symmetric(horizontal: 0),
        showLogo: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                  Focus(
                    focusNode: phoneFocusNode,
                    child: SellioTextField(
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
                      onChangeCountry: (c) =>
                          setState(() => _selectedCountry = c),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Focus(
                    focusNode: nameFocusNode,
                    child: SellioTextField(
                      controller: nameController,
                      hintText: AppStrings.fullName,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                      ],
                      prefixIconPadding: EdgeInsets.only(left: 16, right: 8),
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
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Focus(
                          focusNode: countryFocusNode,
                          child: SellioTextField(
                            controller: countryController,
                            hintText: AppStrings.country,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z ]')),
                            ],
                            prefixIconPadding:
                                EdgeInsets.only(left: 16, right: 8),
                            prefixIcon: SvgPicture.asset(
                              AppImages.location,
                              width: 24,
                              height: 24,
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
                        child: Focus(
                          focusNode: cityFocusNode,
                          child: SellioTextField(
                            controller: cityController,
                            hintText: AppStrings.city,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z ]')),
                            ],
                            prefixIconPadding:
                                EdgeInsets.only(left: 16, right: 8),
                            prefixIcon: SvgPicture.asset(
                              AppImages.location,
                              width: 24,
                              height: 24,
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
                  const SizedBox(height: 6),
                  Focus(
                    focusNode: passwordFocusNode,
                    child: SellioTextField(
                      controller: passwordController,
                      hintText: AppStrings.password,
                      prefixIconPadding: EdgeInsets.only(left: 16, right: 8),
                      inputType: TextInputType.visiblePassword,
                      prefixIcon: SvgPicture.asset(
                        AppImages.password,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          context.theme.colors.body,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Focus(
                    focusNode: confirmPasswordFocusNode,
                    child: SellioTextField(
                      controller: confirmPasswordController,
                      hintText: AppStrings.confirmPassword,
                      prefixIconPadding: EdgeInsets.only(left: 16, right: 8),
                      inputType: TextInputType.visiblePassword,
                      prefixIcon: SvgPicture.asset(
                        AppImages.password,
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
            ),
            const SizedBox(height: 24),
            ProfilePicturePicker(
              onImageSelected: (image) {
                setState(() {
                  _selectedProfileImage = image;
                });
              },
              selectedImage: _selectedProfileImage,
            ),
            const SizedBox(height: 24),
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
                      suffixSvgPath: AppImages.outlineArrow,
                      iconWidth: 10,
                      iconHeight: 10,
                      suffixIconColor: _isFormValid
                          ? context.theme.colors.onPrimary
                          : context.theme.colors.hint,
                      loadingColors: context.theme.colors.loadingLightColors,
                      backgroundColor: _isFormValid
                          ? context.theme.colors.primary
                          : context.theme.colors.disabled,
                      onTap: _handleCreateAccount,
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
                          context.navigator.replaceWithLogin();
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
      ),
    );
  }
}
