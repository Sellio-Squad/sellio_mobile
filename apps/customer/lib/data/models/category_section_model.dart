import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/category_section.dart';

part 'category_section_model.freezed.dart';
part 'category_section_model.g.dart';

@freezed
class CategorySectionModel with _$CategorySectionModel {
  const factory CategorySectionModel({
    required String id,
    required String sectionTitle,
    required String categoryId,
    required List<SectionSubCategoryModel> subCategories,
    required int sortOrder,
    required bool isActive,
  }) = _CategorySectionModel;

  factory CategorySectionModel.fromJson(Map<String, dynamic> json) =>
      _$CategorySectionModelFromJson(json);

  const CategorySectionModel._();

  CategorySection toEntity() => CategorySection(
        id: id,
        sectionTitle: sectionTitle,
        categoryId: categoryId,
        subCategories: subCategories.map((e) => e.toEntity()).toList(),
        sortOrder: sortOrder,
        isActive: isActive,
      );
}

@freezed
class SectionSubCategoryModel with _$SectionSubCategoryModel {
  const factory SectionSubCategoryModel({
    required String id,
    required String title,
    required String categoryId,
    required String categoryTitle,
  }) = _SectionSubCategoryModel;

  factory SectionSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SectionSubCategoryModelFromJson(json);

  const SectionSubCategoryModel._();

  SectionSubCategory toEntity() => SectionSubCategory(
        id: id,
        title: title,
        categoryId: categoryId,
        categoryTitle: categoryTitle,
      );
}
