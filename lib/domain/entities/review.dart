class Review {
  final String id;
  final String storeId;
  final String userId;
  final String userName;
  final String? userImage;
  final double rating;
  final String? comment;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.storeId,
    required this.userId,
    required this.userName,
    this.userImage,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  Review copyWith({
    String? id,
    String? storeId,
    String? userId,
    String? userName,
    String? userImage,
    double? rating,
    String? comment,
    DateTime? createdAt,
  }) {
    return Review(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}