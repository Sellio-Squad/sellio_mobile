import 'package:country_picker/country_picker.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

class PhoneInputWithCountry extends StatelessWidget {
  final TextEditingController controller;
  final Country? selectedCountry;
  final ValueChanged<Country> onCountrySelected;
  final FocusNode? focusNode;

  const PhoneInputWithCountry({
    super.key,
    required this.controller,
    this.selectedCountry,
    required this.onCountrySelected,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.stroke, width: 0.5),
      ),
      child: Row(
        children: [
          _buildCountrySelector(context, colors, textTheme),
          Container(
            width: 1,
            height: 24,
            color: colors.stroke,
          ),
          Expanded(
            child: _buildPhoneTextField(context, colors),
          ),
        ],
      ),
    );
  }

  Widget _buildCountrySelector(
    BuildContext context,
    dynamic colors,
    SellioTextTheme textTheme,
  ) {
    return GestureDetector(
      onTap: () => _showCountryPicker(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedCountry != null) ...[
              Text(
                selectedCountry!.flagEmoji,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 4),
              Text(
                '+${selectedCountry!.phoneCode}',
                style: textTheme.bodyMedium.copyWith(color: colors.title),
              ),
            ] else
              Text(
                'Select',
                style: textTheme.bodyMedium.copyWith(color: colors.hint),
              ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, color: colors.body, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneTextField(BuildContext context, dynamic colors) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      decoration: InputDecoration(
        hintText: context.local.phone_number,
        hintStyle: TextStyle(color: colors.hint),
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: onCountrySelected,
      favorite: [
        'IQ',
        'EG',
        'PS',
        'SY',
      ],
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        inputDecoration: InputDecoration(
          hintText: context.local.search,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
