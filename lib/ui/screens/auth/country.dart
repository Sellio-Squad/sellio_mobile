import '../../../core/design_system/constants/assets.dart';

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
    flagAsset: Assets.flagIraq,
  ),
  Country(
    name: 'Egypt',
    code: '+20',
    flagAsset: Assets.flagIraq,
  ),
];
