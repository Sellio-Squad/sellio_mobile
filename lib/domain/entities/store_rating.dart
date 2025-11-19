class StoreRating {
  final String storeId;
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution;

  const StoreRating({
    required this.storeId,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  StoreRating copyWith({
    String? storeId,
    double? averageRating,
    int? totalReviews,
    Map<int, int>? ratingDistribution,
  }) {
    return StoreRating(
      storeId: storeId ?? this.storeId,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      ratingDistribution: ratingDistribution ?? this.ratingDistribution,
    );
  }
}
