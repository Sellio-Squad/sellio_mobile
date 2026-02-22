import 'package:design_system/themes/sellio_theme.dart';
import 'package:design_system/themes/sellio_theme_provider.dart';
import 'package:design_system/themes/sellio_typography.dart';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/category_image.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/model/Catgeory_model.dart';

class CategoryItem extends StatelessWidget {
  final HomeCategoryModel? category;
  final VoidCallback onTap;
  final bool isMore;

  const CategoryItem({
    super.key,
    required this.category,
    required this.onTap,
  }) : isMore = false;

  const CategoryItem.more({
    super.key,
    required this.onTap,
  })  : isMore = true,
        category = null;

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final SellioTextTheme themeText = context.theme.typography.textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CategoryImage(
              imageUrl: category?.imageUrl ?? '',
              isMore: isMore,
            ),
            const SizedBox(height: 6),
            Text(
              isMore ? 'More' : category!.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: themeText.labelSmall.copyWith(color: colors.body),
            ),
          ],
        ),
      ),
    );
  }
}
