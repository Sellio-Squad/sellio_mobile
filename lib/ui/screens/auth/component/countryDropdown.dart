import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_colors.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_typography.dart';
import 'package:sellio_mobile/ui/screens/auth/country.dart';
import '../../../../core/design_system/constants/assets.dart';

class CountryDropdown extends StatelessWidget {
  final Country selectedCountry;
  final List<Country> countries;
  final ValueChanged<Country> onChanged;
  final SellioTextTheme textTheme;
  final SellioColorScheme colors;
  final String? flag;

  const CountryDropdown({
    super.key,
    required this.selectedCountry,
    required this.countries,
    required this.onChanged,
    required this.textTheme,
    required this.colors,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Country>(
        value: selectedCountry,
        isDense: true,
        icon: const SizedBox.shrink(),
        onChanged: (Country? newValue) {
          if (newValue != null) onChanged(newValue);
        },
        selectedItemBuilder: (context) {
          return countries.map((country) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Assets.arrowDown, width: 16, height: 16),
                const Gap(8),
                SvgPicture.asset(country.flagAsset, width: 24, height: 24),
                const Gap(8),
                Text(
                  country.code,
                  style: textTheme.bodyMedium.copyWith(color: colors.body),
                ),
              ],
            );
          }).toList();
        },
        items: countries.map((country) {
          return DropdownMenuItem<Country>(
            value: country,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(country.flagAsset, width: 24, height: 24),
                const Gap(8),
                Text(
                  country.code,
                  style: textTheme.bodyMedium.copyWith(color: colors.body),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}