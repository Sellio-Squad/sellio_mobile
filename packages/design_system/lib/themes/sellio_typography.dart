import 'package:flutter/material.dart';

class SellioTypography {
  final SellioTextTheme textTheme;

  SellioTypography({Brightness brightness = Brightness.light})
    : textTheme = SellioTextTheme(brightness);
}

class SellioTextTheme {
  static const _fontFamily = 'Rubik';

  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;
  final TextStyle labelXSmall;

  SellioTextTheme(Brightness brightness)
    : headlineLarge = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 28,
        height: 42 / 28,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        height: 36 / 24,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        height: 30 / 20,
        fontWeight: FontWeight.w600,
      ),
      titleLarge = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        height: 30 / 20,
        fontWeight: FontWeight.w500,
      ),
      titleMedium = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        height: 28 / 18,
        fontWeight: FontWeight.w500,
      ),
      titleSmall = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        height: 28 / 18,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
      ),
      bodySmall = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        height: 22 / 14,
        fontWeight: FontWeight.w400,
      ),
      labelLarge = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w500,
      ),
      labelMedium = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        height: 22 / 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        height: 18 / 12,
        fontWeight: FontWeight.w500,
      ),
      labelXSmall = const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 10,
        height: 14 / 10,
        fontWeight: FontWeight.w400,
      );
}
