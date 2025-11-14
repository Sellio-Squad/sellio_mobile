import '../../domain/entities/store_rating.dart';

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
