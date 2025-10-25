import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../constants/app_icons.dart';
import '../constants/app_strings.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onCenterButtonTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 58 + bottomPadding,
      decoration: BoxDecoration(
        color: context.theme.colors.surfaceLow,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.04),
            offset: const Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 12,
            right: 12,
            bottom: bottomPadding,
            height: 58,
            child: Row(
              children: [
                _NavBarItem(
                  iconPath: AppIcons.home,
                  selectedIconPath: AppIcons.homeSelected,
                  label: AppStrings.home,
                  isSelected: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
                _NavBarItem(
                  iconPath: AppIcons.cart,
                  selectedIconPath: AppIcons.cartSelected,
                  label: AppStrings.cart,
                  isSelected: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
                const Expanded(child: SizedBox()),
                _NavBarItem(
                  iconPath: AppIcons.thrift,
                  selectedIconPath: AppIcons.thriftSelected,
                  label: AppStrings.thrift,
                  isSelected: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
                _NavBarItem(
                  iconPath: AppIcons.account,
                  selectedIconPath: AppIcons.accountSelected,
                  label: AppStrings.account,
                  isSelected: currentIndex == 3,
                  onTap: () => onTap(3),
                ),
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 35,
            bottom: 12 + bottomPadding,
            child: _CenterButton(onTap: onCenterButtonTap),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String iconPath;
  final String selectedIconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.iconPath,
    required this.selectedIconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? context.theme.colors.primary
        : context
              .theme
              .colors
              .title; // todo: body color not in the design system

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: SizedBox(
          height: 42,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isSelected ? selectedIconPath : iconPath,
                width: 24,
                height: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: context.theme.typography.textTheme.labelXSmall.copyWith(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CenterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 67.2,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.theme.colors.primary,
          border: Border.all(color: context.theme.colors.surfaceLow, width: 4),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.04),
              offset: const Offset(0, -4),
              blurRadius: 12,
            ),
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.04),
              offset: const Offset(0, -4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(AppIcons.magicStick, width: 24, height: 24),
        ),
      ),
    );
  }
}
