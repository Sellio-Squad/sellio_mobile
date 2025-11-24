import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_bottom_sheet.dart';

import '../../../../core/design_system/widgets/buttons/sellio_button.dart';
import '../../../../core/localization/l10n/localization_service.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  final String selectedLanguage;
  final Function(String) onSave;

  const ChangeLanguageBottomSheet({
    super.key,
    required this.onSave,
    required this.selectedLanguage,
  });

  @override
  State<ChangeLanguageBottomSheet> createState() =>
      _ChangeLanguageBottomSheetState();

  static Future<void> show(
      {required BuildContext context,
      required ValueChanged<String> onSave,
      required String selectedLanguage}) {
    return SellioBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: ChangeLanguageBottomSheet(
        onSave: onSave,
        selectedLanguage: selectedLanguage,
      ),
    );
  }
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  late String currentSelectedLanguage;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    currentSelectedLanguage = widget.selectedLanguage;
    _updateSaveButtonState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.local.change_language,
          style: context.theme.typography.textTheme.titleMedium,
        ),
        const SizedBox(height: 24),
        RadioGroup<String>(
          groupValue: currentSelectedLanguage,
          onChanged: (String? value) {
            if (value != null) {
              setState(() {
                currentSelectedLanguage = value;
              });
              _updateSaveButtonState();
            }
          },
          child: Row(
            children: [
              Expanded(
                child: _buildLanguageOption(
                  language: context.local.english,
                  context: context,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildLanguageOption(
                  language: context.local.arabic,
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
                ? () {
                    widget.onSave(currentSelectedLanguage);
                  }
                : null,
            isEnabled: _isFormValid,
            verticalPadding: 13,
          ),
        ),
      ],
    );
  }

  void _updateSaveButtonState() {
    final isValid = currentSelectedLanguage != widget.selectedLanguage;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  Widget _buildLanguageOption({
    required String language,
    required BuildContext context,
  }) {
    final isSelected = currentSelectedLanguage == language;

    return InkWell(
      onTap: () {
        setState(() {
          currentSelectedLanguage = language;
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
            Radio<String>(
              value: language,
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
            ),
            const SizedBox(width: 8),
            Text(
              language,
              style: context.theme.typography.textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
