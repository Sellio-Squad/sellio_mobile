
import 'package:design_system/design_system.dart';

class Country {
  final String name;
  final String code;
  final String flagAsset;

  Country({
    required this.name,
    required this.code,
    required this.flagAsset,
  });
}

final List<Country> mockCountries = [
  Country(
    name: 'Iraq',
    code: '+964',
    flagAsset: AppImages.flagIraq,
  ),
  Country(
    name: 'Egypt',
    code: '+20',
    flagAsset: AppImages.flagEgypt,
  ),
];
