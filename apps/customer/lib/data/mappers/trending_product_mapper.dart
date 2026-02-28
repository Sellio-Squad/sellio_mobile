import '../../domain/entities/product.dart';
import '../models/product_summary_model.dart';

extension TrendingProductModelMapper on ProductSummaryModel {
  Product toEntity() {
    return Product(
      id: id,
      title: title,
      minPrice: price,
      isFavorite: isFavorite,
      maxDiscount: null,
      description: '',
      currency: '',
      images: [image],
      storeId: '',
      categoryId: '',
      items: [],
      isUsed: false,
      isFeatured: false,
    );
  }
}
