import '../../domain/entity/create_product_params.dart';

abstract class ProductDataSource {
  Future<void> createProduct(AddProduct params);
}
