import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryPickerField extends StatelessWidget {
  final Country? selectedCountry;
  final ValueChanged<Country> onCountrySelected;
  final String hintText;
  final String searchHintText;
  final List<String> favoriteCountries;

  const CountryPickerField({
    super.key,
    this.selectedCountry,
    required this.onCountrySelected,
    required this.hintText,
    this.searchHintText = 'Search by name or code',
    this.favoriteCountries = const ['IQ', 'EG', 'PS', 'SY'],
  });

  void _showCountryPicker(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: onCountrySelected,
      favorite: favoriteCountries,
      countryListTheme: CountryListThemeData(
        flagSize: 20,
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.8,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        inputDecoration: InputDecoration(
          hintText: searchHintText,
          focusColor: colors.primary,
          hintStyle: textTheme.labelMedium.copyWith(color: colors.body),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppImages.search, width: 16, height: 16),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;
    final country = selectedCountry;

    return GestureDetector(
      onTap: () => _showCountryPicker(context),
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          start: 16,
          end: 12,
          top: 4,
          bottom: 4,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.stroke, width: 0.5),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppImages.locationPin,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
            ),
            const Gap(8),
            CountryFlag.fromCountryCode(
              country?.countryCode ?? 'IQ',
              theme: const ImageTheme(
                shape: Circle(),
                width: 20,
                height: 20,
              ),
            ),
            const Gap(8),
            Expanded(
              child: Text(
                country?.name ?? hintText,
                style: textTheme.bodyMedium.copyWith(
                  color: country != null ? colors.title : colors.body,
                ),
              ),
            ),
            const Gap(4),
            SvgPicture.asset(AppImages.arrowDown, width: 20, height: 20),
          ],
        ),
      ),
    );
  }
}