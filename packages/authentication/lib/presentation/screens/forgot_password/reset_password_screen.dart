import 'package:core/domain/repositories/country_repository.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/localization/auth_localization_service.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../navigation/auth_navigator.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';
import 'widgets/lock_icon.dart';

class ResetPasswordScreen extends StatelessWidget {
  final AuthRepository authRepository;
  final CountryRepository countryRepository;
  final AuthNavigator navigator;

  const ResetPasswordScreen({
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
        startWithVerified: true,
      )..loadInitialCountry(),
      child: _ResetPasswordScreenContent(navigator: navigator),
    );
  }
}

class _ResetPasswordScreenContent extends StatefulWidget {
  final AuthNavigator navigator;

  const _ResetPasswordScreenContent({required this.navigator});

  @override
  State<_ResetPasswordScreenContent> createState() =>
      _ResetPasswordScreenContentState();
}

class _ResetPasswordScreenContentState
    extends State<_ResetPasswordScreenContent> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      context
          .read<ForgotPasswordCubit>()
          .updateNewPassword(_passwordController.text);
    });
    _confirmPasswordController.addListener(() {
      context
          .read<ForgotPasswordCubit>()
          .updateConfirmPassword(_confirmPasswordController.text);
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          SnackBarHelper.showSuccess(
            context,
            context.authLocal.success, // Placeholder
            title: context.authLocal.success,
          );
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (context.mounted) {
              widget.navigator.pushLogin();
            }
          });
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
        final isFormValid =
            state is ForgotPasswordVerified && state.isResetFormValid;
        final isLoading = state is ForgotPasswordResetting;

        return Scaffold(
          appBar: SellioAppBar(
            title: context.authLocal.title_forget_password,
          ),
          backgroundColor: colors.surfaceLow,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Center(child: LockIcon()),
                    const SizedBox(height: 40),
                    Text(
                      context.authLocal.set_new_password,
                      style:
                          textTheme.headlineSmall.copyWith(color: colors.title),
                    ),
                    const Gap(32),
                    SellioTextField(
                      textStyle:
                          textTheme.labelSmall.copyWith(color: colors.title),
                      controller: _passwordController,
                      hintText: context.authLocal.password,
                      inputType: TextInputType.visiblePassword,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 12),
                        child: SvgPicture.asset(
                          AppImages.password,
                          width: 24,
                          height: 24,
                          colorFilter:
                              ColorFilter.mode(colors.body, BlendMode.srcIn),
                        ),
                      ),
                      isError: state is ForgotPasswordVerified &&
                          state.passwordError != null,
                      errorMessage: state is ForgotPasswordVerified
                          ? state.passwordError?.toLocalizedString(context)
                          : null,
                    ),
                    const Gap(16),
                    SellioTextField(
                      textStyle:
                          textTheme.labelSmall.copyWith(color: colors.title),
                      controller: _confirmPasswordController,
                      hintText: context.authLocal.confirm_password,
                      inputType: TextInputType.visiblePassword,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 12),
                        child: SvgPicture.asset(
                          AppImages.password,
                          width: 24,
                          height: 24,
                          colorFilter:
                              ColorFilter.mode(colors.body, BlendMode.srcIn),
                        ),
                      ),
                      isError: state is ForgotPasswordVerified &&
                          state.confirmPasswordError != null,
                      errorMessage: state is ForgotPasswordVerified
                          ? state.confirmPasswordError
                              ?.toLocalizedString(context)
                          : null,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom + 16),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SellioButton(
              text: context.authLocal.send,
              onTap: isFormValid && !isLoading ? cubit.resetPassword : null,
              isLoading: isLoading,
              backgroundColor: isFormValid ? colors.primary : colors.disabled,
              textColor: isFormValid ? colors.onPrimary : colors.hint,
            ),
          ),
        );
      },
    );
  }
}
