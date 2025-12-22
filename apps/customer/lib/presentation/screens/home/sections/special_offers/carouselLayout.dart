import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

enum CarouselLayout {
  tabletLandscape(
    height: 250.0,
    viewportFraction: 0.45,
    enlargeCenterPage: true,
    strategy: CenterPageEnlargeStrategy.zoom,
  ),
  tabletPortrait(
    height: 300.0,
    viewportFraction: 0.85,
    enlargeCenterPage: true,
    strategy: CenterPageEnlargeStrategy.zoom,
  ),
  mobileLandscape(
    height: 115.0,
    viewportFraction: 0.3,
    enlargeCenterPage: false,
    strategy: CenterPageEnlargeStrategy.scale,
  ),
  mobilePortrait(
    height: 200.0,
    viewportFraction: 0.95,
    enlargeCenterPage: true,
    strategy: CenterPageEnlargeStrategy.zoom,
  ),
  smallMobile(
    height: 80.0,
    viewportFraction: 0.8,
    enlargeCenterPage: false,
    strategy: CenterPageEnlargeStrategy.height,
  );

  final double height;
  final double viewportFraction;
  final bool enlargeCenterPage;
  final CenterPageEnlargeStrategy strategy;

  const CarouselLayout({
    required this.height,
    required this.viewportFraction,
    required this.enlargeCenterPage,
    required this.strategy,
  });

  static CarouselLayout of(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final isTablet = size.shortestSide >= 600;
    final isSmallPhone = size.width < 350;

    if (isTablet) {
      return isLandscape ? tabletLandscape : tabletPortrait;
    } else {
      return isLandscape
          ? mobileLandscape
          : isSmallPhone
              ? smallMobile
              : mobilePortrait;
    }
  }
}
