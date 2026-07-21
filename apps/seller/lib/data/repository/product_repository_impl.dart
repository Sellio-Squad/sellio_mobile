import 'package:core/core.dart';

import '../../domain/entities/create_product_params.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _dataSource;

  ProductRepositoryImpl({required ProductDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Result<void>> createProduct(CreateProductParams params) {
    return RepositoryCallHandler.callVoid(() async {
      await _dataSource.createProduct(params);
    });
  }

  @override
  Future<Result<String>> getOwnerStoreId() {
    return RepositoryCallHandler.call<String>(() async {
      return _dataSource.getOwnerStoreId();
    });
  }
}
