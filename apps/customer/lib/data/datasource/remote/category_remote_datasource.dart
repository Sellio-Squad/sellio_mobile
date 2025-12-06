import '../../core/api/api_endpoints.dart';
import '../../core/api/api_client.dart';
import '../../models/category_model.dart';

CategoryModel _categoryModelFromJsonWithFallback(Map<String, dynamic> json) {
  final nameValue = json['name'] ??
                   json['categoryName'] ??
                   json['category_name'] ??
                   json['title'] ??
                   json['label'] ??
                   '';

  return CategoryModel(
    id: json['id']?.toString() ?? '',
    name: nameValue?.toString() ?? '',
  );
}

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> getCategoryById(String categoryId);
  Future<List<CategoryModel>> getStoreCategories(String storeId);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiClient _httpClient;

  CategoryRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _httpClient.get(ApiEndpoints.categoriesAll);
    final categories = (response.data as List)
        .map((json) {
          try {
            final category = CategoryModel.fromJson(json);
            if (category.name.isEmpty) {
              return _categoryModelFromJsonWithFallback(json);
            }
            return category;
          } catch (e) {
            return _categoryModelFromJsonWithFallback(json);
          }
        })
        .toList();
    return categories;
  }

  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    final response = await _httpClient.get(ApiEndpoints.categoryById(categoryId));
    return CategoryModel.fromJson(response.data);
  }

  @override
  Future<List<CategoryModel>> getStoreCategories(String storeId) async {
    final response = await _httpClient.get(ApiEndpoints.subCategoriesByStore(storeId));
    final categories = (response.data as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
    return categories;
  }
}
