import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_images.dart';
import '../themes/sellio_theme_provider.dart';

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
                _buildCloseButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: 40,
      right: 16,
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.white, size: 28),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildTopBackground(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        AppImages.loginTopSection,
        width: double.infinity,
        height: 247,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildTopLogo(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(top: 70, bottom: bottomPadding),
        child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset(AppImages.sellioWhite, width: 120),
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, dynamic colors) {
    const double topOverlap = 247 - 24;
    return Positioned(
      top: topOverlap,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.surfaceLow,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(top: containerPadding.top),
            child: child,
          ),
        ),
      ),
    );
  }
}
