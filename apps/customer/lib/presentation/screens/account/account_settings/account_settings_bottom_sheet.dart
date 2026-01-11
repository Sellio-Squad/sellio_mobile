import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/domain/repositories/user_repository.dart';
import 'package:sellio_mobile/presentation/screens/account/account_settings/cubit/account_settings_cubit.dart';
import 'package:sellio_mobile/presentation/screens/auth/shared/widgets/phone_input_with_country.dart';

import 'cubit/account_settings_state.dart';

class AccountSettingsBottomSheet extends StatefulWidget {
  final VoidCallback? onSave;

  const AccountSettingsBottomSheet({super.key, this.onSave});

  static Future<AccountSettingsState?> show({
    required BuildContext context,
    required VoidCallback onSave,
  }) {
    return SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: BlocProvider(
        create: (context) => AccountSettingsCubit(
          context.read<UserRepository>(),
        )..loadAccountDetails(),
        child: AccountSettingsBottomSheet(onSave: onSave),
      ),
    );
  }

  @override
  State<AccountSettingsBottomSheet> createState() =>
      _AccountSettingsBottomSheetState();
}

class _AccountSettingsBottomSheetState
    extends State<AccountSettingsBottomSheet> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      context.read<AccountSettingsCubit>().updatePhoneNumber(
            _phoneController.text,
            selectedCountry:
                context.read<AccountSettingsCubit>().state.selectedCountry!,
          );
    });

    _nameController.addListener(() {
      context.read<AccountSettingsCubit>().updateName(
            _nameController.text,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountSettingsCubit, AccountSettingsState>(
        listener: (context, state) {
      if (state.isSuccess) {
        _showSnackBar(context, context.local.updated_successfully);
        Navigator.of(context).pop(state);
      }
      if (!_isDataLoaded && state.fullName.isNotEmpty) {
        _nameController.text = state.fullName;
        _phoneController.text = state.phoneNumber;
        _isDataLoaded = true;
      }
    }, builder: (context, state) {
      final cubit = context.read<AccountSettingsCubit>();
      return SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.local.account_settings,
              style: context.theme.typography.textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            PhoneInputWithCountry(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              selectedCountry: state.selectedCountry,
              onCountrySelected: (country) {
                context
                    .read<AccountSettingsCubit>()
                    .updateSelectedCountry(country);
              },
            ),
            const SizedBox(height: 6),
            SellioTextField(
              controller: _nameController,
              hintText: context.local.full_name,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
              ],
              prefixIconPadding: const EdgeInsets.only(left: 16, right: 8),
              prefixIcon: SvgPicture.asset(
                AppImages.account,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.body,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (state.errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.theme.colors.errorVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: context.theme.colors.errorVariant,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage!,
                        style: context.theme.typography.textTheme.labelSmall
                            .copyWith(
                          color: context.theme.colors.errorVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            SellioButton(
              text: context.local.save_changes,
              onTap: () => cubit.updateAccountDetails(
                state.selectedCountry!,
              ),
              isEnabled: state.isFormValid &&
                  state.isPhoneNumberValid(
                      state.selectedCountry!, _phoneController.text),
              verticalPadding: 13,
              fullWidth: true,
              isLoading: state.isLoading,
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 26,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SellioSnackBar(
              isError: false,
              message: message,
              onCancelTap: () {
                overlayEntry.remove();
              },
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 4), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
