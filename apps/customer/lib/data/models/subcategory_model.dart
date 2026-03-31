import 'package:sellio_mobile/domain/entities/subcategory.dart';

class SubcategoryModel {
  final String id;
  final String name;
  final String? imageUrl;

  const SubcategoryModel({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['title']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? json['image_url']?.toString(),
    );
  }

  Subcategory toEntity() => Subcategory(
        id: id,
        name: name,
        imageUrl: imageUrl,
      );
}
