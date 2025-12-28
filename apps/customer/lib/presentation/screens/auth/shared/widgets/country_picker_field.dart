import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:country_picker/country_picker.dart';


class CountryPickerField extends StatelessWidget {
  final Country? selectedCountry;
  final ValueChanged<Country> onCountrySelected;
  final String hintText;

  const CountryPickerField({
    super.key,
    this.selectedCountry,
    required this.onCountrySelected,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return GestureDetector(
      onTap: () => _showCountryPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.stroke, width: 0.5),
        ),
        child: Row(
          children: [
            if (selectedCountry != null) ...[
              Text(
                selectedCountry!.flagEmoji,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Text(
                '+${selectedCountry!.phoneCode}',
                style: textTheme.bodyMedium.copyWith(color: colors.title),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                selectedCountry?.name ?? hintText,
                style: textTheme.bodyMedium.copyWith(
                  color: selectedCountry != null ? colors.title : colors.hint,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: colors.body),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: onCountrySelected,
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        inputDecoration: InputDecoration(
          hintText: 'Search country',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}