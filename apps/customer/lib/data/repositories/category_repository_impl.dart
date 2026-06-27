import 'package:core/error/result.dart';
import 'package:sellio_mobile/data/mappers/category_mapper.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import 'package:core/core.dart';
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
