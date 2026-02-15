import 'package:sellio_mobile/domain/entities/category.dart';

class HomeCategoryModel {
  final String id;
  final String name;
  final String imageUrl;

  const HomeCategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory HomeCategoryModel.fromEntity(Category category) {
    return HomeCategoryModel(
      id: category.id,
      name: category.name,
      imageUrl: category.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeCategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
