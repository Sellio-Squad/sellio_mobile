import 'package:flutter/widgets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_colors.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_typography.dart';


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
