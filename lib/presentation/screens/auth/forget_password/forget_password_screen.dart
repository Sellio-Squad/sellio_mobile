import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'package:sellio_mobile/di/injection_container.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import '../../../../core/design_system/constants/app_images.dart';
import '../../../../core/design_system/widgets/sellio_app_bar.dart';
import '../../../../core/design_system/widgets/sellio_text_field.dart';
import 'package:sellio_mobile/domain/entities/country.dart';
import 'package:sellio_mobile/domain/services/country_service.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';
import 'widget/lock_icon.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(authRepository: sl<AuthRepository>()),
      child: const _ForgetPasswordView(),
    );
  }
}

class _ForgetPasswordView extends StatefulWidget {
  const _ForgetPasswordView();

  @override
  State<_ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<_ForgetPasswordView> {
  final _phoneController = TextEditingController();
  late final List<Country> _countries;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    final countryService = sl<CountryService>();
    _countries = countryService.getAvailableCountries();
    _selectedCountry = countryService.getDefaultCountry() ?? _countries.first;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    final fullPhoneNumber = '${_selectedCountry.code}${_phoneController.text}';
    context.read<ForgotPasswordCubit>().requestOtp(
          phoneNumber: fullPhoneNumber,
          defaultRegion: _selectedCountry.code,
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
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordOtpSent) {
            context.navigator.pushForgetPasswordOtp(
              ForgetPasswordOtpArgs(
                phoneNumber: state.phoneNumber,
                sessionId: state.sessionId,
              ),
            );
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ForgotPasswordLoading;
          return SafeArea(
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
                            onChangeCountry: (c) =>
                                setState(() => _selectedCountry = c),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SellioButton(
                    text: context.local.send,
                    isLoading: isLoading,
                    onTap: _phoneController.text.isNotEmpty && !isLoading
                        ? _sendOtp
                        : null,
                    backgroundColor:
                        _phoneController.text.isNotEmpty && !isLoading
                            ? colors.primary
                            : colors.disabled,
                    textColor:
                        _phoneController.text.isNotEmpty && !isLoading
                            ? colors.onPrimary
                            : colors.hint,
                  ),
                  const Gap(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
