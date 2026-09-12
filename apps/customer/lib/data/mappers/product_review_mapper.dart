import '../../domain/entities/product_review.dart';
import '../models/product_review_model.dart';

extension ProductReviewModelMapper on ProductReviewModel {
  ProductReview toEntity() {
    return ProductReview(
      id: id,
      productId: productId,
      userId: userId ?? '',
      userName: userName ?? 'Customer',
      userImage: userImage,
      rating: rating ?? 0.0,
      comment: comment,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}