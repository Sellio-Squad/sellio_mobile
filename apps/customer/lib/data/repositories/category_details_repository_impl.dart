import 'package:core/error/result.dart';
import 'package:core/core.dart';
import 'package:sellio_mobile/data/datasource/remote/category_details_remote_datasource.dart';
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/entities/subcategory.dart';
import 'package:sellio_mobile/domain/repositories/category_details_repository.dart';

class CategoryDetailsRepositoryImpl implements CategoryDetailsRepository {
  final CategoryDetailsRemoteDataSource remoteDataSource;

  CategoryDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<Subcategory>>> getSubcategories(String categoryId) async {
    return RepositoryCallHandler.call<List<Subcategory>>(() async {
      final models = await remoteDataSource.getSubcategories(categoryId);
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Result<List<Product>>> getProductsByCategory(
    String categoryId, {
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final response = await remoteDataSource.getProductsByCategory(
        categoryId,
        page: page - 1,
        pageSize: limit,
      );
      return response.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<List<Product>>> getProductsBySubcategory(
    String subcategoryId, {
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final response = await remoteDataSource.getProductsBySubcategory(
        subcategoryId,
        page: page - 1,
        pageSize: limit,
      );
      return response.data.map((model) => model.toEntity()).toList();
    });
  }
}
