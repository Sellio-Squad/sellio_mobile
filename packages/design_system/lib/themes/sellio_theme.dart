import 'package:flutter/material.dart';
import 'sellio_colors.dart';
import 'sellio_typography.dart';

class SellioTheme extends InheritedWidget {
  final Brightness brightness;
  final SellioColorScheme colors;
  final SellioTypography typography;

  const SellioTheme({
    super.key,
    required this.brightness,
    required this.colors,
    required this.typography,
    required super.child,
  });

  static SellioTheme of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<SellioTheme>();
    assert(result != null, 'No AppTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SellioTheme oldWidget) {
    return brightness != oldWidget.brightness ||
        colors != oldWidget.colors ||
        typography != oldWidget.typography;
  }
}
