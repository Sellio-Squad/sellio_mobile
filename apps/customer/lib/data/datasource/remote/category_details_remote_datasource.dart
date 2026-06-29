import 'package:core/core.dart';
import 'package:sellio_mobile/data/core/api/api_endpoints.dart';
import 'package:sellio_mobile/data/models/common/paginated_response.dart';
import 'package:sellio_mobile/data/models/product_model.dart';
import 'package:sellio_mobile/data/models/subcategory_model.dart';

abstract class CategoryDetailsRemoteDataSource {
  Future<List<SubcategoryModel>> getSubcategories(String categoryId);

  Future<PaginatedResponse<ProductModel>> getProductsByCategory(
    String categoryId, {
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<ProductModel>> getProductsBySubcategory(
    String subcategoryId, {
    int page = 0,
    int pageSize = 20,
  });
}

class CategoryDetailsRemoteDataSourceImpl
    implements CategoryDetailsRemoteDataSource {
  final ApiClient apiClient;

  CategoryDetailsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<SubcategoryModel>> getSubcategories(String categoryId) async {
    final response = await apiClient.get(
      ApiEndpoints.subCategoriesByCategory(categoryId),
    );

    final dynamic raw = response.data;
    final List<dynamic> data;

    if (raw is List) {
      data = raw;
    } else if (raw is Map && raw['data'] is List) {
      data = raw['data'] as List<dynamic>;
    } else {
      data = [];
    }

    return data
        .map((e) => SubcategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PaginatedResponse<ProductModel>> getProductsByCategory(
    String categoryId, {
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await apiClient.get(
      ApiEndpoints.productsByCategory(categoryId),
      queryParameters: {'page': page, 'size': pageSize},
    );
    return PaginatedResponse.fromJson(
      response.data,
      (json) => ProductModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<ProductModel>> getProductsBySubcategory(
    String subcategoryId, {
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await apiClient.get(
      ApiEndpoints.productsBySubcategory(subcategoryId),
      queryParameters: {'page': page, 'size': pageSize},
    );
    return PaginatedResponse.fromJson(
      response.data,
      (json) => ProductModel.fromJson(json),
    );
  }
}
