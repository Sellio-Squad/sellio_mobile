import 'package:design_system/themes/sellio_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellioBottomNavItem {
  const SellioBottomNavItem({
    required this.iconPath,
    required this.label,
    required this.index,
    this.selectedIconPath,
  });

  final String iconPath;
  final String? selectedIconPath;
  final String label;
  final int index;
}

class SellioBottomNavCenterButton {
  const SellioBottomNavCenterButton({
    required this.index,
    required this.iconPath,
    this.onTap,
  });

  final int index;
  final String iconPath;
  final VoidCallback? onTap;
}

class SellioBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<SellioBottomNavItem> items;
  final SellioBottomNavCenterButton? centerButton;

  const SellioBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.centerButton,
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
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _NavigationItems(
            currentIndex: currentIndex,
            onTap: onTap,
            items: items,
            centerButtonIndex: centerButton?.index,
            bottomPadding: bottomPadding,
          ),
          if (centerButton != null)
            _CenterButton(
              iconPath: centerButton!.iconPath,
              onTap: centerButton!.onTap ?? () => onTap(centerButton!.index),
              bottomPadding: bottomPadding,
            ),
        ],
      ),
    );
  }
}

class _NavigationItems extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<SellioBottomNavItem> items;
  final int? centerButtonIndex;
  final double bottomPadding;

  const _NavigationItems({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.centerButtonIndex,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    final sortedItems = [...items]..sort((a, b) => a.index.compareTo(b.index));
    final leadingItems = centerButtonIndex == null
        ? sortedItems
        : sortedItems.where((item) => item.index < centerButtonIndex!).toList();
    final trailingItems = centerButtonIndex == null
        ? <SellioBottomNavItem>[]
        : sortedItems.where((item) => item.index > centerButtonIndex!).toList();

    return Positioned(
      left: 12,
      right: 12,
      bottom: bottomPadding,
      height: 58,
      child: Row(
        children: [
          for (final item in leadingItems)
            _NavBarItem(
              iconPath: item.iconPath,
              selectedIconPath: item.selectedIconPath,
              label: item.label,
              isSelected: currentIndex == item.index,
              onTap: () => onTap(item.index),
            ),
          if (centerButtonIndex != null) const Expanded(child: SizedBox()),
          for (final item in trailingItems)
            _NavBarItem(
              iconPath: item.iconPath,
              selectedIconPath: item.selectedIconPath,
              label: item.label,
              isSelected: currentIndex == item.index,
              onTap: () => onTap(item.index),
            ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String iconPath;
  final String? selectedIconPath;
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
    final color =
        isSelected ? context.theme.colors.primary : context.theme.colors.body;
    final resolvedSelectedIconPath = selectedIconPath ?? iconPath;
    final useColorFilter = selectedIconPath == null;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: SvgPicture.asset(
                  isSelected ? resolvedSelectedIconPath : iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: useColorFilter
                      ? ColorFilter.mode(color, BlendMode.srcIn)
                      : null,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                style: context.theme.typography.textTheme.labelXSmall.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterButton extends StatefulWidget {
  final String iconPath;
  final VoidCallback onTap;
  final double bottomPadding;

  const _CenterButton({
    required this.iconPath,
    required this.onTap,
    required this.bottomPadding,
  });

  @override
  State<_CenterButton> createState() => _CenterButtonState();
}

class _CenterButtonState extends State<_CenterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width / 2 - 35,
      bottom: 12 + widget.bottomPadding,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.colors.primary,
                  border: Border.all(
                    color: context.theme.colors.surfaceLow,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(0, -4),
                      blurRadius: 12,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(0, -4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    widget.iconPath,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      context.theme.colors.onPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
