import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_colors.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_typography.dart';
import 'package:sellio_mobile/core/design_system/widgets/textField.dart';
import 'package:sellio_mobile/ui/screens/auth/component/countryDropdown.dart';
import 'package:sellio_mobile/ui/screens/auth/country.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';

class Phonefield extends StatelessWidget {
  final TextEditingController? phoneController;
  final Country selectedCountry;
  final List<Country> countries;
  final ValueChanged<Country> onChanged;
  final SellioTextTheme textTheme;
  final SellioColorScheme colors;
  final String? flag;

  const Phonefield({super.key,
    required this.phoneController,
    required this.selectedCountry,
    required this.countries,
    required this.onChanged,
    required this.textTheme,
    required this.colors,
    required this.flag,});

  @override
  Widget build(BuildContext context) {
    return SellioTextField(
      controller: phoneController,
      hintText: AppStrings.phoneNumber,
      inputType: TextInputType.phone,
      inputFormatter: [
        FilteringTextInputFormatter.allow(RegExp(r'[+\d]')),
        LengthLimitingTextInputFormatter(11),
      ],
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 16, right: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.phone, width: 24, height: 24),

            const Gap(8),

            CountryDropdown(
              selectedCountry: selectedCountry,
              countries: countries,
              onChanged: onChanged,
              textTheme: textTheme,
              colors: colors,
              flag: flag,
            ),

            const Gap(8),

            Container(width: 1, height: 24, color: colors.stroke),
          ],
        ),
      ),
    );
  }
}