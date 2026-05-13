import 'package:equatable/equatable.dart';

class CategorySection extends Equatable {
  final String id;
  final String sectionTitle;
  final String categoryId;
  final List<SectionSubCategory> subCategories;
  final int sortOrder;
  final bool isActive;

  const CategorySection({
    required this.id,
    required this.sectionTitle,
    required this.categoryId,
    required this.subCategories,
    required this.sortOrder,
    required this.isActive,
  });

  @override
  List<Object?> get props =>
      [id, sectionTitle, categoryId, subCategories, sortOrder, isActive];
}

class SectionSubCategory extends Equatable {
  final String id;
  final String title;
  final String categoryId;
  final String categoryTitle;

  const SectionSubCategory({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.categoryTitle,
  });

  @override
  List<Object?> get props => [id, title, categoryId, categoryTitle];
}
