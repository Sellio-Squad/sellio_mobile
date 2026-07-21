import 'package:core/core.dart';
import '../../core/api/api_endpoints.dart';
import '../../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiClient _httpClient;

  CategoryRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _httpClient.get(ApiEndpoints.categoriesAll);
    return (response.data as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
  }
}
