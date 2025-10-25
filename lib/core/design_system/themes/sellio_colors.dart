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
      body: Color(0xA801F1F1),
      hint: Color(0x611F1F1F),
      stroke: Color(0x1F1F1F1F),
      onPrimary: Color(0xDEFFFFFF),
      disabled: Color(0xFFE8EBED),
      red: Color(0xFFE54F40),
      errorVariant: Color(0xFFFEEDEC),
      green: Color(0xFF0D6620),
      greenVariant: Color(0xFFE0F5E5)
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
      body: Color(0xA801F1F1),
      hint: Color(0x611F1F1F),
      stroke: Color(0x1F1F1F1F),
      onPrimary: Color(0xDEFFFFFF),
      disabled: Color(0xFFE8EBED),
      red: Color(0xFFE54F40),
      errorVariant: Color(0xFFFEEDEC),
      green: Color(0xFF0D6620),
      greenVariant: Color(0xFFE0F5E5)
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
  });
}