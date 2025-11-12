import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';


class AuthBackgroundWrapper extends StatelessWidget {
  final Widget child;
  final bool showLogo;
  final double topPadding;
  final double bottomPadding;
  final EdgeInsets containerPadding;

  const AuthBackgroundWrapper({
    super.key,
    required this.child,
    this.showLogo = true,
    this.topPadding = 80.0,
    this.bottomPadding = 40.0,
    this.containerPadding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: colors.authBackground,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                _buildTopBackground(context),
                _buildBottomSection(context, colors),
                if (showLogo) _buildTopLogo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildTopBackground(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        Assets.loginTopSection,
        width: double.infinity,
        height: 207,
        fit: BoxFit.fill,
      ),
    );
  }
  Widget _buildTopLogo(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(top: 70 ,bottom: bottomPadding),
        child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset(Assets.sellioWhite, width: 120),
        ),
      ),
    );
  }
  Widget _buildBottomSection(
      BuildContext context,
      dynamic colors,
      ) {
    const double topOverlap = 207 - 24;
    return Positioned(
      top: topOverlap,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        padding: containerPadding,
        decoration: BoxDecoration(
          color: colors.surfaceLow,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}