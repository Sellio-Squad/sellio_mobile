import '../../domain/entity/product.dart';

class MockProductRepository {
  final List<Product> _products = [
    const Product(
      id: '1',
      title: 'Regular T-Shirt',
      description: 'A comfortable cotton t-shirt',
      minPrice: 20.0,
      currency: 'USD',
      images: ['https://picsum.photos/200'],
      storeId: 'store1',
      categoryId: 'cat1',
      isUsed: false,
      isFeatured: true,
      stockQuantity: 50,
    ),
    const Product(
      id: '2',
      title: 'Thrift Jeans',
      description: 'Vintage denim jeans',
      minPrice: 35.0,
      currency: 'USD',
      images: ['https://picsum.photos/201'],
      storeId: 'store1',
      categoryId: 'cat2',
      isUsed: true,
      isFeatured: false,
      stockQuantity: 5,
    ),
    const Product(
      id: '3',
      title: 'Sneakers',
      description: 'Stylish urban sneakers',
      minPrice: 80.0,
      currency: 'USD',
      images: ['https://picsum.photos/202'],
      storeId: 'store1',
      categoryId: 'cat3',
      isUsed: false,
      isFeatured: false,
      stockQuantity: 12,
    ),
  ];

  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _products;
  }

  Future<void> deleteProduct(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _products.removeWhere((p) => p.id == id);
  }
}
