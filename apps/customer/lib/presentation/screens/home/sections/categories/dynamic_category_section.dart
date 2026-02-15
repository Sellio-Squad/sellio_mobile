import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../domain/entities/category_section.dart';

class DynamicCategorySection extends StatelessWidget {
  final CategorySection section;

  const DynamicCategorySection({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SectionHeader(
              title: section.sectionTitle,
              trailing: SvgPicture.asset(
                AppImages.arrowRight,
                width: 20,
                height: 20,
                matchTextDirection: true,
              ),
              onTap: () {},
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.3,
            ),
            itemCount: section.subCategories.length,
            itemBuilder: (context, index) {
              final subCategory = section.subCategories[index];
              return _SubCategoryItem(
                name: subCategory.title,
                image: AppImages.placeholder,
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SubCategoryItem extends StatelessWidget {
  final String name;
  final String image;

  const _SubCategoryItem({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: textTheme.labelSmall.copyWith(
            color: colors.title,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
