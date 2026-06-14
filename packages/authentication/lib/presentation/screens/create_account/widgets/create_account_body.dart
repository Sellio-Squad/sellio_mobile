import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/sellio_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_picker/country_picker.dart';
import '../../../../core/localization/auth_localization_service.dart';
import '../../../../core/utils/full_name_input_formatter.dart';
import '../../../navigation/auth_navigator.dart';
import '../cubit/registration_cubit.dart';
import '../cubit/registration_state.dart';
import 'create_account_footer.dart';
import 'create_account_header.dart';

class CreateAccountBody extends StatefulWidget {
  final AuthNavigator navigator;

  const CreateAccountBody({
    super.key,
    required this.navigator,
  });

  @override
  State<CreateAccountBody> createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final FocusNode _fullNameFocusNode;
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
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
    _cityController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void _initializeFocusNodes() {
    _fullNameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  void _setupListeners() {
    final cubit = context.read<RegistrationCubit>();
    _fullNameController
        .addListener(() => cubit.updateFullName(_fullNameController.text));
    _phoneController
        .addListener(() => cubit.updatePhoneNumber(_phoneController.text));
    _cityController.addListener(() => cubit.updateCity(_cityController.text));
    _passwordController
        .addListener(() => cubit.updatePassword(_passwordController.text));
    _confirmPasswordController.addListener(
      () => cubit.updateConfirmPassword(_confirmPasswordController.text),
    );

    _fullNameFocusNode.addListener(() {
      if (!_fullNameFocusNode.hasFocus) {
        cubit.validateFullNameOnFocusLost(_fullNameController.text);
      }
    });

    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        cubit.validatePhoneOnFocusLost(_phoneController.text);
      }
    });

    _cityFocusNode.addListener(() {
      if (!_cityFocusNode.hasFocus) {
        cubit.validateCityOnFocusLost(_cityController.text);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        cubit.validatePasswordOnFocusLost(_passwordController.text);
      }
    });

    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus) {
        cubit.validateConfirmPasswordOnFocusLost(
          _confirmPasswordController.text,
        );
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _fullNameFocusNode.dispose();
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CreateAccountHeader(),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildForm(context),
                ),
                const SizedBox(height: 16),
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
                CreateAccountFooter(navigator: widget.navigator),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    Country? lastValidCountry;

    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        if (state is RegistrationIdle) {
          lastValidCountry = state.selectedCountry;
        }
        final selectedCountry = lastValidCountry;
        final colors = context.theme.colors;
        final typography = context.theme.typography;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNameFields(colors),
            const SizedBox(height: 12),
            SellioPhoneField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              hintText: context.authLocal.phone_number,
              searchHintText: context.authLocal.search_by_name_or_code,
              selectedCountry: selectedCountry,
              onCountrySelected: (country) {
                context
                    .read<RegistrationCubit>()
                    .updateSelectedCountry(country);
              },
            ),
            const SizedBox(height: 12),
            _buildCityField(colors),
            const SizedBox(height: 12),
            _buildPasswordField(colors, typography),
            const SizedBox(height: 12),
            _buildConfirmPasswordField(colors, typography),
          ],
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final (isEnabled, isLoading) = switch (state) {
          RegistrationIdle(:final isFormValid) => (isFormValid, false),
          RegistrationSubmitting() => (false, true),
          _ => (false, false),
        };

        return SellioButton(
          text: context.authLocal.continue_text,
          onTap: isEnabled && !isLoading
              ? context.read<RegistrationCubit>().register
              : null,
          isLoading: isLoading,
          isEnabled: isEnabled,
        );
      },
    );
  }

  Widget _buildNameFields(dynamic colors) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Focus(
                focusNode: _fullNameFocusNode,
                child: SellioTextField(
                  controller: _fullNameController,
                  hintText: context.authLocal.full_name,
                  isError:
                      state is RegistrationIdle && state.fullNameError != null,
                  errorMessage: state is RegistrationIdle
                      ? state.fullNameError?.toLocalizedString(context)
                      : null,
                  inputFormatter: [
                    FullNameInputFormatter(),
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
      },
    );
  }

  Widget _buildCityField(dynamic colors) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        if (state is! RegistrationIdle) return const SizedBox();

        final cityItems =
            state.cities.map((city) => SellioPickerItem(city, city)).toList();

        return SellioPickerField<String>(
          hintText: context.authLocal.city,
          value: state.city.isNotEmpty ? state.city : null,
          items: cityItems,
          onChanged: (selectedCity) {
            if (selectedCity != null) {
              _cityController.text = selectedCity;
              context.read<RegistrationCubit>().updateCity(selectedCity);
              _cityFocusNode.unfocus();
            }
          },
          focusNode: _cityFocusNode,
        );
      },
    );
  }

  Widget _buildPasswordField(dynamic colors, dynamic typography) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Focus(
          focusNode: _passwordFocusNode,
          child: SellioTextField(
            textStyle:
                typography.textTheme.labelSmall.copyWith(color: colors.title),
            controller: _passwordController,
            hintText: context.authLocal.password,
            isError: state is RegistrationIdle && state.passwordError != null,
            errorMessage: state is RegistrationIdle
                ? state.passwordError?.toLocalizedString(context)
                : null,
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
      },
    );
  }

  Widget _buildConfirmPasswordField(dynamic colors, dynamic typography) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Focus(
          focusNode: _confirmPasswordFocusNode,
          child: SellioTextField(
            textStyle:
                typography.textTheme.labelSmall.copyWith(color: colors.title),
            controller: _confirmPasswordController,
            hintText: context.authLocal.confirm_password,
            isError:
                state is RegistrationIdle && state.confirmPasswordError != null,
            errorMessage: state is RegistrationIdle
                ? state.confirmPasswordError?.toLocalizedString(context)
                : null,
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
      },
    );
  }
}
