import '../../domain/entities/review.dart';
import '../models/review_model.dart';

extension ReviewModelMapper on ReviewModel {
  Review toEntity() {
    return Review(
      id: id,
      storeId: storeId,
      userId: userId,
      userName: userName,
      userImage: userImage,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
    );
  }
}