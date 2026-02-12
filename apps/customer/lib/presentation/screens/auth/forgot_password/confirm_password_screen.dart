import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../di/injection_container.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../../../../core/navigate/app_routes.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';
import 'widgets/lock_icon.dart';

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        authRepository: sl<AuthRepository>(),
        startWithVerified: true,
      ),
      child: const _SetNewPasswordScreenContent(),
    );
  }
}

class _SetNewPasswordScreenContent extends StatefulWidget {
  const _SetNewPasswordScreenContent();

  @override
  State<_SetNewPasswordScreenContent> createState() =>
      _SetNewPasswordScreenContentState();
}

class _SetNewPasswordScreenContentState
    extends State<_SetNewPasswordScreenContent> {
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
              context, context.local.password_reset_successfully);
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (context.mounted) {
              context.goNamed(AppRoutes.login.name);
            }
          });
        } else if (state is ForgotPasswordFailure) {
          SnackBarHelper.showError(
              context, state.errorMessage ?? context.local.error_generic);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ForgotPasswordCubit>();
        final isFormValid =
            state is ForgotPasswordVerified && state.isResetFormValid;
        final isLoading = state is ForgotPasswordResetting;

        return Scaffold(
          appBar: SellioAppBar(
            title: context.local.title_par_forget_password,
            leading: IconButton(
              icon: SvgPicture.asset(AppImages.arrowLeft),
              onPressed: () {
                context.goNamed(AppRoutes.forgetPassword.name);
              },
            ),
          ),
          backgroundColor: colors.surfaceLow,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Center(child: buildLockIcon(colors)),
                  const SizedBox(height: 40),
                  Text(
                    context.local.set_new_password,
                    style:
                        textTheme.headlineSmall.copyWith(color: colors.title),
                  ),
                  const Gap(32),
                  SellioTextField(
                    textStyle:
                        textTheme.labelSmall.copyWith(color: colors.title),
                    controller: _passwordController,
                    hintText: context.local.password,
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
                  ),
                  const Gap(16),
                  SellioTextField(
                    textStyle:
                        textTheme.labelSmall.copyWith(color: colors.title),
                    controller: _confirmPasswordController,
                    hintText: context.local.confirm_password,
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
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SellioButton(
              text: context.local.send,
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
