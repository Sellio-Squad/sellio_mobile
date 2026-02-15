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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CategoryImage(
            imageUrl: category?.imageUrl ?? '',
            isMore: isMore,
          ),
          const SizedBox(height: 8),
          Text(
            isMore ? 'More' : category!.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
