import 'package:core/error/result.dart';

import '../entity/create_product_params.dart';

abstract class ProductRepository {
  Future<Result<void>> createProduct(AddProduct params);

  Future<Result<String>> getOwnerStoreId();
}
