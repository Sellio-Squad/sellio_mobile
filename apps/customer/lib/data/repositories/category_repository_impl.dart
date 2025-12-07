import 'package:sellio_mobile/data/mappers/category_mapper.dart';

import '../../core/error/result.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/category_remote_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryRepositoryImpl({
    required CategoryRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<List<Category>>> getCategories() async {
    return RepositoryCallHandler.call<List<Category>>(() async {
      final categoryModels = await _remoteDataSource.getCategories();
      return categoryModels.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<Category>> getCategoryById(String categoryId) async {
    return RepositoryCallHandler.call<Category>(() async {
      final categoryModel = await _remoteDataSource.getCategoryById(categoryId);
      return categoryModel.toEntity();
    });
  }
}
