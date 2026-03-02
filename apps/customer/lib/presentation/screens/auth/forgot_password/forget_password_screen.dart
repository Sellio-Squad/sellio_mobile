import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'package:sellio_mobile/core/utils/snackbar_helper.dart';
import 'package:sellio_mobile/domain/repositories/country_repository.dart';
import '../../../../di/injection_container.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../shared/otp/otp_screen.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';
import 'widgets/lock_icon.dart';
import 'package:country_picker/country_picker.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        authRepository: sl<AuthRepository>(),
        countryRepository: sl<CountryRepository>(),
      )..loadInitialCountry(),
      child: const _ForgetPasswordScreenContent(),
    );
  }
}

class _ForgetPasswordScreenContent extends StatefulWidget {
  const _ForgetPasswordScreenContent();

  @override
  State<_ForgetPasswordScreenContent> createState() => _ForgetPasswordScreenContentState();
}

class _ForgetPasswordScreenContentState extends State<_ForgetPasswordScreenContent> {
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ForgotPasswordCubit>();
    _phoneController = TextEditingController(text: cubit.state is ForgotPasswordIdle ? (cubit.state as ForgotPasswordIdle).phoneNumber : '');
    _phoneController.addListener(() {
      cubit.updatePhoneNumber(_phoneController.text);
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
    Country? lastValidCountry;

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordIdle) {
          lastValidCountry = state.selectedCountry;
        }
        if (state is ForgotPasswordOtpRequired) {
          _navigateToOtpScreen(context, state);
        } else if (state is ForgotPasswordFailure) {
          SnackBarHelper.showError(context, state.errorMessage ?? context.local.error_generic);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ForgotPasswordCubit>();
        final isPhoneFilled = state is ForgotPasswordIdle && state.isFormValid;
        final isLoading = state is ForgotPasswordSendingOtp;

        return Scaffold(
          appBar: SellioAppBar(
            title: context.local.title_par_forget_password,
            showBackButton: true,
          ),
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
                          SellioPhoneField(
                            controller: _phoneController,
                            hintText: context.local.phone_number,
                            searchHintText: context.local.search_by_name_or_code,
                            selectedCountry:lastValidCountry,
                            onCountrySelected: cubit.updateSelectedCountry,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SellioButton(
                    text: context.local.send,
                    onTap: isPhoneFilled && !isLoading ? cubit.sendOtp : null,
                    isLoading: isLoading,
                    backgroundColor: isPhoneFilled ? colors.primary : colors.disabled,
                    textColor: isPhoneFilled ? colors.onPrimary : colors.hint,
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToOtpScreen(BuildContext context, ForgotPasswordOtpRequired state) {
    final cubit = context.read<ForgotPasswordCubit>();
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpScreen(
          title: context.local.verify_phone_number,
          subtitle: context.local.enter_the_4_digit_sent_to(state.phoneNumber),
          phoneNumber: state.phoneNumber,
          onVerify: (otp) => cubit.verifyOtp(otp),
          onVerifySuccess: () {
             context.pushNamed(AppRoutes.confirmPassword.name);
          },
        ),
      ),
    ).then((_) {
      cubit.resetToIdle();
    });
  }
}