import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:design_system/design_system.dart';
import '../../presentation/screens/home/sections/trending_products/models/product_summary_ui_model.dart';

part 'product_summary_model.freezed.dart';

@freezed
class ProductSummaryModel with _$ProductSummaryModel {
  const ProductSummaryModel._();

  const factory ProductSummaryModel({
    required String id,
    required String title,
    required double price,
    required String image,
    @Default(false) bool isFavorite,
  }) = _ProductSummaryModel;

  factory ProductSummaryModel.fromJson(Map<String, dynamic> json) {
    return ProductSummaryModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image']?.toString() ?? '',
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  ProductSummaryUIModel toUIModel() {
    return ProductSummaryUIModel(
      id: id,
      title: title,
      price: price.toString(),
      imageUrl: image.isNotEmpty ? image : AppImages.cartProduct,
      isFavorite: isFavorite,
    );
  }
}
