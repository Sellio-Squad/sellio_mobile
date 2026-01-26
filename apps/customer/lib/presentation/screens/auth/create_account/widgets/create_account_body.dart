import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../shared/enums/form_field_type.dart';
import '../../shared/widgets/phone_input_with_country.dart';
import '../cubit/registration_cubit.dart';
import '../cubit/registration_state.dart';
import 'create_account_footer.dart';
import 'create_account_header.dart';


class CreateAccountBody extends StatefulWidget {
  const CreateAccountBody({super.key});

  @override
  State<CreateAccountBody> createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final FocusNode _firstNameFocusNode;
  late final FocusNode _lastNameFocusNode;
  late final FocusNode _phoneFocusNode;
  late final FocusNode _cityFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeFocusNodes();
    _setupListeners();
  }

  void _initializeControllers() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _cityController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void _initializeFocusNodes() {
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  void _setupListeners() {
    final cubit = context.read<RegistrationCubit>();
    _firstNameController
        .addListener(() => cubit.updateFirstName(_firstNameController.text));
    _lastNameController
        .addListener(() => cubit.updateLastName(_lastNameController.text));
    _phoneController
        .addListener(() => cubit.updatePhoneNumber(_phoneController.text));
    _cityController.addListener(() => cubit.updateCity(_cityController.text));
    _passwordController
        .addListener(() => cubit.updatePassword(_passwordController.text));
    _confirmPasswordController.addListener(
        () => cubit.updateConfirmPassword(_confirmPasswordController.text));

    _setupFocusListener(
        _firstNameFocusNode, _firstNameController, FormFieldType.firstName);
    _setupFocusListener(
        _lastNameFocusNode, _lastNameController, FormFieldType.lastName);
    _setupFocusListener(_phoneFocusNode, _phoneController, FormFieldType.phone);
    _setupFocusListener(_cityFocusNode, _cityController, FormFieldType.city);
    _setupFocusListener(
        _passwordFocusNode, _passwordController, FormFieldType.password);
    _setupFocusListener(_confirmPasswordFocusNode, _confirmPasswordController,
        FormFieldType.confirmPassword);
  }

  void _setupFocusListener(FocusNode focusNode,
      TextEditingController controller, FormFieldType fieldType) {
    focusNode.addListener(() {
      if (!focusNode.hasFocus && controller.text.isNotEmpty) {
        context
            .read<RegistrationCubit>()
            .validateFieldOnFocusChange(fieldType, controller.text);
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _cityFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buildCreateAccountHeader(context),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildForm(context),
                ),
                const SizedBox(height: 16), // Add bottom spacing
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Container(
            decoration: BoxDecoration(
              color: context.theme.colors.surfaceLow,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -2),
                  blurRadius: 8,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSubmitButton(context),
                const SizedBox(height: 8),
                buildCreateAccountFooter(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final selectedCountryCode =state.selectedCountryCode;
        final selectedCountry =
            state.selectedCountry ?? Country.parse(selectedCountryCode);

        final colors = context.theme.colors;
        final typography = context.theme.typography;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNameFields(colors),
            PhoneInputWithCountry(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              selectedCountry: selectedCountry,
              onCountrySelected: (country) {
                context
                    .read<RegistrationCubit>()
                    .updateSelectedCountryCode(country.countryCode);
              },
            ),
            const SizedBox(height: 12),
            _buildCityField(colors),
            _buildPasswordField(colors, typography),
            _buildConfirmPasswordField(colors, typography),
          ],
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final isFormValid = state is RegistrationIdle && state.isFormValid;
        final isLoading = state is RegistrationSubmitting;

        return SellioButton(
          text: context.local.continue_text,
          onTap: isFormValid && !isLoading
              ? context.read<RegistrationCubit>().register
              : null,
          isLoading: isLoading,
          isEnabled: isFormValid,
        );
      },
    );
  }

  Widget _buildNameFields(dynamic colors) {
    return Row(
      children: [
        Expanded(
          child: Focus(
            focusNode: _firstNameFocusNode,
            child: SellioTextField(
              controller: _firstNameController,
              hintText: context.local.first_name,
              inputFormatter: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z\u0600-\u06FF ]')),
              ],
              prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
              prefixIcon: SvgPicture.asset(
                AppImages.account,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Focus(
            focusNode: _lastNameFocusNode,
            child: SellioTextField(
              controller: _lastNameController,
              hintText: context.local.last_name,
              inputFormatter: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z\u0600-\u06FF ]')),
              ],
              prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
              prefixIcon: SvgPicture.asset(
                AppImages.account,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCityField(dynamic colors) {
    return Focus(
      focusNode: _cityFocusNode,
      child: SellioTextField(
        controller: _cityController,
        hintText: context.local.city,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0600-\u06FF ]')),
        ],
        prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
        prefixIcon: SvgPicture.asset(
          AppImages.location,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildPasswordField(dynamic colors, dynamic typography) {
    return Focus(
      focusNode: _passwordFocusNode,
      child: SellioTextField(
        textStyle:
            typography.textTheme.labelSmall.copyWith(color: colors.title),
        controller: _passwordController,
        hintText: context.local.password,
        prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
        inputType: TextInputType.visiblePassword,
        prefixIcon: SvgPicture.asset(
          AppImages.password,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField(dynamic colors, dynamic typography) {
    return Focus(
      focusNode: _confirmPasswordFocusNode,
      child: SellioTextField(
        textStyle:
            typography.textTheme.labelSmall.copyWith(color: colors.title),
        controller: _confirmPasswordController,
        hintText: context.local.confirm_password,
        prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
        inputType: TextInputType.visiblePassword,
        prefixIcon: SvgPicture.asset(
          AppImages.password,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
        ),
      ),
    );
  }
}
