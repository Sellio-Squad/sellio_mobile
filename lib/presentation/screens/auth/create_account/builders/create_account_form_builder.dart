import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../cubits/form/create_account_form_cubit.dart';

import '../../../../../core/design_system/constants/app_images.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../../core/design_system/widgets/sellio_text_field.dart';
import 'package:sellio_mobile/domain/services/country_service.dart';
import 'package:sellio_mobile/di/injection_container.dart';
import '../cubits/form/create_account_form_cubit.dart';
import '../cubits/form/create_account_form_state.dart';
import 'profile_picture_builder.dart';

class CreateAccountFormWidget extends StatefulWidget {
  const CreateAccountFormWidget({super.key});

  @override
  State<CreateAccountFormWidget> createState() =>
      _CreateAccountFormWidgetState();
}

class _CreateAccountFormWidgetState extends State<CreateAccountFormWidget> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final phoneFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final countryFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      context
          .read<CreateAccountFormCubit>()
          .updatePhoneNumber(phoneController.text);
    });
    nameController.addListener(() {
      context
          .read<CreateAccountFormCubit>()
          .updateFullName(nameController.text);
    });
    countryController.addListener(() {
      context
          .read<CreateAccountFormCubit>()
          .updateCountry(countryController.text);
    });
    cityController.addListener(() {
      context.read<CreateAccountFormCubit>().updateCity(cityController.text);
    });
    passwordController.addListener(() {
      context
          .read<CreateAccountFormCubit>()
          .updatePassword(passwordController.text);
    });
    confirmPasswordController.addListener(() {
      context
          .read<CreateAccountFormCubit>()
          .updateConfirmPassword(confirmPasswordController.text);
    });

    phoneFocusNode.addListener(() => _onFocusChange(CreateAccountFieldType.phone));
    nameFocusNode.addListener(() => _onFocusChange(CreateAccountFieldType.name));
    countryFocusNode.addListener(() => _onFocusChange(CreateAccountFieldType.country));
    cityFocusNode.addListener(() => _onFocusChange(CreateAccountFieldType.city));
    passwordFocusNode.addListener(() => _onFocusChange(CreateAccountFieldType.password));
    confirmPasswordFocusNode
        .addListener(() => _onFocusChange(CreateAccountFieldType.confirmPassword));
  }

  void _onFocusChange(CreateAccountFieldType fieldType) {
    switch (fieldType) {
      case CreateAccountFieldType.phone:
        if (!phoneFocusNode.hasFocus && phoneController.text.isNotEmpty) {
          context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
                CreateAccountFieldType.phone,
                phoneController.text,
                context.local,
              );
        }
        break;
      case CreateAccountFieldType.name:
        if (!nameFocusNode.hasFocus && nameController.text.isNotEmpty) {
          context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
                CreateAccountFieldType.name,
                nameController.text,
                context.local,
              );
        }
        break;
      case CreateAccountFieldType.country:
        if (!countryFocusNode.hasFocus && countryController.text.isNotEmpty) {
          context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
                CreateAccountFieldType.country,
                countryController.text,
                context.local,
              );
        }
        break;
      case CreateAccountFieldType.city:
        if (!cityFocusNode.hasFocus && cityController.text.isNotEmpty) {
          context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
                CreateAccountFieldType.city,
                cityController.text,
                context.local,
              );
        }
        break;
      case CreateAccountFieldType.password:
        if (!passwordFocusNode.hasFocus && passwordController.text.isNotEmpty) {
          context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
                CreateAccountFieldType.password,
                passwordController.text,
                context.local,
              );
        }
        break;
      case CreateAccountFieldType.confirmPassword:
        if (!confirmPasswordFocusNode.hasFocus &&
            confirmPasswordController.text.isNotEmpty) {
          context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
                CreateAccountFieldType.confirmPassword,
                confirmPasswordController.text,
                context.local,
              );
        }
        break;
    }
  }

  @override
  void dispose() {
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
    return BlocBuilder<CreateAccountFormCubit, CreateAccountFormState>(
      builder: (context, state) {
        if (state is! CreateAccountFormChanged) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
                hintText: context.local.phone_number,
                inputType: TextInputType.phone,
                isPhoneNumber: true,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[+\d]')),
                  LengthLimitingTextInputFormatter(11),
                ],
                controller: phoneController,
                selectedCountry: state.selectedCountry,
                countries: sl<CountryService>().getAvailableCountries(),
                onChangeCountry: (c) => context
                    .read<CreateAccountFormCubit>()
                    .updateSelectedCountry(c),
              ),
            ),
            Focus(
              focusNode: nameFocusNode,
              child: SellioTextField(
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
            ),
            Row(
              children: [
                Expanded(
                  child: Focus(
                    focusNode: countryFocusNode,
                    child: SellioTextField(
                      controller: countryController,
                      hintText: context.local.country,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                      ],
                      prefixIconPadding:
                          const EdgeInsets.only(left: 16, right: 8),
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
                      hintText: context.local.city,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                      ],
                      prefixIconPadding:
                          const EdgeInsets.only(left: 16, right: 8),
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
            Focus(
              focusNode: passwordFocusNode,
              child: SellioTextField(
                controller: passwordController,
                hintText: context.local.password,
                prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
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
            Focus(
              focusNode: confirmPasswordFocusNode,
              child: SellioTextField(
                controller: confirmPasswordController,
                hintText: context.local.confirm_password,
                prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
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
            buildProfilePictureSection(context),
          ],
        );
      },
    );
  }
}

Widget buildCreateAccountForm(BuildContext context) {
  return CreateAccountFormWidget();
}
