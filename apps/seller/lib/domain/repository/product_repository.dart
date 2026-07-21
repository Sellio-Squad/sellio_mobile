import 'package:core/error/result.dart';

import '../entities/create_product_params.dart';

abstract class ProductRepository {
  Future<Result<void>> createProduct(CreateProductParams params);

  Future<Result<String>> getOwnerStoreId();
}
