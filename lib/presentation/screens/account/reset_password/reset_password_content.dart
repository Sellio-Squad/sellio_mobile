import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../../core/design_system/constants/app_images.dart';
import '../../../../core/design_system/widgets/buttons/sellio_button.dart';
import '../../../../core/design_system/widgets/sellio_text_field.dart';
import 'cubit/reset_password_cubit.dart';
import 'cubit/reset_password_state.dart';

class ResetPasswordBottomSheet extends StatefulWidget {
  final VoidCallback onSave;

  const ResetPasswordBottomSheet({super.key, required this.onSave});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onSave,
  }) {
    return SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: BlocProvider(
        create: (_) => ResetPasswordCubit(),
        child: ResetPasswordBottomSheet(onSave: onSave),
      ),
    );
  }

  @override
  State<ResetPasswordBottomSheet> createState() =>
      _ResetPasswordBottomSheetState();
}

class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
  late final TextEditingController currentCtrl;
  late final TextEditingController newCtrl;
  late final TextEditingController confirmCtrl;

  @override
  void initState() {
    super.initState();

    currentCtrl = TextEditingController();
    newCtrl = TextEditingController();
    confirmCtrl = TextEditingController();

    /// Connect controllers to cubit
    currentCtrl.addListener(() {
      context.read<ResetPasswordCubit>().updateCurrentPassword(currentCtrl.text);
    });

    newCtrl.addListener(() {
      context.read<ResetPasswordCubit>().updateNewPassword(newCtrl.text);
    });

    confirmCtrl.addListener(() {
      context.read<ResetPasswordCubit>().updateConfirmPassword(confirmCtrl.text);
    });
  }

  @override
  void dispose() {
    currentCtrl.dispose();
    newCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.local.reset_password,
              style: context.theme.typography.textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            SellioTextField(
              controller: currentCtrl,
              hintText: context.local.current_password,
              inputType: TextInputType.visiblePassword,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child:
                SvgPicture.asset(AppImages.password, width: 24, height: 24),
              ),
            ),

            const SizedBox(height: 12),
            SellioTextField(
              controller: newCtrl,
              hintText: context.local.new_password,
              inputType: TextInputType.visiblePassword,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child:
                SvgPicture.asset(AppImages.password, width: 24, height: 24),
              ),
            ),

            const SizedBox(height: 12),
            SellioTextField(
              controller: confirmCtrl,
              hintText: context.local.confirm_new_password,
              inputType: TextInputType.visiblePassword,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child:
                SvgPicture.asset(AppImages.password, width: 24, height: 24),
              ),
            ),

            const SizedBox(height: 24),

            SellioButton(
              text: context.local.save,
              onTap:
              state.isFormValid ? () => cubit.submit(widget.onSave) : null,
              isEnabled: state.isFormValid,
              verticalPadding: 13,
            ),
          ],
        );
      },
    );
  }
}
