import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/design_system/constants/app_strings.dart';
import '../../../../../core/design_system/constants/assets.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../../core/design_system/widgets/textField.dart';
import '../../country.dart';
import '../cubits/form/create_account_form_cubit.dart';
import '../cubits/form/create_account_form_state.dart';

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

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() =>
        context.read<CreateAccountFormCubit>().updatePhoneNumber(
            phoneController.text));
    nameController.addListener(() =>
        context.read<CreateAccountFormCubit>().updateFullName(
            nameController.text));
    countryController.addListener(() =>
        context.read<CreateAccountFormCubit>().updateCountry(
            countryController.text));
    cityController.addListener(() =>
        context.read<CreateAccountFormCubit>().updateCity(cityController.text));
    passwordController.addListener(() =>
        context.read<CreateAccountFormCubit>().updatePassword(
            passwordController.text));
    confirmPasswordController.addListener(() =>
        context.read<CreateAccountFormCubit>().updateConfirmPassword(
            confirmPasswordController.text));
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
    return BlocBuilder<CreateAccountFormCubit, CreateAccountFormState>(
      builder: (context, state) {
        if (state is! CreateAccountFormChanged) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            // Phone Number Field
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
              selectedCountry: state.selectedCountry,
              countries: mockCountries,
              onChangeCountry:
                  context.read<CreateAccountFormCubit>().updateSelectedCountry,
            ),
            const SizedBox(height: 6),

            // Full Name Field
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
            const SizedBox(height: 6),

            // Country and City Fields
            Row(
              children: [
                Expanded(
                  child: SellioTextField(
                    controller: countryController,
                    hintText: AppStrings.country,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                    ],
                    prefixIconPadding:
                        const EdgeInsets.only(left: 16, right: 8),
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
                const SizedBox(width: 8),
                Expanded(
                  child: SellioTextField(
                    controller: cityController,
                    hintText: AppStrings.city,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                    ],
                    prefixIconPadding:
                        const EdgeInsets.only(left: 16, right: 8),
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

            // Password Field
            SellioTextField(
              controller: passwordController,
              hintText: AppStrings.password,
              prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
              inputType: TextInputType.visiblePassword,
              prefixIcon: SvgPicture.asset(
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

            // Confirm Password Field
            SellioTextField(
              controller: confirmPasswordController,
              hintText: AppStrings.confirmPassword,
              prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
              inputType: TextInputType.visiblePassword,
              prefixIcon: SvgPicture.asset(
                Assets.password,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.body,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget buildCreateAccountForm(BuildContext context) {
  return const CreateAccountFormWidget();
}