import '../../domain/core/failure.dart';
import '../../domain/core/result.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/local/category_local_datasource.dart';
import '../datasources/remote/category_remote_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;
  final CategoryLocalDataSource _localDataSource;

  CategoryRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      final categories = await _remoteDataSource.getCategories();

      // Cache categories
      await _localDataSource.cacheCategories(categories);

      return Success(categories.map((model) => model.toEntity()).toList());
    } catch (e) {
      // Try to get from cache
      try {
        final cachedCategories = await _localDataSource.getCachedCategories();
        if (cachedCategories.isNotEmpty) {
          return Success(
              cachedCategories.map((model) => model.toEntity()).toList());
        }
      } catch (cacheError) {
        // Cache failed
      }

      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Category>> getCategoryById(String categoryId) async {
    try {
      final category = await _remoteDataSource.getCategoryById(categoryId);
      return Success(category.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  Failure _mapExceptionToFailure(Object e) {
    final message = e.toString();

    if (message.contains('No internet connection') ||
        message.contains('Connection timeout')) {
      return const NetworkFailure();
    } else if (message.contains('Unauthorized')) {
      return const UnauthorizedFailure();
    } else if (message.contains('Not found')) {
      return const NotFoundFailure();
    } else if (message.contains('Server error')) {
      return ServerFailure(message: message);
    } else {
      return ServerFailure(message: message);
    }
  }
}
