import 'package:sellio_mobile/domain/entities/category.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/model/Catgeory_model.dart';

extension CategoryMapper on Category {
  HomeCategoryModel toHomeModel() {
    return HomeCategoryModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }
}

extension CategoryListMapper on List<Category> {
  List<HomeCategoryModel> toCategoryModel() {
    return map((category) => category.toHomeModel()).toList();
  }
}
