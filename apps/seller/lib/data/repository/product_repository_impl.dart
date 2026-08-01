import 'package:core/core.dart';

import '../../domain/entity/create_product_params.dart';
import '../../domain/repository/product_repository.dart';
import '../datasource/product_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _dataSource;

  ProductRepositoryImpl({required ProductDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Result<void>> createProduct(AddProduct params) {
    return RepositoryCallHandler.callVoid(() async {
      await _dataSource.createProduct(params);
    });
  }
}
