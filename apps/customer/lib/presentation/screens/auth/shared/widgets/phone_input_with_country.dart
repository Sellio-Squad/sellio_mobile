import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_intl_phone_field/countries.dart' as intl_countries;
import 'package:flutter_svg/svg.dart';
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
    int displayMaxLength = 10;
    int? fieldMaxLength = 10;

    if (selectedCountry != null) {
      final countryPhoneNumberLength = intl_countries.countries
          .firstWhere((c) => c.code == selectedCountry!.countryCode);
      displayMaxLength = countryPhoneNumberLength.maxLength;
      fieldMaxLength = countryPhoneNumberLength.maxLength;
    } else {
      try {
        final iraqPhoneNumberLength =
            intl_countries.countries.firstWhere((c) => c.code == "IQ");
        displayMaxLength = iraqPhoneNumberLength.maxLength;
        fieldMaxLength = iraqPhoneNumberLength.maxLength;
      } catch (_) {
        displayMaxLength = 10;
        fieldMaxLength = 10;
      }
    }
    bool isError = controller.text.length > displayMaxLength;
    bool isSuccess = controller.text.isNotEmpty &&
        controller.text.length == displayMaxLength;
    bool isFocused = focusNode?.hasFocus ?? false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      color: colors.primary.withValues(alpha: 0.12),
                    )
                  ]
                : [],
            border: Border.all(
              color: isFocused ? colors.primary : colors.stroke,
              width: isFocused ? 1.0 : 0.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: SvgPicture.asset(
                  AppImages.phone,
                  width: 24,
                  height: 24,
                ),
              ),
              _buildCountrySelector(context, colors, textTheme),
              Expanded(
                child: _buildPhoneTextField(
                  context,
                  colors,
                  textTheme,
                  fieldMaxLength,
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 6, right: 4),
            child: Text(
              '${controller.text.length}/$displayMaxLength',
              style: textTheme.labelSmall.copyWith(
                color: isError
                    ? colors.red
                    : isSuccess
                        ? colors.green
                        : colors.body,
                fontWeight: (isError || isSuccess)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            )),
      ],
    );
  }

  Widget _buildCountrySelector(
    BuildContext context,
    dynamic colors,
    SellioTextTheme textTheme,
  ) {
    return GestureDetector(
      onTap: () => _showCountryPicker(context, colors, textTheme),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppImages.arrowDown,
              width: 20,
              height: 20,
            ),
            Gap(4),
            CountryFlag.fromCountryCode(
              selectedCountry?.countryCode ?? "IQ",
              theme: const ImageTheme(
                shape: Circle(),
                width: 20,
                height: 20,
              ),
            ),
            Gap(4),
            Text(
              ' +${selectedCountry?.phoneCode ?? '964'}',
              style: textTheme.bodyMedium.copyWith(color: colors.title),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneTextField(BuildContext context, SellioColorScheme colors,
      SellioTextTheme textTheme, int? maxLength) {
    return GestureDetector(
      onTap: () {},
      child: TextField(
        cursorColor: colors.primary,
        cursorHeight: 20,
        controller: controller,
        focusNode: focusNode,
        style: textTheme.bodyMedium.copyWith(
          color: colors.title,
        ),
        enabled: true,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
        ],
        decoration: InputDecoration(
          hintText: context.local.phone_number,
          hintStyle: textTheme.labelMedium.copyWith(color: colors.body),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }

  void _showCountryPicker(
    BuildContext context,
    SellioColorScheme colors,
    SellioTextTheme textTheme,
  ) {
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
        flagSize: 20,
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.8,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        inputDecoration: InputDecoration(
          hintText: context.local.search_by_name_or_code,
          focusColor: colors.primary,
          hintStyle: textTheme.labelMedium.copyWith(color: colors.body),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              AppImages.search,
              width: 16,
              height: 16,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
