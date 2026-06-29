import 'package:core/core.dart';
import '../../core/api/api_endpoints.dart';
import '../../models/category_section_model.dart';

abstract class CategorySectionRemoteDataSource {
  Future<List<CategorySectionModel>> getActiveSections();
}

class CategorySectionRemoteDataSourceImpl
    implements CategorySectionRemoteDataSource {
  final ApiClient _httpClient;

  CategorySectionRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<CategorySectionModel>> getActiveSections() async {
    final response = await _httpClient.get(ApiEndpoints.categorySectionsActive);
    final data = response.data as List;
    return data.map((json) => CategorySectionModel.fromJson(json)).toList();
  }
}
