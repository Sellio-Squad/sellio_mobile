import 'package:core/core.dart';

import '../../domain/entity/category.dart';
import '../../domain/repository/category_repository.dart';
import '../datasource/remote/category_remote_datasource.dart';
import '../mappers/category_mapper.dart';

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
}
