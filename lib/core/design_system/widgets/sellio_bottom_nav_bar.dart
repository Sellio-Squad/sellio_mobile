import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class SellioBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onCenterButtonTap;

  const SellioBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: context.theme.colors.surfaceLow,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Navigation Items
          Row(
            children: [
              _NavBarItem(
                iconPath: 'assets/icons/home.svg',
                selectedIconPath: 'assets/icons/home_selected.svg',
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavBarItem(
                iconPath: 'assets/icons/cart.svg',
                selectedIconPath: 'assets/icons/cart_selected.svg',
                label: 'Cart',
                isSelected: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              // Spacer for center button
              const Expanded(child: SizedBox()),
              _NavBarItem(
                iconPath: 'assets/icons/thrift.svg',
                selectedIconPath: 'assets/icons/thrift_selected.svg',
                label: 'Thrift',
                isSelected: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              _NavBarItem(
                iconPath: 'assets/icons/account.svg',
                selectedIconPath: 'assets/icons/account_selected.svg',
                label: 'Account',
                isSelected: currentIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
          // Center Floating Button with 12px space from bottom
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 35,
            bottom: 12, // 12px space from bottom as per Figma
            child: _CenterButton(
              onTap: onCenterButtonTap,
            ),
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
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          height: 58,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isSelected ? selectedIconPath : iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? context.theme.colors.primary
                      : context.theme.colors.hint,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: context.theme.typography.textTheme.labelXSmall.copyWith(
                  color: isSelected
                      ? context.theme.colors.primary
                      : context.theme.colors.hint,
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

  const _CenterButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.theme.colors.primary,
          border: Border.all(
            color: context.theme.colors.onPrimary,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: context.theme.colors.primary.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.theme.colors.primary,
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/magic_stick.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}