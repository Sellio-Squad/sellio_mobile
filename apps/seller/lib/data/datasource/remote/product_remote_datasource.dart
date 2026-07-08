import 'package:core/core.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/create_product_params.dart';
import '../../core/api/api_endpoints.dart';
import '../product_datasource.dart';

class ProductRemoteDataSource implements ProductDataSource {
  final ApiClient _apiClient;

  ProductRemoteDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<void> createProduct(CreateProductParams params) async {
    // Construct FormData for multipart request
    final formDataMap = {
      'title': params.title,
      'description': params.description,
      'storeId': params.storeId,
      'categoryId': params.categoryId,
      'price': params.price,
      'isFeatured': params.isFeatured,
      'isAvailable': params.isAvailable,
      'subCategoryIds': params.subCategoryIds,
      'items': params.items.map((item) => item.toJson()).toList(),

      // Attach main image file
      'mainImageURL': await MultipartFile.fromFile(params.mainImagePath),

      // Attach additional image files
      'imageUrls': await Future.wait(
        params.additionalImagePaths.map((path) => MultipartFile.fromFile(path)),
      ),
    };

    final formData = FormData.fromMap(formDataMap);

    await _apiClient.post(
      ApiEndpoints.createProduct,
      data: formData,
    );
  }

  @override
  Future<String> getOwnerStoreId() async {
    final response = await _apiClient.get(ApiEndpoints.storeOwner);
    return response.data['id'] as String;
  }
}
