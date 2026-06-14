import 'package:core/domain/repositories/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:design_system/design_system.dart';
import 'package:country_picker/country_picker.dart';
import '../../../core/localization/auth_localization_service.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../navigation/auth_navigator.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';
import 'widgets/lock_icon.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthRepository authRepository;
  final CountryRepository countryRepository;
  final AuthNavigator navigator;

  const ForgotPasswordScreen({
    super.key,
    required this.authRepository,
    required this.countryRepository,
    required this.navigator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        authRepository: authRepository,
        countryRepository: countryRepository,
      )..loadInitialCountry(),
      child: _ForgotPasswordScreenContent(navigator: navigator),
    );
  }
}

class _ForgotPasswordScreenContent extends StatefulWidget {
  final AuthNavigator navigator;

  const _ForgotPasswordScreenContent({required this.navigator});

  @override
  State<_ForgotPasswordScreenContent> createState() =>
      _ForgotPasswordScreenContentState();
}

class _ForgotPasswordScreenContentState
    extends State<_ForgotPasswordScreenContent> {
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ForgotPasswordCubit>();
    _phoneController = TextEditingController(
        text: cubit.state is ForgotPasswordIdle
            ? (cubit.state as ForgotPasswordIdle).phoneNumber
            : '');
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
          SnackBarHelper.showError(
            context,
            state.errorMessage ?? context.authLocal.something_went_wrong,
            title: context.authLocal.error,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ForgotPasswordCubit>();
        final isPhoneFilled = state is ForgotPasswordIdle && state.isFormValid;
        final isLoading = state is ForgotPasswordSendingOtp;

        return Scaffold(
          appBar: SellioAppBar(
            title: context.authLocal.title_forget_password,
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
                          const Center(child: LockIcon()),
                          const SizedBox(height: 40),
                          Text(
                            context.authLocal.title_forget_password,
                            style: textTheme.headlineSmall
                                .copyWith(color: colors.title),
                          ),
                          const Gap(8),
                          Text(
                            context.authLocal.subtitle_forget_password,
                            style: textTheme.bodyMedium
                                .copyWith(color: colors.body),
                          ),
                          const Gap(24),
                          SellioPhoneField(
                            controller: _phoneController,
                            hintText: context.authLocal.phone_number,
                            searchHintText:
                                context.authLocal.search_by_name_or_code,
                            selectedCountry: lastValidCountry,
                            onCountrySelected: cubit.updateSelectedCountry,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SellioButton(
                    text: context.authLocal.send,
                    onTap: isPhoneFilled && !isLoading ? cubit.sendOtp : null,
                    isLoading: isLoading,
                    backgroundColor:
                        isPhoneFilled ? colors.primary : colors.disabled,
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

  void _navigateToOtpScreen(
      BuildContext context, ForgotPasswordOtpRequired state) async {
    final cubit = context.read<ForgotPasswordCubit>();

    await widget.navigator.pushOtp(
      phoneNumber: state.phoneNumber,
      onVerify: (otp) => cubit.verifyOtp(otp),
      onVerifySuccess: () => widget.navigator.pushResetPassword(),
    );

    if (context.mounted) {
      cubit.resetToIdle();
    }
  }
}
