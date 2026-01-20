import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/domain/repositories/user_repository.dart';
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
        create: (context) => ResetPasswordCubit(
          context.read<UserRepository>(),
        ),
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
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.local.password_changed_successfully),
              backgroundColor: context.theme.colors.body,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                child: SvgPicture.asset(
                  AppImages.password,
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            const SizedBox(height: 12),

            SellioTextField(
              controller: newCtrl,
              hintText: context.local.new_password,
              inputType: TextInputType.visiblePassword,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: SvgPicture.asset(
                  AppImages.password,
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            if (newCtrl.text.isNotEmpty && !state.isNewPasswordValid)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  context.local.password_must_be_at_least_characters,
                  style: context.theme.typography.textTheme.labelSmall.copyWith(
                    color: context.theme.colors.semanticError,
                  ),
                ),
              ),

            const SizedBox(height: 12),

            SellioTextField(
              controller: confirmCtrl,
              hintText: context.local.confirm_new_password,
              inputType: TextInputType.visiblePassword,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: SvgPicture.asset(
                  AppImages.password,
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            if (confirmCtrl.text.isNotEmpty && !state.passwordsMatch)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  context.local.passwords_do_not_match,
                  style: context.theme.typography.textTheme.labelSmall.copyWith(
                    color: context.theme.colors.semanticError,
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Error Message
            if (state.errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.theme.colors.hint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: context.theme.colors.hint,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage!,
                        style: context.theme.typography.textTheme.labelSmall
                            .copyWith(
                          color: context.theme.colors.hint,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Submit Button
            SellioButton(
              text: state.isLoading ? context.local.saving : context.local.save,
              onTap: state.isFormValid && !state.isLoading
                  ? () => cubit.submit(widget.onSave)
                  : null,
              isEnabled: state.isFormValid && !state.isLoading,
              verticalPadding: 13,
            ),
          ],
        );
      },
    );
  }
}