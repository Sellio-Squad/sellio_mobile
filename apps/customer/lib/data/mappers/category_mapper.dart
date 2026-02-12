import '../../domain/entities/category.dart';
import '../models/category_model.dart';

extension CategoryModelMapper on CategoryModel {
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }
}
