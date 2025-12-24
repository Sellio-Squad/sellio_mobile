import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:design_system/design_system.dart';
import '../../enums/form_field_type.dart';
import '../../shared/widgets/phone_input_with_country.dart';
import '../cubits/form/create_account_form_cubit.dart';
import '../cubits/form/create_account_form_state.dart';
import 'profile_picture_builder.dart';

class CreateAccountFormWidget extends StatefulWidget {
  const CreateAccountFormWidget({super.key});

  @override
  State<CreateAccountFormWidget> createState() => _CreateAccountFormWidgetState();
}

class _CreateAccountFormWidgetState extends State<CreateAccountFormWidget> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _cityController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final FocusNode _firstNameFocusNode;
  late final FocusNode _lastNameFocusNode;
  late final FocusNode _phoneFocusNode;
  late final FocusNode _emailFocusNode;
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
    _emailController = TextEditingController();
    _cityController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void _initializeFocusNodes() {
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  void _setupListeners() {
    _firstNameController.addListener(() {
      context.read<CreateAccountFormCubit>().updateFirstName(_firstNameController.text);
    });
    _lastNameController.addListener(() {
      context.read<CreateAccountFormCubit>().updateLastName(_lastNameController.text);
    });
    _phoneController.addListener(() {
      context.read<CreateAccountFormCubit>().updatePhoneNumber(_phoneController.text);
    });
    _emailController.addListener(() {
      context.read<CreateAccountFormCubit>().updateEmail(_emailController.text);
    });
    _cityController.addListener(() {
      context.read<CreateAccountFormCubit>().updateCity(_cityController.text);
    });
    _passwordController.addListener(() {
      context.read<CreateAccountFormCubit>().updatePassword(_passwordController.text);
    });
    _confirmPasswordController.addListener(() {
      context.read<CreateAccountFormCubit>().updateConfirmPassword(_confirmPasswordController.text);
    });

    _setupFocusListeners();
  }

  void _setupFocusListeners() {
    _firstNameFocusNode.addListener(() {
      if (!_firstNameFocusNode.hasFocus && _firstNameController.text.isNotEmpty) {
        context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
          FormFieldType.firstName,
          _firstNameController.text,
        );
      }
    });

    _lastNameFocusNode.addListener(() {
      if (!_lastNameFocusNode.hasFocus && _lastNameController.text.isNotEmpty) {
        context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
          FormFieldType.lastName,
          _lastNameController.text,
        );
      }
    });

    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus && _phoneController.text.isNotEmpty) {
        context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
          FormFieldType.phone,
          _phoneController.text,
        );
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus && _emailController.text.isNotEmpty) {
        context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
          FormFieldType.email,
          _emailController.text,
        );
      }
    });

    _cityFocusNode.addListener(() {
      if (!_cityFocusNode.hasFocus && _cityController.text.isNotEmpty) {
        context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
          FormFieldType.city,
          _cityController.text,
        );
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus && _passwordController.text.isNotEmpty) {
        context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
          FormFieldType.password,
          _passwordController.text,
        );
      }
    });

    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus &&
          _confirmPasswordController.text.isNotEmpty) {
        context.read<CreateAccountFormCubit>().validateFieldOnFocusChange(
          FormFieldType.confirmPassword,
          _confirmPasswordController.text,
        );
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _cityFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountFormCubit, CreateAccountFormState>(
      builder: (context, state) {
        if (state is! CreateAccountFormLoaded) {
          return const SizedBox.shrink();
        }

        final colors = context.theme.colors;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNameFields(colors),
            const SizedBox(height: 16),
            PhoneInputWithCountry(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              selectedCountry: state.selectedCountry,
              onCountrySelected: (country) {
                context.read<CreateAccountFormCubit>().updateSelectedCountry(country);
              },
            ),
            const SizedBox(height: 16),
            _buildEmailField(colors),
            const SizedBox(height: 16),
            _buildCityField(colors),
            const SizedBox(height: 16),
            _buildPasswordField(colors),
            const SizedBox(height: 16),
            _buildConfirmPasswordField(colors),
            const SizedBox(height: 16),
            buildProfilePictureSection(context),
          ],
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
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0600-\u06FF ]')),
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
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0600-\u06FF ]')),
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

  Widget _buildEmailField(dynamic colors) {
    return Focus(
      focusNode: _emailFocusNode,
      child: SellioTextField(
        controller: _emailController,
        hintText: context.local.email,
        inputType: TextInputType.emailAddress,
        prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
        prefixIcon: SvgPicture.asset(
          AppImages.email,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
        ),
      ),
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

  Widget _buildPasswordField(dynamic colors) {
    return Focus(
      focusNode: _passwordFocusNode,
      child: SellioTextField(
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

  Widget _buildConfirmPasswordField(dynamic colors) {
    return Focus(
      focusNode: _confirmPasswordFocusNode,
      child: SellioTextField(
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