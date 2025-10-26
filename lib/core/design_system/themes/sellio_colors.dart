import 'package:flutter/material.dart';

class SellioColors {
  SellioColors._();

  static const light = SellioColorScheme(
    primary: Color(0xFF520826),
    primaryVariant: Color(0xFFFEF5F9),
    secondary: Color(0xFFF5A623),
    secondaryVariant: Color(0xFFFEF3E1),
    surfaceLow: Color(0xFFFFFFFF),
    surface: Color(0xFFF8F8F8),
    surfaceHigh: Color(0xFFE6E6E6),
    title: Color(0xDE1F1F1F),
    body: Color(0xa81f1f1f),
    hint: Color(0x611F1F1F),
    stroke: Color(0x1F1F1F1F),
    onPrimary: Color(0xDEFFFFFF),
    disabled: Color(0xFFE8EBED),
    red: Color(0xFFE54F40),
    errorVariant: Color(0xFFFEEDEC),
    green: Color(0xFF0D6620),
    greenVariant: Color(0xFFE0F5E5),
    loadingDarkColors: [
      Color(0x1F520826),
      Color(0x80520826),
      Color(0xFF520826),
    ],
    loadingLightColors: [
      Color(0x1FFFFFFF),
      Color(0x80FFFFFF),
      Color(0xDEFFFFFF),
    ],
  );

  static const dark = SellioColorScheme(
    primary: Color(0xFF520826),
    primaryVariant: Color(0xFFFEF5F9),
    secondary: Color(0xFFF5A623),
    secondaryVariant: Color(0xFFFEF3E1),
    surfaceLow: Color(0xFFFFFFFF),
    surface: Color(0xFFF8F8F8),
    surfaceHigh: Color(0xFFE6E6E6),
    title: Color(0xDE1F1F1F),
    body: Color(0xa81f1f1f),
    hint: Color(0x611F1F1F),
    stroke: Color(0x1F1F1F1F),
    onPrimary: Color(0xDEFFFFFF),
    disabled: Color(0xFFE8EBED),
    red: Color(0xFFE54F40),
    errorVariant: Color(0xFFFEEDEC),
    green: Color(0xFF0D6620),
    greenVariant: Color(0xFFE0F5E5),
    loadingDarkColors: [
      Color(0x1F520826),
      Color(0x80520826),
      Color(0xFF520826),
    ],
    loadingLightColors: [
      Color(0x1FFFFFFF),
      Color(0x80FFFFFF),
      Color(0xDEFFFFFF),
    ],
  );
}

class SellioColorScheme {
  final Color primary;
  final Color primaryVariant;
  final Color secondary;
  final Color secondaryVariant;
  final Color surfaceLow;
  final Color surface;
  final Color surfaceHigh;
  final Color title;
  final Color body;
  final Color hint;
  final Color stroke;
  final Color onPrimary;
  final Color disabled;
  final Color red;
  final Color errorVariant;
  final Color green;
  final Color greenVariant;
  final List<Color> loadingDarkColors;
  final List<Color> loadingLightColors;

  const SellioColorScheme({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.secondaryVariant,
    required this.surfaceLow,
    required this.surface,
    required this.surfaceHigh,
    required this.title,
    required this.body,
    required this.hint,
    required this.stroke,
    required this.onPrimary,
    required this.disabled,
    required this.red,
    required this.errorVariant,
    required this.green,
    required this.greenVariant,
    required this.loadingDarkColors,
    required this.loadingLightColors,
  });
}
