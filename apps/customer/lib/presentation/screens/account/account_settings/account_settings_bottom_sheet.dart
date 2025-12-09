import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/domain/repositories/user_repository.dart';
import 'package:sellio_mobile/presentation/screens/account/account_settings/cubit/account_settings_cubit.dart';
import '../../../../presentation/screens/auth/country.dart';
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
        ),
        child: AccountSettingsBottomSheet(onSave: onSave),
      ),
    );
  }


  @override
  State<AccountSettingsBottomSheet> createState() => _AccountSettingsBottomSheetState();
}

class _AccountSettingsBottomSheetState extends State<AccountSettingsBottomSheet> {
  late final TextEditingController phoneController;
  late final TextEditingController nameController;
  final List<Country> _countries = mockCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.firstWhere((c) => c.code == '+964');
    phoneController = TextEditingController();
    nameController = TextEditingController();

    phoneController.addListener(() {
      context.read<AccountSettingsCubit>().updatePhoneNumber(
        phoneController.text,
        selectedCountry: _selectedCountry,
      );
    });

    nameController.addListener(() {
      context.read<AccountSettingsCubit>().updateName(
        nameController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountSettingsCubit, AccountSettingsState>(
        listener: (context, state) {
          if (state.isSuccess) {
            _showErrorSnackBar(context, context.local.updated_successfully);
            Navigator.of(context).pop(state);
          }
        },
        builder: (context, state) {
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

                SellioTextField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SvgPicture.asset(
                      AppImages.phone,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        context.theme.colors.body,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  hintText: context.local.phone_number,
                  inputType: TextInputType.phone,
                  isPhoneNumber: true,
                  controller: phoneController,
                  selectedCountry: _selectedCountry,
                  countries: _countries,
                  onChangeCountry: (c) => setState(() => _selectedCountry = c),
                ),
                const SizedBox(height: 6),

                SellioTextField(
                  controller: nameController,
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

                SellioButton(
                  text: context.local.save_changes,
                  onTap: () => cubit.updateAccountDetails(_selectedCountry),
                  isEnabled: state.isFormValid && state.isPhoneNumberValid(_selectedCountry, phoneController.text),
                  verticalPadding: 13,
                  fullWidth: true,
                  isLoading: state.isLoading,
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(BuildContext context, String message) {
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
