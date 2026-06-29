import 'package:core/localization/locale_cubit.dart';
import 'package:core/localization/locale_state.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/l10n/localization_service.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet({super.key});

  @override
  State<ChangeLanguageBottomSheet> createState() =>
      _ChangeLanguageBottomSheetState();

  static Future<void> show({required BuildContext context}) {
    return SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: BlocProvider.value(
        value: context.localeCubit,
        child: const ChangeLanguageBottomSheet(),
      ),
    );
  }
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  late Locale currentSelectedLocale;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    currentSelectedLocale = context.read<LocaleCubit>().state.locale;
    _updateSaveButtonState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        context.read<LocaleCubit>();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.local.change_language,
              style: context.theme.typography.textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildLanguageOption(
                    locale: const Locale('en'),
                    languageName: context.local.english,
                    context: context,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildLanguageOption(
                    locale: const Locale('ar'),
                    languageName: context.local.arabic,
                    context: context,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: SellioButton(
                text: context.local.save,
                onTap: _isFormValid
                    ? () async {
                        await _handleSave(context);
                      }
                    : null,
                isEnabled: _isFormValid,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSave(BuildContext context) async {
    try {
      final cubit = context.read<LocaleCubit>();
      await cubit.changeLocale(currentSelectedLocale);

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to change language: $e')),
        );
      }
    }
  }

  void _updateSaveButtonState() {
    final currentLocale = context.read<LocaleCubit>().state.locale;
    final isValid = currentSelectedLocale != currentLocale;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  Widget _buildLanguageOption({
    required Locale locale,
    required String languageName,
    required BuildContext context,
  }) {
    final isSelected = currentSelectedLocale == locale;

    return InkWell(
      onTap: () {
        setState(() {
          currentSelectedLocale = locale;
        });
        _updateSaveButtonState();
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? context.theme.colors.primaryVariant
              : context.theme.colors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SellioRadioButton(
              state: isSelected ? RadioState.checked : RadioState.unchecked,
              onChanged: (RadioState newState) {
                setState(() {
                  currentSelectedLocale = locale;
                });
                _updateSaveButtonState();
              },
              size: 20.0,
            ),
            const SizedBox(width: 12),
            Text(
              languageName,
              style: context.theme.typography.textTheme.labelLarge.copyWith(
                color: isSelected
                    ? context.theme.colors.primary
                    : context.theme.typography.textTheme.labelLarge.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
