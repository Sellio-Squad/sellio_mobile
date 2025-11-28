import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/design_system/constants/app_images.dart';
import '../../../../core/design_system/widgets/sellio_app_bar.dart';
import '../../../../core/design_system/widgets/sellio_text_field.dart';
import '../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../core/design_system/widgets/buttons/sellio_button.dart';
import 'widget/lock_icon.dart';

import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../core/navigate/routing.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../core/error/result.dart';
import '../country.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController phoneController = TextEditingController();
  late Country selectedCountry;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    selectedCountry = mockCountries.firstWhere((c) => c.code == "+964");

    phoneController.addListener(() {
      setState(() => isValid = phoneController.text.trim().isNotEmpty);
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> sendOtp() async {
    final repo = context.read<AuthRepository>();

    final Result result = await repo.sendForgotPasswordOtp(
      phoneNumber: phoneController.text.trim(),
      countryCode: selectedCountry.code,
    );

    if (result is Success) {
      context.navigator.pushForgetPasswordOtp(
        ForgetPasswordOtpArgs(
          phoneNumber: phoneController.text.trim(),
          countryCode: selectedCountry.code,      //✔ FIXED
        ),
      );
    } else if (result is ResultFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.failure.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final text = context.theme.typography.textTheme;

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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Gap(24),
                      Center(child: buildLockIcon(colors)),
                      const Gap(40),

                      Text(context.local.title_forget_password,
                          style: text.headlineSmall.copyWith(color: colors.title)),
                      const Gap(8),
                      Text(context.local.subtitle_forget_password,
                          style: text.bodyMedium.copyWith(color: colors.body)),
                      const Gap(24),

                      SellioTextField(
                        controller: phoneController,
                        hintText: context.local.phone_number,
                        isPhoneNumber: true,
                        selectedCountry: selectedCountry,
                        countries: mockCountries,
                        onChangeCountry: (c) => setState(() => selectedCountry = c),
                        prefixIcon: SvgPicture.asset(AppImages.phone, width: 22),
                        inputType: TextInputType.phone,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SellioButton(
                text: context.local.send,
                isEnabled: isValid,
                onTap: isValid ? sendOtp : null,
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
