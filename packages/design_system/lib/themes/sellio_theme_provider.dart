import 'package:flutter/widgets.dart';

import 'sellio_colors.dart';
import 'sellio_theme.dart';
import 'sellio_typography.dart';


class SellioThemeProvider extends StatelessWidget {
  final Brightness brightness;
  final Widget child;

  const SellioThemeProvider({
    super.key,
    required this.brightness,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors =
    brightness == Brightness.dark ? SellioColors.dark : SellioColors.light;

    final typography = SellioTypography();

    return SellioTheme(
      brightness: brightness,
      colors: colors,
      typography: typography,
      child: child,
    );
  }
}

extension SellioThemeExtension on BuildContext {
  SellioTheme get theme => SellioTheme.of(this);
}
