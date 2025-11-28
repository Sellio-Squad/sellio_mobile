import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/design_system/constants/app_images.dart';
import '../../../../core/design_system/widgets/sellio_app_bar.dart';
import '../../../../core/design_system/widgets/sellio_text_field.dart';
import '../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../core/design_system/widgets/buttons/sellio_button.dart';
import 'widget/lock_icon.dart';

import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';

import '../../../../domain/repositories/auth_repository.dart';
import '../../../../core/error/result.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final ConfirmPasswordArgs args;

  const SetNewPasswordScreen({
    super.key,
    required this.args,
  });

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  bool get isValid =>
      passwordCtrl.text.isNotEmpty &&
          confirmCtrl.text.isNotEmpty &&
          passwordCtrl.text == confirmCtrl.text;

  @override
  void dispose() {
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!isValid) return;

    final repo = context.read<AuthRepository>();

    final result = await repo.resetPassword(
      phoneNumber: widget.args.phoneNumber,
      countryCode: widget.args.countryCode,
      otpCode: widget.args.otp,
      newPassword: passwordCtrl.text.trim(),
    );

    if (result is Success) {
      context.navigator.goToHome();
    } else if (result is ResultFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.failure.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final text = theme.typography.textTheme;

    return Scaffold(
      backgroundColor: colors.surfaceLow,
      appBar: SellioAppBar(
        title: context.local.title_par_forget_password,
        showBackButton: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(24),
                      Center(child: buildLockIcon(colors)),
                      const Gap(40),

                      Text(
                        context.local.set_new_password,
                        style: text.headlineSmall.copyWith(color: colors.title),
                      ),

                      const Gap(8),

                      Text(
                        context.local.subtitle_set_new_password,
                        style: text.bodyMedium.copyWith(color: colors.body),
                      ),

                      const Gap(32),

                      /// NEW PASSWORD
                      SellioTextField(
                        controller: passwordCtrl,
                        hintText: context.local.password,
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: SvgPicture.asset(AppImages.password),
                      ),
                      const Gap(16),

                      /// CONFIRM
                      SellioTextField(
                        controller: confirmCtrl,
                        hintText: context.local.confirm_password,
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: SvgPicture.asset(AppImages.password),
                      ),

                      if (passwordCtrl.text.isNotEmpty &&
                          confirmCtrl.text.isNotEmpty &&
                          passwordCtrl.text != confirmCtrl.text)
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Passwords do not match",
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              SellioButton(
                text: context.local.send,
                isEnabled: isValid,
                onTap: isValid ? submit : null,
              ),

              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
