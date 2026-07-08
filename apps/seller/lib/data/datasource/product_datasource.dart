import '../../domain/entities/create_product_params.dart';

abstract class ProductDataSource {
  Future<void> createProduct(CreateProductParams params);

  Future<String> getOwnerStoreId();
}
