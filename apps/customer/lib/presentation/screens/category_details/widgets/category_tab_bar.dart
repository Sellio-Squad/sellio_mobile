import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/domain/entities/subcategory.dart';

class CategoryTabBar extends StatefulWidget {
  final List<Subcategory> subcategories;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const CategoryTabBar({
    super.key,
    required this.subcategories,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabCount = 1 + widget.subcategories.length;

    return SizedBox(
      height: 80,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabCount,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == widget.selectedIndex;

          if (index == 0) {
            return _CircularTab(
              isSelected: isSelected,
              onTap: () => widget.onTabSelected(0),
              label: 'All',
              icon: SvgPicture.asset(
                AppImages.allCategories,
                width: 26,
                height: 26,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? Colors.white
                      : SellioTheme.of(context).colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            );
          }

          final subcategory = widget.subcategories[index - 1];
          return _CircularTab(
            isSelected: isSelected,
            onTap: () => widget.onTabSelected(index),
            label: subcategory.name,
            icon:
                subcategory.imageUrl != null && subcategory.imageUrl!.isNotEmpty
                    ? ClipOval(
                        child: Image.network(
                          subcategory.imageUrl!,
                          width: 26,
                          height: 26,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.category_outlined,
                            size: 22,
                            color: isSelected
                                ? Colors.white
                                : SellioTheme.of(context).colors.primary,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.category_outlined,
                        size: 22,
                        color: isSelected
                            ? Colors.white
                            : SellioTheme.of(context).colors.primary,
                      ),
          );
        },
      ),
    );
  }
}

class _CircularTab extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final Widget icon;

  const _CircularTab({
    required this.isSelected,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = SellioTheme.of(context).colors;
    final textTheme = context.theme.typography.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isSelected ? colors.primary : colors.surfaceLow,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? colors.primary : colors.stroke,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: colors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Center(child: icon),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall.copyWith(
                color: isSelected ? colors.primary : colors.title,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 11.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
