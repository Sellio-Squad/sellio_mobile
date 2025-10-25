import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class SellioBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<NavBarItemData>? items;

  const SellioBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items,
  });

  List<NavBarItemData> get _defaultItems => [
    NavBarItemData(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
    ),
    NavBarItemData(
      icon: Icons.search_outlined,
      selectedIcon: Icons.search,
      label: 'Search',
    ),
    NavBarItemData(
      icon: Icons.favorite_border,
      selectedIcon: Icons.favorite,
      label: 'Favorites',
    ),
    NavBarItemData(
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navItems = items ?? _defaultItems;

    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.surfaceLow,
        border: Border(
          top: BorderSide(
            color: context.theme.colors.stroke,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              navItems.length,
                  (index) => _NavBarItem(
                icon: navItems[index].icon,
                selectedIcon: navItems[index].selectedIcon,
                label: navItems[index].label,
                isSelected: currentIndex == index,
                onTap: () => onTap(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavBarItemData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  NavBarItemData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected
                  ? context.theme.colors.primary
                  : context.theme.colors.hint,
              size: 24,
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
    );
  }
}