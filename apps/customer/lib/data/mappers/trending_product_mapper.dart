import 'package:design_system/constants/app_images.dart';

import '../../domain/entities/product_summary.dart';
import '../models/product_summary_model.dart';

extension TrendingProductModelMapper on ProductSummaryModel {
  ProductSummary toEntity() {
    return ProductSummary(
      id: id,
      title: title,
      price: price,
      imageUrl: image.isNotEmpty ? image : AppImages.imgEmptyStoreImage,
      isFavorite: isFavorite,
      discount: null,
      discountText: '',
    );
  }
}
