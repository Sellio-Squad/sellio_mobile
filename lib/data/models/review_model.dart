import '../../domain/entities/StoreRating.dart';
import '../../domain/entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.id,
    required super.storeId,
    required super.userId,
    required super.userName,
    super.userImage,
    required super.rating,
    super.comment,
    required super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      storeId: json['storeId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImage: json['userImage'] as String?,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReviewModel.fromEntity(Review review) {
    return ReviewModel(
      id: review.id,
      storeId: review.storeId,
      userId: review.userId,
      userName: review.userName,
      userImage: review.userImage,
      rating: review.rating,
      comment: review.comment,
      createdAt: review.createdAt,
    );
  }

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

class StoreRatingModel extends StoreRating {
  const StoreRatingModel({
    required super.storeId,
    required super.averageRating,
    required super.totalReviews,
    required super.ratingDistribution,
  });

  factory StoreRatingModel.fromJson(Map<String, dynamic> json) {
    return StoreRatingModel(
      storeId: json['storeId'] as String,
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: json['totalReviews'] as int,
      ratingDistribution: Map<int, int>.from(json['ratingDistribution'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storeId': storeId,
      'averageRating': averageRating,
      'totalReviews': totalReviews,
      'ratingDistribution': ratingDistribution,
    };
  }

  factory StoreRatingModel.fromEntity(StoreRating rating) {
    return StoreRatingModel(
      storeId: rating.storeId,
      averageRating: rating.averageRating,
      totalReviews: rating.totalReviews,
      ratingDistribution: rating.ratingDistribution,
    );
  }

  StoreRating toEntity() {
    return StoreRating(
      storeId: storeId,
      averageRating: averageRating,
      totalReviews: totalReviews,
      ratingDistribution: ratingDistribution,
    );
  }
}
