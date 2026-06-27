import 'package:core/error/failure.dart';
import 'package:core/error/result.dart';
import '../../domain/entities/category_section.dart';
import '../../domain/repositories/category_section_repository.dart';
import '../datasource/remote/category_section_remote_datasource.dart';

class CategorySectionRepositoryImpl implements CategorySectionRepository {
  final CategorySectionRemoteDataSource _remoteDataSource;

  CategorySectionRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<CategorySection>>> getActiveSections() async {
    try {
      final models = await _remoteDataSource.getActiveSections();
      final entities = models.map((m) => m.toEntity()).toList();
      return Success(entities);
    } catch (e) {
      return ResultFailure(ServerFailure(message: e.toString()));
    }
  }
}
