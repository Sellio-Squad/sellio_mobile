import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';
import '../../../../core/design_system/widgets/buttons/sellio_button.dart';
import '../../../../core/localization/cubit/locale_cubit.dart';
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

            RadioGroup<Locale>(
              groupValue: currentSelectedLocale,
              onChanged: (Locale? value) {
                if (value != null) {
                  setState(() {
                    currentSelectedLocale = value;
                  });
                  _updateSaveButtonState();
                }
              },
              child: Row(
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
        decoration: BoxDecoration(
          color: isSelected
              ? context.theme.colors.primaryVariant
              : context.theme.colors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<Locale>(
              value: locale,
              groupValue: currentSelectedLocale,
              fillColor:
              WidgetStateColor.resolveWith((Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return context.theme.colors.surface;
                }
                return Colors.transparent;
              }),
              backgroundColor:
              WidgetStateColor.resolveWith((Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return context.theme.colors.primary;
                }
                return Colors.transparent;
              }),
              innerRadius: const WidgetStatePropertyAll<double>(3),
              onChanged: (Locale? value) {
                if (value != null) {
                  setState(() {
                    currentSelectedLocale = value;
                  });
                  _updateSaveButtonState();
                }
              },
            ),
            const SizedBox(width: 8),
            Text(
              languageName,
              style: context.theme.typography.textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}