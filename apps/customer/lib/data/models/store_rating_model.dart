import '../../domain/entities/store_rating.dart';

class StoreRatingModel extends StoreRating {
  const StoreRatingModel({
    required super.storeId,
    required super.averageRating,
    required super.totalReviews,
    required super.ratingDistribution,
  });

  factory StoreRatingModel.fromJson(Map<String, dynamic> json) {
    final rawRatingsMap =
        json['ratingCategorize'] as Map<String, dynamic>? ?? {};

    final ratingsMap = rawRatingsMap.map(
      (key, value) => MapEntry(
        int.tryParse(key) ?? 0,
        (value as num).toInt(),
      ),
    );

    return StoreRatingModel(
      storeId: json['id'] as String,
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: json['totalRatings'] as int,
      ratingDistribution: ratingsMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': storeId,
      'averageRating': averageRating,
      'totalRatings': totalReviews,
      'ratingCategorize': ratingDistribution,
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
